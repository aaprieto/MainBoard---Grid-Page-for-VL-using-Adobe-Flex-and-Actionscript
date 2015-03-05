<?php
# $Id: ae_ifvlexceptions.php,v 1.4 2011/07/06 20:45:26 clamat Exp $
/*****************************************************************************
	Application Environment		Visible Logistics

	Exceptions thrown and caught in Visible Logistics PHP code.
 
	Copyright 2011 Maves International Software
	ALL RIGHTS RESERVED  
*****************************************************************************/

class ClientException extends Exception
{
	private $_status = '400 Bad Request';

	public function getHttpStatusLine() {
		return 'HTTP/1.1 ' . $this->_status;
	}
}

class BadRequest extends ClientException
{
}

class Unauthorized extends ClientException
{
	private $_status = '401 Unauthorized';
}

class MethodNotAllowed extends ClientException
{
	private $_status = '405 Method Not Allowed';
}

class NotAcceptable extends ClientException
{
	private $_status = '406 Not Acceptable';
}

class ServerException extends Exception
{
	private $_status = '500 Internal Server Error';

	public function getHttpStatusLine() {
		return 'HTTP/1.1 ' . $this->_status;
	}
}

class NotImplemented extends ServerException
{
	private $_status = '501 Not Implemented';
}

class BadConfig extends ServerException
{
}

class SocketException extends Exception
{
	private $_host;
	private $_operation;
	private $_port;
	private $_status = '500 Internal Server Error';

	public function __construct( $message, $code, $op, $host, $port ) {

		$this->message		= $message;
		$this->code		= $code;
		$this->_host		= $host;
		$this->_operation	= $op;
		$this->_port		= $port;
	}

	public function getHttpStatusLine() {
		return 'HTTP/1.1 ' . $this->_status;
	}

	public function getLogEntry() {
		return	'Socket ' .
			$this->_operation .
			" of $this->_host:$this->_port failed:" .
			" $this->message ($this->code).";
	}
}

class NotFound extends Exception
{
	private $_status = '404 Not Found';

	public function __construct( $message, $code, $type, $name ) {

		$this->message	= "There is no $type named $name.";
		$this->code	= $code;
	}

	public function getHttpStatusLine() {
		return 'HTTP/1.1 ' . $this->_status;
	}
}
?>
