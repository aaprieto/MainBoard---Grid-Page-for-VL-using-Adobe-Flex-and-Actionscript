<?php
# $Id: ae_tlvl_ag2xls.php,v 1.1 2010/08/04 01:12:28 clamat Exp $
/*****************************************************************************
	Application Environment -- Visible Logistics

	Send POSTed action grid data back to browser as "ActionGrid.xls"
	file so the browser can pass it to Microsoft Excel or equivalent.

	Copyright 2009,2010 Maves International Software
	ALL RIGHTS RESERVED
------------------------------------------------------------------------------
Body of POST request must be the data in a format that Excel understands;
we do absolutely no processing or conversion of the body.
*****************************************************************************/

/*
 * Suggest to the browser that the file name should be "ActionGrid.xls".
 * Don't tell the browser that this is a Microsoft Excel spreadsheet,
 * because the client-side logic in Visible Logistics currently cheats and
 * sends us the data in HTML.  Just tell the browser that it's getting a
 * bag-o-bytes and let it use the file name extension (.xls) to figure out
 * that the file should go to Excel or equivalent.
 */
header( 'Content-disposition: attachment; filename="ActionGrid.xls"' );
header( 'Content-type: application/octet-stream' );

/* If we weren't invoked by POST, send nothing. */
if ( $_SERVER['REQUEST_METHOD'] != 'POST' )
	exit();

/*
 * If the request body exceeds the PHP "post_max_size" configuration
 * setting, the $_POST[] array and HTTP_RAW_POST_DATA variable won't be
 * set, but we can still open the php://input stream to get at the body.
 * Doing things this way lets us handle large request bodies even if
 * post_max_size is set to a low value.
 */
$ae_lvbodyin = fopen( 'php://input', 'r' );
if ( $ae_lvbodyin === false )
	exit();

/* Dump the request body out to the browser, as-is, with no changes. */
fpassthru( $ae_lvbodyin );

/* Be neat and close the handle to the request body. */
fclose( $ae_lvbodyin );
?>
