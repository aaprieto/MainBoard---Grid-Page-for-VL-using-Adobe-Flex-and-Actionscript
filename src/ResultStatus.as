	// ActionScript file
	import flash.events.Event;
	
	private function resultStatus(string_result:String, string_reason:String):String{
		var retstr:String = string_reason;
		PopUpManager.removePopUp(popwait);
		PopUpManager.removePopUp(myAlert);
		if (string_result == "EXPIRED"){
			retstr = "Session EXPIRED due to inactivity.  Please log out and log back in again to create a new session.";
		} 
		if (string_result == "FAIL"){
			retstr = string_reason;
		} 
		
		return retstr;
	}