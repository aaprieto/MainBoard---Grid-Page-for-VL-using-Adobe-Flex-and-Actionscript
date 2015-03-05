// ActionScript file
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
 
import mx.collections.*;
import mx.containers.HBox;
import mx.controls.*;
import mx.events.AdvancedDataGridEvent;
import mx.events.ListEvent;
import mx.managers.ToolTipManager;


			public var popalertmessage:AlertMessage;	
 			private function AlertMessageShow(string_message:String):void {
            	
               	popalertmessage = AlertMessage(
                PopUpManager.createPopUp(this, AlertMessage, true));
                popalertmessage.str_message = string_message;
               
   		    }


			public var popxmlalertmessage:XMLDisplayResult;	
			private function XMLAlertMessageShow(string_message:String, xml_message:String):void {
				
				popxmlalertmessage = XMLDisplayResult(
					PopUpManager.createPopUp(this, XMLDisplayResult, true));
				popxmlalertmessage.str_message = string_message;
				popxmlalertmessage.xml_str_message =  xml_message;
				
				
			}   