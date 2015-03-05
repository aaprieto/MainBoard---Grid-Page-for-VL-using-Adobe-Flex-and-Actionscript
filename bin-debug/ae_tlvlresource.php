<?php
# $Id: ae_tlvlresource.php,v 1.7 2011/09/28 15:56:44 aprarn Exp $
/*****************************************************************************
	Application Environment -- Visible Logistics

	Handle a request for a Visible Logistics resource from MainBoard.
 
	Copyright 2009,2010,2011 Maves International Software
	ALL RIGHTS RESERVED  
*****************************************************************************/

/*
 * Load the external pieces that we need.
 */
function ae_llinclude_error( $errno, $errstr, $errfile, $errline )
{
	header( 'HTTP/1.1 500 Internal Server Error.' );
	header( 'Content-type: text/plain' );

	echo "Internal Server Error\n";
	echo "Additional information may be available in the server logs.\n";

	error_log( 'ae_tlvlresource.php: ' . $errstr );

	exit;
}

set_error_handler( 'ae_llinclude_error' );

include 'ae_ifvlexceptions.php';

restore_error_handler();

$content_ext	= '.pdf';
$content_type	= 'application/pdf';
$ch_host	= '';
$ch_port	= '';
$method		= '';
$resource_format= 'PDF';
$resource_name	= '';
$resource_type	= '';
$resource_uri	= '';
$session_app	= 'vl';

try {
	@$ch_host = $_SERVER[ 'MIS_CH_HOST' ];

	if ( $ch_host == '' )
		throw new BadConfig( 'MIS_CH_HOST Not Set' );

	@$method = $_SERVER[ 'REQUEST_METHOD' ];

	switch ( $method ) {

		case 'GET':
			break;

		case 'POST':
		case 'PUT':
		case 'DELETE':
		case 'HEAD':
			throw new MethodNotAllowed();

		default;
			throw new NotImplemented();
	}

	@$resource_uri = $_SERVER[ 'REQUEST_URI' ];

	if	(
		preg_match	(
				',/mainboard/([^/]*)/(.*)$,',
				$resource_uri,
				$matches
				)
		) {
		$resource_type	= urldecode( $matches[ 1 ] );
		$resource_name	= urldecode( $matches[ 2 ] );
	}

	switch ( $resource_type ) {

		case "e-doc":
			$name2company = ',^([A-Z0-9]{2})-([^-]+-){2}[^-]+$,';
			break;

		default:
			throw new BadRequest( 'Unknown Resource Type' );
	}

	$req = new SimpleXMLElement( '<ezware_request/>' );
	$req->addChild( 'action', 'refreshData' );

	if ( preg_match( $name2company, $resource_name, $matches ) == 0 )
		throw new BadRequest( 'Invalid Resource Name' );

	$req->addChild( 'company', $matches[ 1 ] );

	$req->addChild	(
			'parameters',
			'REFRESH,' .
			$method .
			'|' .
			strtoupper( $resource_type ) .
			'|' .
			$resource_name .
			'|' .
			$resource_format
			);

	if ( session_start() === false )
		throw new ServerException( 'session_start() Failed' );

	if ( isset( $_SESSION[ 'app' ] ) )
		$session_app = $_SESSION[ 'app' ];

	$req->addChild( 'sid', session_id() );

	session_write_close();

	/*
	 * If we are in a MyLogistics session, we must send our request
	 * to the MyLogistics Hub.  Otherwise, we can assume that we are
	 * in a Visible Logistics session and send the request to the
	 * Communications Hub.
	 *
	 * Get contact port number and request keyword for appropriate
	 * hub.
	 */
	if ( $session_app == 'ml' ) {

		@$ch_port = $_SERVER[ 'MIS_ML_PORT' ];
		$hub_kwd = 'MIS_ML_REQUEST/v1/';
	} else {
		@$ch_port = $_SERVER[ 'MIS_CH_PORT' ];
		$hub_kwd = 'MIS_RD_REQUEST/v2/';
	}

	if ( preg_match( '/\d+/', $ch_port ) == 0 || $ch_port < 1 )
		throw new BadConfig( 'MIS_ML_PORT or MIS_CH_PORT not set.' );

	$req->addChild( 'version', '1' );

	$reqxml = $hub_kwd . $req->asXML();
	$reqlen = strlen( $reqxml );

	@$monitor = fsockopen( $ch_host, $ch_port, $errno, $errstr, 10 );
	if ( $monitor === false )
		throw new SocketException	(
						$errstr,	$errno,
						'fsockopen',
						$ch_host,	$ch_port
						);

	$written = fwrite( $monitor, $reqxml );
	if ( $written === false || $written < $reqlen ) {
		$errno	= socket_last_error( $monitor );
		$errstr	= socket_strerror( $errno );
		throw new SocketException	(
						$errstr,	$errno,
						'fwrite',
						$ch_host,	$ch_port
						);
	}

	$buf = stream_get_contents( $monitor );
	if ( $buf === false ) {
		$errno	= socket_last_error( $monitor );
		$errstr	= socket_strerror( $errno );
		throw new SocketException	(
						$errstr,	$errno,
						'stream_get_contents',
						$ch_host,	$ch_port
						);
	}

	fclose( $monitor );

	libxml_use_internal_errors( true );
	
	$resp = simplexml_load_string( $buf );

	if ( $resp === false )
		throw new ServerException( 'Response is not valid XML.' );

	if ( $resp->getName() != 'ezware_response' )
		throw new ServerException( 'Response not <ezware_response>.' );

	if ( $resp->status == 'EXPIRED' )
		throw new Unauthorized();
	elseif ( $resp->status != 'OK' )
		throw new ServerException( $resp->reason );

	/*
	 * An empty "refresh_data" element in the response is the backend
	 * server's way of telling us that we asked for a resource that
	 * does not exist.
	 */
	if ( $resp->refresh_data == '' )
		throw new NotFound('', 0, $resource_type, $resource_name );

	$doc = base64_decode( $resp->refresh_data );

	if ( $doc === false )
		throw new ServerException( 'refresh_data not valid Base64.' );

	header( 'Content-disposition: inline; filename="' .
		$resource_name . $content_ext . '"' );

	header( 'Content-type: ' . $content_type );

	echo $doc;

} catch( NotFound $e ) {

	header( $e->getHttpStatusLine() );
	header( 'Content-type: text/plain' );

	echo $e->getMessage();

} catch( ClientException $e ) {

	header( $e->getHttpStatusLine() );
	header( 'Content-type: text/plain' );

	echo "Internal Client Error.\n";
	echo "Additional information may be available in the server logs.\n";

	error_log( 'ae_tlvlresource.php: Client Error: ' . $e->getMessage() );

} catch( ServerException $e ) {

	header( $e->getHttpStatusLine() );
	header( 'Content-type: text/plain' );

	echo "Internal Server Error.\n";
	echo "Additional information may be available in the server logs.\n";

	error_log( 'ae_tlvlresource.php: Server Error: ' . $e->getMessage() );

} catch( SocketException $e ) {

	header( $e->getHttpStatusLine() );
	header( 'Content-type: text/plain' );

	echo "Internal Server Error.\n";
	echo "Additional information may be available in the server logs.\n";

	error_log( 'ae_tlvlresource.php: ' . $e->getLogEntry() );
}

exit;
?>
