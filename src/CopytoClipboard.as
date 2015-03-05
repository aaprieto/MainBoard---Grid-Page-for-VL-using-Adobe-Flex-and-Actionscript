// ActionScript file
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.ui.Keyboard;

import flashx.textLayout.formats.BackgroundColor;

import mx.collections.*;
import mx.containers.HBox;
import mx.controls.*;
import mx.core.ClassFactory;
import mx.core.IFactory;
import mx.events.AdvancedDataGridEvent;
import mx.events.ListEvent;
import mx.logging.errors.InvalidFilterError;
import mx.managers.PopUpManager;
import mx.managers.ToolTipManager;
import mx.states.SetStyle;

import spark.components.ComboBox;
import spark.components.TextInput;



private function copytoClipboard(event:Event):void {
	
		Alert.buttonWidth =141; 
		myAlert = Alert.show("","Database Refresh...",0,this,null,confirmIcon);  
		// modify the look of the Alert box
		myAlert.setStyle("backgroundColor", '#C3D9FA');
		myAlert.setStyle("borderColor", 0xffffff);
		myAlert.setStyle("borderAlpha", 0.75);
		myAlert.setStyle("fontSize", 14); 
		myAlert.setStyle("fontWeight", "bold");
		myAlert.setStyle("color", 0x000000); // text color    
		
		cb_sorted = new ArrayCollection;
		var ca_fieldname:String = new String;
		var ca_title:String = new String;
		var ca_datatype:String = new String;
		
		
		if (Array1.sort != null){
			cb_sorted = new ArrayCollection;
			for (var i:int=0;i < Array1.sort.fields.length; i++)  {
				var obj:Object = new Object();
				ca_fieldname = Array1.sort.fields[i].name.toString();
				
				for (var c:int=0;c<_xlcColumn.length;c++)  { 
					var datafield:String = (_xlcColumn[c]["dataField"]).toString();
					var datatype:String = (_xlcColumn[c]["datatype"]).toString();
					
					if (ca_fieldname == datafield){
					
						ca_datatype = (_xlcColumn[c]["datatype"]).toString();
						ca_title = (_xlcColumn[c]["title_header"]).toString();
						
					}
				}
				
				if (ca_datatype != 'N'){
					cb_sorted.addItem(ca_title);									
				}
			}	
		} 
		
		cb_sorted.refresh();
		arrsel = new ArrayCollection;
		var obj_arrsel:Object = new Object();
		
			if (cb_sorted.length <1){
				AlertMessageShow("Please select column(s) to sort.");
				Alert.buttonWidth =0; 
				PopUpManager.removePopUp(myAlert);
				return;
			} 
			for (var iy:int=0;iy < Array1.sort.fields.length; iy++)  {
				obj_arrsel = new Object();
				obj_arrsel.df = Array1.sort.fields[iy].name.toString();
				arrsel.addItem(obj_arrsel);
			}
			
			
			str = copytoclipboard.clipboardDetail(arrsel,dg);
			launch_copytoclipboard(event, str);
			//Alert.show(str);
		
		PopUpManager.removePopUp(myAlert);
	
}

private var copytoclipboardeditor:CopyToClipboardEditor;


private function launch_copytoclipboard(evt:Event, element:String):void {
	
	copytoclipboardeditor = CopyToClipboardEditor(
			PopUpManager.createPopUp(this, CopyToClipboardEditor,true));
	copytoclipboardeditor.dataelement = element;
	
	
	/*
		mbdg_pophoverinterface.helpfortitleheader = mbdg_objecthelpfortitle;
		mbdg_pophoverinterface.helpfortitle = mbdg_objecttitle;
		mbdg_pophoverinterface.object_type = mbdg_objecttitleheader;
		mbdg_pophoverinterface.loc_ccode = my_c_code;
		mbdg_pophoverinterface.loc_sid = session_id;
		mbdg_pophoverinterface.loc_appcode = application_entry;
		*/
	
	
}