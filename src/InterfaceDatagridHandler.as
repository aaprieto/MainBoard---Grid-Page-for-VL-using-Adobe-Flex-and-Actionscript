// ActionScript file

import flash.events.Event;
import flash.net.FileReference;

import mx.collections.*;
import mx.controls.*;



private function AssignOpsSubmit(event:Event):void {
	if (dg.selectedItems.length == 0){
		AlertMessageShow("Please select record(s).");
		return;
	}
	mx.core.Application.application.h_command.text = "AO";
	mx.core.Application.application.takeActionCommand(event);
	return;
}

private function DeAssignOpsSubmit(event:Event):void {
	if (dg.selectedItems.length == 0){
		AlertMessageShow("Please select record(s).");
		return;
	}
	mx.core.Application.application.h_command.text = "DO";
	mx.core.Application.application.takeActionCommand(event);
	return;
}
private	function howlong(str_char:String):String {
	var arg:String = new String();
	if (str_char.length==1) {
		arg = "0" + str_char;
		return arg;
	}
	else {
		arg = str_char;
		return arg;
	}
}
private	function getUpdDate():String {
	var param_ret:String = new String();
	var now:Date = new Date();
	
	var nMonth:String = (now.getMonth() + 1).toString();
	
	var nDate:String = now.getDate().toString();
	
	var nYear:String = now.getFullYear().toString();
	//Alert.show(nMonth);
	nMonth = howlong(nMonth);
	nDate = howlong(nDate);
	param_ret =  nYear + "-" + nMonth + "-" + nDate;
	return param_ret;
}
private	function getUpdTime():String {
	var param_ret:String = new String();
	var now:Date = new Date();
	var nHour:String = now.getHours().toString();
	var nMinutes:String = now.getMinutes().toString();
	var nSeconds:String = now.getSeconds().toString();
	nHour = howlong(nHour);
	nMinutes = howlong(nMinutes);
	nSeconds = howlong(nSeconds);
	param_ret = nHour + ":" + nMinutes + ":"+ nSeconds;
	
	return param_ret;
}
private function DDAcess(event:Event):void {
	var vertical_scroll_position:int;
	var horizontal_scroll_position:int;
	var fulldate:String = new String();
	var fulltime:String = new String();	
	fulldate = getUpdDate();
	fulltime = getUpdTime();
	if (dg.selectedItems.length == 0){
		//Alert.show("Please select record(s).");
		AlertMessageShow("Please select record(s).");
		return;
	}
	
	vertical_scroll_position = dg.verticalScrollPosition;
	horizontal_scroll_position = dg.horizontalScrollPosition;
	
	for (var i:int=0;i<dg.selectedItems.length;i++){
		
		dg.selectedItems[i][_xlcColumn[0]["dataField"]] = 'Y';
		dg.selectedItems[i][_xlcColumn[_xlcColumn.length - 4]["dataField"]] = fulldate;
		dg.selectedItems[i][_xlcColumn[_xlcColumn.length - 3]["dataField"]] = fulltime;
		//	Array1.refresh();
		
		// I don't understand to why the access doesn't change at single pass on a random highlight of rows, that's why I have to
		// create a second pass to make it work.. so weird.  I will get back into this when I get
		/// the answer.
		dg.selectedItems[i][_xlcColumn[0]["dataField"]] = 'Y';
		dg.selectedItems[i][_xlcColumn[_xlcColumn.length - 4]["dataField"]] = fulldate;
		dg.selectedItems[i][_xlcColumn[_xlcColumn.length - 3]["dataField"]] = fulltime;
		//	Array1.refresh();
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		
		/*
		dg.selectedItems[i][_xlcColumn[_xlcColumn.length-2]["dataField"]] = 'Y';
		Array1.refresh();
		
		// I don't understand to why the access doesn't change at single pass on a random highlight of rows, that's why I have to
		// create a second pass to make it work.. so weird.  I will get back into this when I get
		/// the answer.
		dg.selectedItems[i][_xlcColumn[_xlcColumn.length-2]["dataField"]] = 'Y';
		Array1.refresh();
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		*/
	} 
	Array1.refresh();
	dg.verticalScrollPosition = vertical_scroll_position;
	dg.horizontalScrollPosition = horizontal_scroll_position;
	return;
	
}

private function DDDeny(event:Event):void {
	var vertical_scroll_position:int;
	var horizontal_scroll_position:int;
	var fulldate:String = new String();
	var fulltime:String = new String();	
	fulldate = getUpdDate();
	fulltime = getUpdTime();
	
	if (dg.selectedItems.length == 0){
		//Alert.show("Please select record(s).");
		AlertMessageShow("Please select record(s).");
		return;
	}
	
	
	vertical_scroll_position = dg.verticalScrollPosition;
	horizontal_scroll_position = dg.horizontalScrollPosition;
	for (var i:int=0;i<dg.selectedItems.length;i++){
		dg.selectedItems[i][_xlcColumn[0]["dataField"]] = 'N';
		dg.selectedItems[i][_xlcColumn[_xlcColumn.length - 4]["dataField"]] = fulldate;
		dg.selectedItems[i][_xlcColumn[_xlcColumn.length - 3]["dataField"]] = fulltime;
		//	Array1.refresh();
		
		// I don't understand to why the access doesn't change at single pass on a random highlight of rows, that's why I have to
		// create a second pass to make it work.. so weird.  I will get back into this when I get
		/// the answer.
		dg.selectedItems[i][_xlcColumn[0]["dataField"]] = 'N';
		dg.selectedItems[i][_xlcColumn[_xlcColumn.length - 4]["dataField"]] = fulldate;
		dg.selectedItems[i][_xlcColumn[_xlcColumn.length - 3]["dataField"]] = fulltime;
		//	Array1.refresh();
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/*
		dg.selectedItems[i][_xlcColumn[_xlcColumn.length-2]["dataField"]] = 'N';
		Array1.refresh();
		
		// I don't understand to why the access doesn't change at single pass on a random highlight of rows, that's why I have to
		// create a second pass to make it work.. so weird.  I will get back into this when I get
		/// the answer.
		dg.selectedItems[i][_xlcColumn[_xlcColumn.length-2]["dataField"]] = 'N';
		Array1.refresh();
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		*/	     
	}     
	Array1.refresh();
	dg.verticalScrollPosition = vertical_scroll_position;
	dg.horizontalScrollPosition = horizontal_scroll_position;
	return;
	
}


private function DDSubmit(event:Event):void {
	
	OpSecSendXML(event); 
	
}
import mx.controls.Alert;
import mx.graphics.codec.JPEGEncoder;
private var file:FileReference = new FileReference();

private function ExportToExcel_old(event:Event):void{
	var xm:XML = new XML;
	var str:String = '<?xml version="1.0" encoding="utf-8"?><data><row Probill="L1442480" Flag="I" Appt_Date="2008-04-07" Appt_Time="" Weight="4764" Pieces="397" Del_Appt_Date="2008-04-09" Del_Appt_Time="21:45" Current_Zone="C1" From_Zone="C1" To_Zone="B5" Status="WOP" Pref_Carrier="RLS" Del_Ontime=""/><row Probill="L1442481" Flag="D" Appt_Date="2008-04-07" Appt_Time="" Weight="4764" Pieces="397" Del_Appt_Date="2008-04-09" Del_Appt_Time="21:45" Current_Zone="C1" From_Zone="C1" To_Zone="B5" Status="BAR" Pref_Carrier="ARN" Del_Ontime="Test"/><row Probill="L144248D" Flag="I" Appt_Date="2008-04-07" Appt_Time="" Weight="4764" Pieces="397" Del_Appt_Date="2008-04-09" Del_Appt_Time="21:45" Current_Zone="C1" From_Zone="C2" To_Zone="B3" Status="ARN" Pref_Carrier="OLD" Del_Ontime="More"/></data>';
	xm = new XML(str); 
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////


/**
 * Simple script to convert a Datagrid to a HTML table and then 
 * pass it on to an external excel exporter
 *
 * @author: S.Radovanovic (With help of Tracy Spratt through the post on
 *          http://www.cflex.net/showFileDetails.cfm?ObjectID=298&Object=File&ChannelID=1)
 */    

//Libs that are mostly used 
//(only a number are necessary for the datagrid conversion and export)
import mx.controls.Alert;
import mx.core.UIComponent;
import mx.core.Container;
import mx.events.ItemClickEvent;
import mx.utils.ObjectProxy;
import flash.errors.*;
import flash.events.*;
import flash.external.*;		
import flash.net.URLLoader;
import flash.net.URLVariables;
import flash.net.URLRequest;

//The location of the excel export file
import mx.events.CloseEvent;
import mx.states.RemoveChild;
import spark.effects.RemoveAction;
import mx.containers.HBox;
import flash.ui.Mouse;
import mx.rpc.events.ResultEvent;
import flash.ui.Keyboard;

//public var urlExcelExport:String = "exportexcel.php"; 
public var urlExcelExport:String = "ae_tlvl_ag2xls.php"; 


/**
 * Convert the datagrid to a html table
 * Styling etc. can be done externally
 * 
 * @param: dg Datagrid Contains the datagrid that needs to be converted
 * @returns: String
 */
private function convertDGToHTMLTable_test(event:Event):String{
	//Set default values
	
	var font:String = dg.getStyle('fontFamily');
	//var size:String = dg.getStyle('fontSize');
	var size:String = '8';
	var str:String = '';
	var colors:String = '';
	var style:String = 'style="font-family:'+font+';font-size:'+size+'pt;"';
	var hcolor:Array;
	
	//Retrieve the headercolor
	if(dg.getStyle("headerColor") != undefined) {
		hcolor = [dg.getStyle("headerColor")];
	} else {
		hcolor = dg.getStyle("headerColors");
	}				
	
	//Set the htmltable based upon knowledge from the datagrid
	str+= '<table width="'+dg.width+'"><thead><tr width="'+dg.width+'" style="background-color:#' +Number((hcolor[0])).toString(16)+'">';
	
	//Set the tableheader data (retrieves information from the datagrid header				
	for(var i:int = 0;i<dg.columns.length;i++) {
		colors = dg.getStyle("themeColor");
		
		if(dg.columns[i].headerText != undefined) {
			str+="<th "+style+">"+dg.columns[i].headerText+"</th>";
		} else {
			str+= "<th "+style+">"+dg.columns[i].dataField+"</th>";
		}
	}
	str += "</tr></thead><tbody>";
	colors = dg.getStyle("alternatingRowColors");
	
	//Loop through the records in the dataprovider and 
	//insert the column information into the table
	
	for(var j:int =0;j<dg.dataProvider.length;j++) {					
		str+="<tr width=\""+Math.ceil(dg.width)+"\">";
		
		for(var k:int=0; k < dg.columns.length; k++) {
			
			//Do we still have a valid item?				
			
			if(dg.dataProvider.getItemAt(j) != undefined && dg.dataProvider.getItemAt(j) != null) {
				
				//Check to see if the user specified a labelfunction which we must
				//use instead of the dataField
				
				if(dg.columns[k].labelFunction != undefined) {
					//sAlert.show(dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField));
					str += "<td width=\""+Math.ceil(dg.columns[k].width)+"\" "+style+">"+dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField)+"</td>";
					
				} else {
					
					//dg.columns[k].labelFunction = '';
					//Our dataprovider contains the real data
					//We need the column information (dataField)
					//to specify which key to use.
					//	Alert.show(dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]);
					if ((dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == null || (dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == undefined || (dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == ''){
						dg.dataProvider.getItemAt(j)[dg.columns[k].dataField] = '';
					} 
					str += "<td width=\""+Math.ceil(dg.columns[k].width)+"\" "+style+">" +dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]+"</td>";
					
				}
			} 
			////////////////
			//else {
			//		Alert.show(dg.dataProvider.getItemAt(j));
			//		//dg.dataProvider.getItemAt(j) = '';
			//}
			/////////////////////////
		}
		str += "</tr>";
		
	}
	str+="</tbody></table>";
	
	return str; 
}
/**
 * Load a specific datagrid into Excel
 * This method passes the htmltable string to an backend script which then
 * offers the excel download to the user.
 * The reason for not using a copy to clipboard and then javascript to
 * insert it into Excel is that this mostly will fail because of the user
 * setup (Webbrowser configuration).
 * 
 * @params: dg Datagrid The Datagrid that will be loaded into Excel
 */
private function loadDGInExcel_test(event:Event):void{
	
	//Pass the htmltable in a variable so that it can be delivered
	//to the backend script
	var variables:URLVariables = new URLVariables(); 
	variables.htmltable	= convertDGToHTMLTable(event);
	
	//Setup a new request and make sure that we are 
	//sending the data through a post
	var u:URLRequest = new URLRequest(urlExcelExport);
	
	u.data = variables; //Pass the variables
	u.method = URLRequestMethod.POST; //Don't forget that we need to send as POST
	
	//Navigate to the script
	//We can use _self here, since the script will through a filedownload header
	//which results in offering a download to the user (and still remaining in you Flex app.)
	navigateToURL(u,"_self");
}      

private function convertDGToHTMLTable(event:Event):void {
	//exporttoexcel.addEventListener(CustomEvent.BUTTON_CLICKED,  testexcel); 
	
	/*  Fire Alert for Waiting Display */
	//addEventListener(CustomEvent.BUTTON_CLICKED,  testexcel);
	//addEventListener(CustomEvent.BUTTON_CLICKED,  testexcel);
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
	
	
	
	//	var arrsel:ArrayCollection = new ArrayCollection;
	arrsel = new ArrayCollection;
	var obj_arrsel:Object = new Object();
	
	// All Columns
	
	if ((event.currentTarget.id == 'img_export_all_to_excel')||(event.currentTarget.id == 'lbl_export_all_to_excel')){
		//if (pop9.rb_chooseall.selected == true){
		for (var h:int=0;h < _xlcColumn.length; h++)  {
			obj_arrsel = new Object();
			obj_arrsel.df = _xlcColumn[h].dataField;
			obj_arrsel.dt = _xlcColumn[h].datatype;
			arrsel.addItem(obj_arrsel);
		}
	}
	
	//  Only Selected Columns  
	if ((event.currentTarget.id == 'img_export_sorted_to_excel')||(event.currentTarget.id == 'lbl_export_sorted_to_excel')){
		if (cb_sorted.length <1){
			AlertMessageShow("Please select column(s) to sort.");
			Alert.buttonWidth =0; 
			PopUpManager.removePopUp(myAlert);
			return;
		} 
		for (var iy:int=0;iy < Array1.sort.fields.length; iy++)  {
			 
			obj_arrsel = new Object();
			obj_arrsel.df = Array1.sort.fields[iy].name.toString();
			
			for (var a:int=0;a < _xlcColumn.length; a++)  {
				if(Array1.sort.fields[iy].name == _xlcColumn[a].dataField){
					obj_arrsel.dt = _xlcColumn[a].datatype;
					break;
				}
			} 
			
			//obj_arrsel.dt = Array1.sort.fields[iy].datatype.toString();
			arrsel.addItem(obj_arrsel);
		}
		
	}
	var font:String = dg.getStyle('fontFamily');
	var size:String = '10';
	str = '';
	var colors:String = '';
	var style:String = new String();
	var hcolor:Array;
	//Retrieve the headercolor
	if(dg.getStyle("headerColor") != undefined) {
		hcolor = [dg.getStyle("headerColor")];
	} else {
		hcolor = dg.getStyle("headerColors");
	}				
	style = 'style="font-family:'+font+';font-size:'+size+'pt;background-color:#'+Number((hcolor[0])).toString(16)+'"';
	str+= '<table border="true" ><thead><tr width="'+dg.width+'">';
	/* create header excel */
	str+= exporttoexcel.excelheader(arrsel, dg, hcolor);
	style = 'style="font-family:'+font+';font-size:'+size+'pt;"';
	str += "</tr></thead><tbody>"; 
	colors = dg.getStyle("alternatingRowColors");
	str+= exporttoexcel.excelDetail(arrsel,dg);
	str+="</tbody></table>";
	str = '<html><head></head><body>' + str + '</body></html>'
	var u:URLRequest = new URLRequest(urlExcelExport);
	//  Changes to Flash Version 14.0.0.145         
	//u.contentType = 'text/html';  
	u.data = str; //Pass the variables
	u.method = URLRequestMethod.POST; //Don't forget that we need to send as POST
	Alert.buttonWidth =141; 
	PopUpManager.removePopUp(myAlert);
	navigateToURL(u,"_self"); 
	
	
	  
}
private function testexcel():void{
	Alert.show("Where did I go wrong? Simply alone on the bitternes.");
}
private function excelHeaderLoop(str:String, arrsel:ArrayCollection):String{
	
	var ayt_ctr:int = 0;
	
	for(var j:int =0;j<dg.dataProvider.length;j++) {	
		ayt_ctr = ayt_ctr + 1;
		str+="<tr>";
		str+=  excelDetailLoop(arrsel, j);
		str += "</tr>";
		//if (ayt_ctr == 50){
		//dispatchEvent( new CustomEvent( CustomEvent.DATA_LOADED, false, false, str ) );
		//AlertMessageShow(str);
		//}
	}
	return str;
}

private function excelDetailLoop(arrsel:ArrayCollection, j:int):String{
	
	var str:String = new String();
	for	(var ib:int = 0;ib<(arrsel.length);ib++){ 	
		for(var k:int=0; k < (dg.columns.length - 1); k++) {
			if (arrsel[ib].df == dg.columns[k].dataField){ 
				//Do we still have a valid item?				
				if(dg.dataProvider.getItemAt(j) != undefined && dg.dataProvider.getItemAt(j) != null) {
					//Check to see if the user specified a labelfunction which we must
					//use instead of the dataField
					if(dg.columns[k].labelFunction != undefined) {
						str += "<td>"+dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField)+"</td>";
						
					} else {
						//Our dataprovider contains the real data
						//We need the column information (dataField)
						//to specify which key to use.
						if ((dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == null || (dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == undefined || (dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == ''){
							dg.dataProvider.getItemAt(j)[dg.columns[k].dataField] = '';
						} 
						str += "<td>" +dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]+"</td>";
					}
				} 
				break;
			}
		}
		
		
	}
	return str;
	
}	
private function convertDGToHTMLTable_correctmethod(event:Event):void {
	//Alert.show("go here");
	/*  Fire Alert for Waiting Display */
	
	/*
	Alert.buttonWidth =0; 
	myAlert = Alert.show("","Database Refresh...",0,this,null,confirmIcon);  
	// modify the look of the Alert box
	myAlert.setStyle("backgroundColor", '#C3D9FA');
	myAlert.setStyle("borderColor", 0xffffff);
	myAlert.setStyle("borderAlpha", 0.75);
	myAlert.setStyle("fontSize", 14); 
	myAlert.setStyle("fontWeight", "bold");
	myAlert.setStyle("color", 0x000000); // text color    
	*/
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
	
	
	
	var arrsel:ArrayCollection = new ArrayCollection;
	var obj_arrsel:Object = new Object();
	
	// All Columns
	if ((event.currentTarget.id == 'img_export_all_to_excel')||(event.currentTarget.id == 'lbl_export_all_to_excel')){
		//if (pop9.rb_chooseall.selected == true){
		for (var h:int=0;h < _xlcColumn.length; h++)  {
			obj_arrsel = new Object();
			obj_arrsel.df = _xlcColumn[h].dataField;
			obj_arrsel.dt = _xlcColumn[h].datatype;
			arrsel.addItem(obj_arrsel);
		}
	}
	
	//  Only Selected Columns  
	if ((event.currentTarget.id == 'img_export_sorted_to_excel')||(event.currentTarget.id == 'lbl_export_sorted_to_excel')){
		//if (pop9.rb_onlycolumns.selected == true){ 
		if (cb_sorted.length <1){
			AlertMessageShow("Please select column(s) to sort.");
			return;
		} 
		for (var iy:int=0;iy < Array1.sort.fields.length; iy++)  {
			obj_arrsel = new Object();
			obj_arrsel.df = Array1.sort.fields[iy].name.toString();
			//obj_arrsel.dt = Array1.sort.fields[iy].datatype.toString();
			for (var a:int=0;a < _xlcColumn.length; a++)  {
				if(Array1.sort.fields[iy].name == _xlcColumn[a].dataField){
					obj_arrsel.dt = _xlcColumn[a].datatype;
					break;
				}
			}
			arrsel.addItem(obj_arrsel);
		}
		
	}
	
	var font:String = dg.getStyle('fontFamily');
	var size:String = '10';
	var str:String = '';
	var colors:String = '';
	//var style:String = 'style="font-family:'+font+';font-size:'+size+'pt;"';
	var style:String = new String();
	var hcolor:Array;
	//Retrieve the headercolor
	if(dg.getStyle("headerColor") != undefined) {
		hcolor = [dg.getStyle("headerColor")];
	} else {
		hcolor = dg.getStyle("headerColors");
	}				
	style = 'style="font-family:'+font+';font-size:'+size+'pt;background-color:#'+Number((hcolor[0])).toString(16)+'"';
	//str+= '<table border="true" width="'+dg.width+'"><thead '+ style + '><tr width="'+dg.width+'">';
	//str+= '<table border="true" ><thead '+'style="background-color:blue"><tr width="'+dg.width+'">';
	str+= '<table border="true" ><thead><tr width="'+dg.width+'">';
	for	(var ia:int = 0;ia<(arrsel.length);ia++) {
		for(var i:int = 0;i<(dg.columns.length - 1);i++) {
			
			if (arrsel[ia].df == dg.columns[i].dataField){
				colors = dg.getStyle("themeColor");
				
				if(dg.columns[i].headerText != undefined) {
					//style = 'style="font-family:'+font+';font-size:'+size+'pt;background-color:#'+Number((hcolor[0])).toString(16)+'"';
					
					//str+="<th "+style+">"+dg.columns[i].headerText+"</th>";
					str+="<th "+"style='background-color:#"+Number((hcolor[0])).toString(16)+"' width=\""+Math.ceil(dg.columns[i].width)+"\" "+">"+dg.columns[i].headerText+"</th>";
					//str+="<th width=\""+Math.ceil(dg.columns[i].width)+"\" "+">"+dg.columns[i].headerText+"</th>";
					//	str+="<th "+style+"background-color:#'" + Number((hcolor[0])).toString(16)+ "'>"+dg.columns[i].headerText+"</th>";
					//style="background-color:#' +Number((hcolor[0])).toString(16)+'
					//style = 'style="font-family:'+font+';font-size:'+size+'pt;"';
				} else {
					//style = 'style="font-family:'+font+';font-size:'+size+'pt;"';
					//str+= "<th "+style+">"+dg.columns[i].dataField+"</th>";
					str+= "<th "+"style='background-color:#"+Number((hcolor[0])).toString(16)+"' width=\""+Math.ceil(dg.columns[i].width)+"\" "+">"+dg.columns[i].dataField+"</th>";
					//str+= "<th width=\""+Math.ceil(dg.columns[i].width)+"\" "+">"+dg.columns[i].dataField+"</th>";
					//	str+="<th "+style+"background-color:#'" + Number((hcolor[0])).toString(16)+ "'>"+dg.columns[i].dataField+"</th>";
				}
				break;
			}
			
		}
	}	
	style = 'style="font-family:'+font+';font-size:'+size+'pt;"';
	//str += "</tr></thead><tbody "+ style + ">"; 
	str += "</tr></thead><tbody>"; 
	colors = dg.getStyle("alternatingRowColors");
	//Loop through the records in the dataprovider and 
	//insert the column information into the table
	for(var j:int =0;j<dg.dataProvider.length;j++) {					
		//str+="<tr width=\""+Math.ceil(dg.width)+"\">";
		str+="<tr>";
		for	(var ib:int = 0;ib<(arrsel.length);ib++){ 	
			for(var k:int=0; k < (dg.columns.length - 1); k++) {
				if (arrsel[ib].df == dg.columns[k].dataField){
					//Do we still have a valid item?				
					if(dg.dataProvider.getItemAt(j) != undefined && dg.dataProvider.getItemAt(j) != null) {
						//Check to see if the user specified a labelfunction which we must
						//use instead of the dataField
						if(dg.columns[k].labelFunction != undefined) {
							//sAlert.show(dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField));
							//str += "<td width=\""+Math.ceil(dg.columns[k].width)+"\" "+style+">"+dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField)+"</td>";
							//str += "<td width=\""+Math.ceil(dg.columns[k].width)+"\" "+">"+dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField)+"</td>";
							str += "<td>"+dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField)+"</td>";
							
						} else {
							//Our dataprovider contains the real data
							//We need the column information (dataField)
							//to specify which key to use.
							if ((dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == null || (dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == undefined || (dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == ''){
								dg.dataProvider.getItemAt(j)[dg.columns[k].dataField] = '';
							} 
							//str += "<td width=\""+Math.ceil(dg.columns[k].width)+"\" "+style+">" +dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]+"</td>";
							//str += "<td width=\""+Math.ceil(dg.columns[k].width)+"\" "+">" +dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]+"</td>";
							str += "<td>" +dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]+"</td>";
						}
					} 
					break;
				}
			}
		}  
		str += "</tr>";
	}
	str+="</tbody></table>";
	str = '<html><head></head><body>' + str + '</body></html>'
	//System.setClipboard(str);  
	//AlertMessageShow("Saved to ClipBoard.  Please open up your Excel and do a Paste process.");
	//if (ExternalInterface.available) {
	//	ExternalInterface.call('openExcel');
	///} else {
	//	AlertMessageShow("Browser not available");
	//}
	//Alert.buttonWidth =141; 
	//PopUpManager.removePopUp(myAlert);
	
	//var request:URLRequest = new URLRequest('javascript:openExcel()');
	//navigateToURL(request, '_blank');
	
	
	//AlertMessageShow(str);   
	//  Remove the variable for now.  //
	//var variables:URLVariables = new URLVariables(); 
	//variables.htmltable	= str;
	//Setup a new request and make sure that we are 
	//sending the data through a post
	var u:URLRequest = new URLRequest(urlExcelExport);
	u.contentType = 'text/html';
	u.data = str; //Pass the variables
	u.method = URLRequestMethod.POST; //Don't forget that we need to send as POST
	//Navigate to the script
	//We can use _self here, since the script will through a filedownload header
	//which results in offering a download to the user (and still remaining in you Flex app.)
	//PopUpManager.removePopUp(popwait);
	
	navigateToURL(u,"_self"); 
	
	//	PopUpManager.removePopUp(myAlert);
}

/**
 * Load a specific datagrid into Excel
 * This method passes the htmltable string to a backend script which then
 * offers the excel download to the user.
 * The reason for not using a copy to clipboard and then javascript to
 * insert it into Excel is that this mostly will fail because of the user
 * setup (Webbrowser configuration).
 * 
 * @params: dg Datagrid The Datagrid that will be loaded into Excel
 */
private function loadDGInExcel(event:Event):void {
	
	//Pass the htmltable in a variable so that it can be delivered
	//to the backend script
	var variables:URLVariables = new URLVariables(); 
	variables.htmltable	= convertDGToHTMLTable(event);
	
	//Setup a new request and make sure that we are 
	//sending the data through a post
	var u:URLRequest = new URLRequest(urlExcelExport);
	
	u.data = variables; //Pass the variables
	u.method = URLRequestMethod.POST; //Don't forget that we need to send as POST
	
	//Navigate to the script
	//We can use _self here, since the script will through a filedownload header
	//which results in offering a download to the user (and still remaining in you Flex app.)
	navigateToURL(u,"_self");
}       


private function validate_copy_group(event:Event):void{
	if (dg.selectedItems.length == 0){
		AlertMessageShow("Please select a record.");
		return;
	}
	if (dg.selectedItems.length > 1){
		AlertMessageShow("You can only select one record.");
		return;
	}
	g_my_action =  "refreshData";
	reqParms = "REFRESH,COPYGROUP,VER_GRP_FR," + (dg.selectedItem[(_xlcColumn[_xlcColumn.length-2]["dataField"])]); 
	validate_copytogroup.send();  
}
public var popActions:Actions;
private function launchActions(event:Event):void{
	popActions = Actions( 
		PopUpManager.createPopUp(this, Actions, true));
	popActions["btn_ac_clear"].addEventListener("click", help_clear);
	popActions["btn_ac_clear"].addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
	popActions["btn_ac_clear"].addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
	
	popActions["btn_ac_reset"].addEventListener("click", action_reset);
	popActions["btn_ac_reset"].addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
	popActions["btn_ac_reset"].addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
	
	popActions["btn_ac_keepsel"].addEventListener("click", choose);
	popActions["btn_ac_keepsel"].addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
	popActions["btn_ac_keepsel"].addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
	
	popActions["btn_ac_discardsel"].addEventListener("click", lose);
	popActions["btn_ac_discardsel"].addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
	popActions["btn_ac_discardsel"].addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
	
	popActions["btn_ac_selectall"].addEventListener("click", selectAll);
	popActions["btn_ac_selectall"].addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
	popActions["btn_ac_selectall"].addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
	
	popActions["btn_ac_multifilter"].addEventListener("click", launchMultipleFilter);
	popActions["btn_ac_multifilter"].addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
	popActions["btn_ac_multifilter"].addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
	
	popActions["btn_ac_unsort"].addEventListener("click", refreshSort);
	popActions["btn_ac_unsort"].addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
	popActions["btn_ac_unsort"].addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
	
	popActions["btn_ac_totalsel"].addEventListener("click", TotalSelected);
	popActions["btn_ac_totalsel"].addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
	popActions["btn_ac_totalsel"].addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
} 
private function action_reset(event:Event):void{
	filterDescription_persistent=''; 
	filterDescription_transient='';
//	//	cb_filter_macro.selectedIndex = -1;
//	// 	cb_filter_macro_persistent.selectedIndex = -1;
	//initializePanel();
	lbl_persistent_view.text = 'No selection';
	lbl_transient_view.text = 'No selection';
	//  Remove this for now. 3/11/2013
	//erase(event);
	
	
	// Remove this for now. 3/11/2013
//	dataList2_trigger(event, true);
	  
	
	
	executePersistentDefault(event);
	PopUpManager.removePopUp(pop_okCancel);
	PopUpManager.removePopUp(popActions);
	removeMe_2(event);
} 


private function return_to_base(event:Event):void{

	var flag:Boolean = false;
	for (var i:int=0;i<arr_myviewbuttons.length;i++){
		if (arr_myviewbuttons[i]['viewcode'] == 'BASE'){
			flag = true;
			
			break;
		}
	}
	
	if (flag == false){
		AlertMessageShow("No BASE Setup.  Please contact your Administrator.");
		return;
	} else {
		
		
		pop_deleteconfirm = DeleteConfirm(
			PopUpManager.createPopUp(this, DeleteConfirm, true));
		pop_deleteconfirm.del_filtercode = "BASE";
		pop_deleteconfirm.header_label.text = "Confirm Apply to BASE";
		pop_deleteconfirm.question_label.text = "Are you sure you want to apply to BASE?"
		pop_deleteconfirm.question_label_two.text = "Please type 'YES' to confirm."
		pop_deleteconfirm["btn_ok"].addEventListener("click",  handleApplyBase);
		pop_deleteconfirm["inputcode"].addEventListener("enter", handleApplyBase);
		
		
	
	}
	
}
private function handleApplyBase(event:Event):void{
	
	if (pop_deleteconfirm.inputcode.text == "YES"){
		retfromrendition = true;
		reqParms = "REFRESH,RETRIEVE|GRIDHEADERDOC2|" + myName_main + "|" + toxml_mbdcode + "|BASE|";
		_xlcRenditionCode = "BASE";  
		propertiesList.send();
		PopUpManager.removePopUp(pop_deleteconfirm);
		removeMe_2(event);
	}	
	if (pop_deleteconfirm.inputcode.text != "YES"){
		
		pop_deleteconfirm.inputcode.setFocus();
		pop_deleteconfirm.inputcode.drawFocus(true);
		return;
		
	}
	
	
	

}
[Bindable]
public var rettype:String;


private function historyParameterInput():void{   
	historyParametersQuery = new ArrayCollection;
	var newObj:Object = new Object;
	
	for (var i:int=0;i<pophrmp.myDPColl.length;i++){
		
		var lc_val:String = pophrmp.myDPColl[i].value;
		lc_val = c_utils.trim(lc_val);
		if (lc_val.length > 0){
			
			newObj = new Object;
			newObj.hp_dataField = pophrmp.myDPColl[i].dataField;
			newObj.hp_datatype = pophrmp.myDPColl[i].datatype
			newObj.hp_value = pophrmp.myDPColl[i].value;
			historyParametersQuery.addItem(newObj);   
		}
	}
	
	
}
private function closehistoryNewRetrieval(event:Event):void{
	
	//  Remove this for now.  SHould always return to the last parameter input. 
	// historyParameterInput();
	
	PopUpManager.removePopUp(pophrmp);         
}


private function callMyView(event:Event):void{
	rettype = "new"; 
	historyParameterInput();
	//startMyViews(event);
	historyRetrievalMyView(event);
}

private function historyRetrievalMyView(event:Event):void{
	_xlcRenditionCode = "No Selection";
	_xlcRenditionDescription = "No Selection";
	//launchErgo();
	var checkflag:Boolean = false;
	var history_reqparms:String = new String;
	
	
	
	// Should get from botton to top - as per Christine.
	//for (var i:int=pophrmp.mfArray.length - 1;i>=0;i--){
	
	//  Return to orignial from top to bottom - as per Christine.	
	for (var i:int=0;i<pophrmp.mfArray.length;i++){	
		var str:String = new String;
		var type:String = pophrmp.mfArray[i].datatype;
		var col:String = pophrmp.mfArray[i].dataField;
		var val:String = pophrmp.mfArray[i].value;
		//var f_seq:String = pophrmp.mfArray[i].filter_seq;
		val = c_utils.trim(val);
		if (val.length > 0){
			//   Replace only for D and N    val = val.replace("+", ";")
			// put "=" as a prefix for numeric and date
			if ((type == "D") || (type == "N" )){
				val = val.replace("+", ";")
				if ((val.substr(0,1) != '>') && (val.substr(0,1) != '<')&&(val.substr(0,1) != '=')){
					val = "=" + val;
				}
			} 
			//* Change for Date and Numeric
			if (type == "S"){
				str = "type:"+type+",col:"+col+",val:"+val+"|";  
			}else {
				
				str = "type:"+type+",col:"+col+",val:"+val.replace("+", ";")+"|";
			}
			
			checkflag = true;
		}
		history_reqparms = history_reqparms + str;
		//Alert.show(history_reqparms);
	}	
	//Alert.show(history_reqparms);
	if (checkflag == false){
		PopUpManager.removePopUp(popwait);
		AlertMessageShow("Please select column(s) to retrieve." );
		return; 
	}
	history_reqParms_str = history_reqparms.substring(0, history_reqparms.length -1);
	//Alert.show(history_reqParms_str);
	history_reqparms = history_reqparms.substring(0, history_reqparms.length -1);
	history_reqparms = "<query2>" + history_reqparms + "</query2>" 
	history_reqparms = "REFRESH,"+mainBoard + "," + myName_main + "," + _xlcRenditionCode+ "," + history_reqparms	
	// history_reqparms = "REFRESH,"+mainBoard+",FILTER|" + history_reqparms 
	reqParms = history_reqparms;
	//Alert.show(reqParms);
	//Alert.show(reqParms);  
	//buildDatagrid();
	//dataList_history.send();
	startMyViews(event);
} 
private function historyNewRetrieval(event:Event):void{
	rettype = "new"; 
	historyParameterInput();
	historyRetrieval(event);
}
private function historyCurrentRetrieval(event:Event):void{
	rettype = "current"; 
	historyParameterInput();
	historyRetrieval(event);
}

[Bindable]
public var history_reqParms:String; 
[Bindable]
public var history_reqParms_str:String;
[Bindable]
public var auto_apply_str:String;
private function historyRetrieval(event:Event):void{
	_xlcRenditionCode = "No Selection";
	_xlcRenditionDescription = "No Selection";
	launchErgo();
	var checkflag:Boolean = false;
	var history_reqparms:String = new String;
	
	
	
	// Should get from botton to top - as per Christine.
	//for (var i:int=pophrmp.mfArray.length - 1;i>=0;i--){
		
	//  Return to orignial from top to bottom - as per Christine.	
	  for (var i:int=0;i<pophrmp.mfArray.length;i++){	
		var str:String = new String;
		var type:String = pophrmp.mfArray[i].datatype;
		var col:String = pophrmp.mfArray[i].dataField;
		var val:String = pophrmp.mfArray[i].value;
		//var f_seq:String = pophrmp.mfArray[i].filter_seq;
		val = c_utils.trim(val);
		if (val.length > 0){
			//   Replace only for D and N    val = val.replace("+", ";")
			// put "=" as a prefix for numeric and date
			if ((type == "D") || (type == "N" )){
				val = val.replace("+", ";")
				if ((val.substr(0,1) != '>') && (val.substr(0,1) != '<')&&(val.substr(0,1) != '=')){
					val = "=" + val;
				}
			} 
			//* Change for Date and Numeric
			if (type == "S"){
				str = "type:"+type+",col:"+col+",val:"+val+"|";  
			}else {
				
				str = "type:"+type+",col:"+col+",val:"+val.replace("+", ";")+"|";
			}
			
			checkflag = true;
		}
		history_reqparms = history_reqparms + str;
		//Alert.show(history_reqparms);
	}	
	//Alert.show(history_reqparms);
	if (checkflag == false){
		PopUpManager.removePopUp(popwait);
		AlertMessageShow("Please select column(s) to retrieve." );
		return; 
	}
	history_reqParms_str = history_reqparms.substring(0, history_reqparms.length -1);
	//Alert.show(history_reqParms_str);
	history_reqparms = history_reqparms.substring(0, history_reqparms.length -1);
	history_reqparms = "<query2>" + history_reqparms + "</query2>" 
	history_reqparms = "REFRESH,"+mainBoard + "," + myName_main + "," + _xlcRenditionCode+ "," + history_reqparms	
	// history_reqparms = "REFRESH,"+mainBoard+",FILTER|" + history_reqparms 
	reqParms = history_reqparms;
	//Alert.show(reqParms);
	//Alert.show(reqParms);  
	//buildDatagrid();
	dataList_history.send();    
} 


[Bindable]
private var hbox_special:HBox = new HBox;

[Bindable]
private var image_allcommands:Image = new Image;
public function createActionButtons(event:Event):void{
	tab_commands.removeAllChildren();
	var leftimageactionbuttons:Image= new Image;
	leftimageactionbuttons.source = "image/left_arrow_small_actiongrid.png";
	leftimageactionbuttons.addEventListener("click",leftClickforCommands);
	var rightimageactionbuttons:Image= new Image;
	rightimageactionbuttons.source = "image/right_arrow_small_actiongrid.png";
	rightimageactionbuttons.addEventListener("click",rightClickforCommands);
	
	//var hbox_special:HBox = new HBox;
	hbox_special = new HBox;
	hbox_special.width = dg.width  - 75;
	hbox_special.setStyle("horizontalGap",0);
	hbox_special.horizontalScrollPolicy="off"   
	
	
	/*  add the "all commands" image and its functions.  */	
	/*  Make All Commands a label as well.  */
	/*
	image_allcommands = new Image;
	image_allcommands.width = 140;
	image_allcommands.source = "image/ico_all_commands.png";
	image_allcommands.addEventListener("click",clickAllCommands);
	image_allcommands.addEventListener(MouseEvent.MOUSE_DOWN,mousedownAllCommands);
	image_allcommands.addEventListener(MouseEvent.MOUSE_UP,mouseupAllCommands);
	image_allcommands.addEventListener(MouseEvent.MOUSE_OVER,mouseoverAllCommands);       
	image_allcommands.addEventListener(MouseEvent.MOUSE_OUT,mouseoutAllCommands);
	hbox_special.addChild(image_allcommands);
	*/   
	image_allcommands = new Image;
	image_allcommands.width = 25;
	image_allcommands.height = 25;
	image_allcommands.source = "image/ico_smallchicklet_command.png";   
	image_allcommands.addEventListener("click",clickAllCommands);
	//image_allcommands.addEventListener(MouseEvent.MOUSE_DOWN,mousedownAllCommands);
	//image_allcommands.addEventListener(MouseEvent.MOUSE_UP,mouseupAllCommands);
	//image_allcommands.addEventListener(MouseEvent.MOUSE_OVER,mouseoverAllCommands);
	//image_allcommands.addEventListener(MouseEvent.MOUSE_OUT,mouseoutAllCommands);
	/*  Add the small chicklet icon. */
	hbox_special.addChild(image_allcommands);
	/*  Add the label for List CMD. */		   
	buttonNew = new ActionGridlabelCommands; 
	buttonNew.text = "List CMD's";       //set some properties
	buttonNew.addEventListener("click",clickAllCommands);
	hbox_special.addChild(buttonNew); 
	
	
	
	for (var i:int=0;i<arr_actionbuttons.length;i++){
		/*  add the "|" in between commands.  */	
		var lbl_pipe:Label = new Label;    
		lbl_pipe.text = "|";
		lbl_pipe.width = 14;
		lbl_pipe.setStyle("fontSize", "18");
		lbl_pipe.setStyle("fontWeight", 'bold');
		lbl_pipe.setStyle("color", '#1E555B');
		hbox_special.addChild(lbl_pipe);
		
		/*  add the small chicklet image.  */
		
		var image_smallchicklet_command:ActionGridimageCommands;
		image_smallchicklet_command = new ActionGridimageCommands; 
		image_smallchicklet_command.width = 25;
		image_smallchicklet_command.height = 25;
		image_smallchicklet_command.source = "image/ico_smallchicklet_command.png";
		image_smallchicklet_command.doc_id = arr_actionbuttons[i].docid;
		image_smallchicklet_command.command = arr_actionbuttons[i].command;
		image_smallchicklet_command.jobcode = arr_actionbuttons[i].jobcode;
		image_smallchicklet_command.refresh = arr_actionbuttons[i].refresh;
		image_smallchicklet_command.numofrec = arr_actionbuttons[i].numofrec;
		image_smallchicklet_command.datafield = arr_actionbuttons[i].datafield;
		image_smallchicklet_command.actiongrid = arr_actionbuttons[i].actiongrid;
		image_smallchicklet_command.paramcolumnname = arr_actionbuttons[i].paramcolumnname;
		image_smallchicklet_command.addEventListener("click",launchInterfaceActionButton);  //set an event listener 
		hbox_special.addChild(image_smallchicklet_command);
		
		/* Start layout Command functions. */
		//var buttonNew:HighViewButtonCommands;
		var buttonNew:ActionGridlabelCommands;  
		//buttonNew = new HighViewButtonCommands;                         //create the button
		buttonNew = new ActionGridlabelCommands; 
		buttonNew.text = arr_actionbuttons[i].label;       //set some properties
		buttonNew.doc_id = arr_actionbuttons[i].docid;
		buttonNew.command = arr_actionbuttons[i].command;
		buttonNew.jobcode = arr_actionbuttons[i].jobcode;
		buttonNew.refresh = arr_actionbuttons[i].refresh;
		buttonNew.numofrec = arr_actionbuttons[i].numofrec;
		buttonNew.datafield = arr_actionbuttons[i].datafield;
		buttonNew.actiongrid = arr_actionbuttons[i].actiongrid;
		buttonNew.paramcolumnname = arr_actionbuttons[i].paramcolumnname;
		/* setting style */
		//buttonNew.setStyle("fontSize", "18");
		//buttonNew.setStyle("fontWeight", 'bold');
		//buttonNew.setStyle("color", '#1E555B');
		
		
		buttonNew.addEventListener("click",launchInterfaceActionButton);  //set an event listener 
		buttonNew.addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
		buttonNew.addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
		hbox_special.addChild(buttonNew); 
		
	} 
	//panel.addChild(hbox_special);
	//tab_commands.addChild(hbox_special);
	tab_commands.addChild(leftimageactionbuttons);
	
	tab_commands.addChild(hbox_special);
	
	
	tab_commands.addChild(rightimageactionbuttons);
	
	
}
/*
<local:ActionGridImageButton
id="img_all_commands"  
doc_id="1005"
mouseUp="{img_all_commands.source = 'image/ico_all_commands.png'}"
click="{parentApplication.launchMoreInfo(), stopHoverTimer()}"
mouseDown="{img_all_commands.source = 'image/ico_all_commands_down.png',stopHoverTimer()}"   
source="@Embed(source='image/ico_all_commands.png')"
mouseOver="{mousehovering(event,'All Commands','BUTTON')}"
mouseOut="{stopHoverTimer(),img_all_commands.source = 'image/ico_all_commands.png'}"
height="25"  width="138" />
*/
private function mouseoverAllCommands(event:Event){
	mousehovering(event,'All Commands','BUTTON')
}
private function mouseoutAllCommands(event:Event){
	image_allcommands.source = 'image/ico_all_commands.png';
	stopHoverTimer();	
}  

private function mousedownAllCommands(m_event:MouseEvent){
	image_allcommands.source = 'image/ico_all_commands_down.png';
	stopHoverTimer();
}   
private function mouseupAllCommands(m_event:MouseEvent){
	image_allcommands.source = 'image/ico_all_commands.png';
	clickAllCommands(m_event);
}
public var popiac:InterfaceActionCommand;
private function clickAllCommands(event:MouseEvent):void {
	//Alert.show("go here");
	//		parentApplication.launchMoreInfo();
	
	//Alert.show("go here");
	
	popiac = InterfaceActionCommand(
		PopUpManager.createPopUp(this, InterfaceActionCommand, true));
	popiac.cc = my_c_code1;
	popiac.sid = my_sid;     
	popiac.mbc =  mainBoard;
	
	popiac.mbc_label = _xlcTitle;
	
	popiac["dg_action"].addEventListener("itemClick", clickCommandCode);          
	PopUpManager.centerPopUp(popiac);  
	stopHoverTimer();
	
} 

private function clickCommandCode(event:Event){
	//Alert.show(ag_application_entry);
	//Alert.show(popiac.dg_action.selectedItem.jobcode);
	/*
	parentApplication.enterActionCommand(event, popiac.dg_action.selectedItem.command, mainBoard)
	PopUpManager.removePopUp(popiac);
	*/
	saveCurSort_button(event);
	if (ag_application_entry == "ml"){
		if (popiac.dg_action.selectedItem.jobcode == "RD07"){
			
			LaunchMyLogSecurityOperatorGroups(event);
			PopUpManager.removePopUp(popiac);
		}
	} else {
		
		
		//parentApplication.global_dd = true;
		//Alert.show(parentApplication.global_dd);
		parentApplication.enterActionCommand(event, popiac.dg_action.selectedItem.command, mainBoard)
		
	}
}
private function leftClickforSpreadsheet(event:Event):void {
	hbox_spreadsheet.horizontalScrollPosition = hbox_spreadsheet.horizontalScrollPosition - 30;
} 
private function rightClickforSpreadsheet(event:Event):void {
	hbox_spreadsheet.horizontalScrollPosition = hbox_spreadsheet.horizontalScrollPosition + 30;
} 

private function leftClickforXML(event:Event):void {
	hbox_xml.horizontalScrollPosition = hbox_xml.horizontalScrollPosition - 30;
} 
private function rightClickforXML(event:Event):void {
	hbox_xml.horizontalScrollPosition = hbox_xml.horizontalScrollPosition + 30;
} 


private function leftClickforSpecials(event:Event):void {
	hbox_specials.horizontalScrollPosition = hbox_specials.horizontalScrollPosition - 30;
} 
private function rightClickforSpecials(event:Event):void {
	hbox_specials.horizontalScrollPosition = hbox_specials.horizontalScrollPosition + 30;
} 

private function leftClickforPreferences(event:Event):void {
	hbox_preferences.horizontalScrollPosition = hbox_preferences.horizontalScrollPosition - 30;
} 
private function rightClickforPreferences(event:Event):void {
	hbox_preferences.horizontalScrollPosition = hbox_preferences.horizontalScrollPosition + 30;
} 
private function leftClickforActions(event:Event):void {
	hbox_action.horizontalScrollPosition = hbox_action.horizontalScrollPosition - 30;
} 
private function rightClickforActions(event:Event):void {
	hbox_action.horizontalScrollPosition = hbox_action.horizontalScrollPosition + 30;
} 
private function leftClickforPanels(event:Event):void {
	hbox_special_panel.horizontalScrollPosition = hbox_special_panel.horizontalScrollPosition - 30;
} 
private function rightClickforPanels(event:Event):void {
	hbox_special_panel.horizontalScrollPosition = hbox_special_panel.horizontalScrollPosition + 30;
} 

private function leftClickforCommands(event:Event):void {
	hbox_special.horizontalScrollPosition = hbox_special.horizontalScrollPosition - 30;
} 
private function rightClickforCommands(event:Event):void {
	hbox_special.horizontalScrollPosition = hbox_special.horizontalScrollPosition + 30;
} 

[Bindable]
private var hbox_special_panel:HBox = new HBox;
public function createPanelButtons():void{
	tab_panels.removeAllChildren();
	
	var leftimage:Image= new Image;
	leftimage.source = "image/left_arrow_small_actiongrid.png";
	leftimage.addEventListener("click",leftClickforPanels);
	var rightimage:Image= new Image;
	rightimage.source = "image/right_arrow_small_actiongrid.png";
	rightimage.addEventListener("click",rightClickforPanels);
	
	hbox_special_panel = new HBox;
	hbox_special_panel.id = "inner_hbox";
	hbox_special_panel.width = dg.width - 75;
	hbox_special_panel.setStyle("horizontalGap",0);
	hbox_special_panel.horizontalScrollPolicy="off"   
	hbox_special_panel.verticalScrollPolicy="off"   
	
	aPanel = new Array();
	for (var a:int = 0; a<ArrayColumnGroup.length; a++){
		var PanelsbuttonNew:HighViewButton;
		PanelsbuttonNew = new HighViewButton; 
		PanelsbuttonNew.label = ArrayColumnGroup[a].headerText;
		
		PanelsbuttonNew.columnstart = ArrayColumnGroup[a].columnstart;
		PanelsbuttonNew.extensible = ArrayColumnGroup[a].extensible;
		//Alert.show(ArrayColumnGroup[a].extensible);
		if (ArrayColumnGroup[a].extensible == 'yes'){
			PanelsbuttonNew.loc_color = 'orange'
		} else {   
			PanelsbuttonNew.loc_color = 'black'
			
		}
		PanelsbuttonNew.index = ArrayColumnGroup[a].idx;      
		PanelsbuttonNew.addEventListener("click",change_columngroup_for_panels);  //set an event listener 
		PanelsbuttonNew.addEventListener( "click",profiledatagridListROver);
		PanelsbuttonNew.addEventListener( "click",profiledatagridListROut);
		
		addObjectToArrayPanel(PanelsbuttonNew);
		hbox_special_panel.addChild(PanelsbuttonNew); 
		//tab_panels.addChild(PanelsbuttonNew);    
		
		
	}	  
	//hbox_special_panel.addEventListener(MouseEvent.MOUSE_WHEEL,handleMouseWheelTabPabel);
	
	/* Initialize the panel button to 0 */
	initializePanel();
	
	tab_panels.addChild(leftimage);
	tab_panels.addChild(hbox_special_panel); 
	tab_panels.addChild(rightimage);
	
	
	
	
}
private function initializePanel():void{
	/* Initialize the panel button to 0 */
	
	for( var a:int = 0; a < aPanel.length; a++ ){
		if (a == 0){    
			aPanel[a]["selected"] = true;
			if (aPanel[a]["extensible"] == "yes"){
				//aPanel[a].setStyle("color","0xFF7000"); 
				aPanel[a].setStyle("color","#CC3311");
				aPanel[a].setStyle("borderColor","");
				aPanel[a].setStyle("fontStyle","italic")
			} else{
				
				
				aPanel[a].setStyle("color","blue"); 
				aPanel[a].setStyle("borderColor", "blue");
			}
			
			
			
		}else {
			
			aPanel[a]["selected"] = false;
			
			if (aPanel[a]["extensible"] == "yes"){
				//aPanel[a].setStyle("color","0xFF7000"); 
				aPanel[a].setStyle("color","#CC3311");
				aPanel[a].setStyle("borderColor","");
				aPanel[a].setStyle("fontStyle","italic")
			} else{
				
				
				aPanel[a].setStyle("color","black");    
				aPanel[a].setStyle("borderColor","");
			}
		}
		
		//Alert.show(aPanel[a]["extensible"]);
		/*
		if (aPanel[a]["extensible"] = "yes"){
		aPanel[a].setStyle("color","orange"); 
		}
		*/
	}	
	//hbox_special_panel.addChild(PanelsbuttonNew); 
}  
private function handleMouseWheelTabPreferences(event:MouseEvent):void{
	if (event.delta >= 0){
		leftClickforPreferences(event)
	} else {  
		
		rightClickforPreferences(event)
	}
}
private function handleMouseWheelTabActions(event:MouseEvent):void{
	if (event.delta >= 0){
		leftClickforActions(event)
	} else {  
		
		rightClickforActions(event)
	}
}
private function handleMouseWheelTabSpecials(event:MouseEvent):void{
	if (event.delta >= 0){
		leftClickforSpecials(event)
	} else {  
		
		rightClickforSpecials(event)
	}
}
private function handleMouseWheelTabSpreadsheet(event:MouseEvent):void{
	if (event.delta >= 0){
		leftClickforSpreadsheet(event)
	} else {  
		
		rightClickforSpreadsheet(event)
	}
}
private function handleMouseWheelTabXML(event:MouseEvent):void{
	if (event.delta >= 0){
		leftClickforXML(event)
	} else {  
		
		rightClickforXML(event)
	}
}
private function handleMouseWheelTabCommands(event:MouseEvent):void{
	if (event.delta >= 0){
		leftClickforCommands(event)
	} else {  
		rightClickforCommands(event)
	}
}
private function handleMouseWheelTabPanel(event:MouseEvent):void{
	if (event.delta >= 0){
		leftClickforPanels(event)
	} else {  
		rightClickforPanels(event)
	}
}
private function handleMouseWheelBottomCommands(event:MouseEvent):void{
	if (event.delta >= 0){
		leftClickforBottomCommands(event)
	} else {  
		rightClickforBottomCommands(event)
	}
}
[Bindable]
private var ArrayRetainKey:ArrayCollection = new ArrayCollection;	
private function launchInterfaceActionButton(event:Event):void{
	saveCurSort_button(event);
	var arr_bwiset:ArrayCollection = new ArrayCollection;
	var arrayselected:int;
	_xlcSetupJob = 	event.currentTarget.jobcode;	
	arrayselected = dg.selectedItems.length;
	var obj = new Object();
	arr_bwiset = new ArrayCollection();
	if  ((Array1.length == arrayselected)&&(Array1.sort != null)){
		for( var iarr:int = 0; iarr < arrayselected; iarr++ ){
			obj = iarr;
			arr_bwiset.addItem(obj); 
		}
		
	} else {
		for( var iarr:int = 0; iarr < arrayselected; iarr++ ){
			obj = dg.selectedIndices[iarr];
			arr_bwiset.addItem(obj); 
		}
	}
	
	ArrayRetainKey = new ArrayCollection();
	var newObject3:Object = new Object();
	newObject3 = new Object();
	var list:ArrayCollection = SortArray(arr_bwiset);
	newObject3 = list.toString();                     
	/* index has been sorted to Array - YEAH! */
	ArrayRetainKey.addItem(newObject3);        
	var str_segment_array:Array = [];
	var str_len:int;
	str_segment_array = new Array;
	str_segment_array = ArrayRetainKey[0].split(",");	 
	str_len = str_segment_array.length;  
	
	var str_arrdata:String = new String;
	///////////////Alert.show("checkered");
	/*  move to "if(dg.selectedItems.length > 0){ "  Will not work if Array1 is empty.  
	for( var iarrs:int = 0; iarrs < str_len; iarrs++ ){
	//Alert.show(str_segment_array[iarrs]);
	var i_ssar:int = str_segment_array[iarrs];
	str_arrdata = str_arrdata + ',' + Array1[ i_ssar ][_xlcColumn[_xlcColumn.length-2]["dataField"]];
	}                           
	*/
	if(dg.selectedItems.length > 0){   
	
			for( var iarrs:int = 0; iarrs < str_len; iarrs++ ){
				//Alert.show(str_segment_array[iarrs]);
				var i_ssar:int = str_segment_array[iarrs];
				
				//Alert.show([_xlcColumn[_xlcColumn.length-2]["dataField"]].toString());
				
				str_arrdata = str_arrdata + ',' + Array1[ i_ssar ][_xlcColumn[_xlcColumn.length-2]["dataField"]];
				
				
			}   
			dd_reqParms = "REFRESH,COMMAND,"+ event.currentTarget.command +"," + mainBoard + str_arrdata;
			
	}
	if(dg.selectedItems.length < 1){    
		dd_reqParms = "REFRESH,COMMAND,"+ event.currentTarget.command +"," + mainBoard;
	}                                
	
	if ((event.currentTarget.command).substr(0,1) == "*"){ /* This condition is for the Arboretum Function where command = ** */
		// Launch Arboretum Interface File Display         
		launchArboretumFileDisplay(event,str_arrdata.substr(1,str_arrdata.length),dg.selectedItem.client);
		
	} else if ((event.currentTarget.command).substr(0,1) == "_"){   /*This is for Drop Down/Pop Up HighView */
		
		selectRecordActionButton(event,event.currentTarget.datafield,event.currentTarget.actiongrid);
	} else {
		
		
		
		
		if (ag_application_entry == 'vl'){
			if (event.currentTarget.jobcode == 'CONF'){
				//LaunchMyLogSecurityOperator(event);
				LaunchConfigPassphrase(event, my_sid, my_c_code1);
			}else {
				
				parentApplication.enterActionCommand(event, event.currentTarget.command, mainBoard);
			}
			
		}
		if (ag_application_entry == 'ml'){   
			if (event.currentTarget.jobcode == 'RD07'){
				/* this is specifically for Operator Groups Interactive  */
				LaunchMyLogSecurityOperatorGroups(event);
				
			}else if (event.currentTarget.jobcode == 'RD06'){
				/* this is specifically for Operator Interactive  */
				LaunchMyLogSecurityOperator(event);
				//Alert.show(event.currentTarget.jobcode);
				//parentApplication.enterActionCommand(event, event.currentTarget.command, mainBoard);
				//LaunchMyLogSecurityOperatorGroups(event);
			}else if(event.currentTarget.jobcode == 'CONF'){
				LaunchConfigPassphrase(event, my_sid, my_c_code1);
			}else{ 
				
				parentApplication.enterActionCommand(event, event.currentTarget.command, mainBoard);
			}
		}
		
		
		
		
	}   
	
}                 

private function selectRecordActionButton(event:Event, currentT:String, mboard:String):void{
	if (dg.selectedItems.length == 0){
		AlertMessageShow("Please select a record");
		return;
	}
	if (dg.selectedItems.length > 1){
		AlertMessageShow("You can only select 1 record");
		return;
	}
	popcompsys_access = DrillDown(
		PopUpManager.createPopUp(this, DrillDown, true));
	popcompsys_access.sessid = my_sid;
	popcompsys_access.dd_mainBoard= mboard;
	popcompsys_access.dd_usercode= myName_main;
	popcompsys_access.dd_compcode = my_c_code1;
	popcompsys_access.dd_firstcolumn = dg.selectedItem[currentT];
	popcompsys_access.button_title = event.currentTarget.label;
	popcompsys_access.code_description = dg.selectedItem[(_xlcColumn[1]["dataField"])];
	popcompsys_access.dd_field = currentT; 
	
	
}
/*
private function launch_Drilldown_compsys(event:Event, str_code:String, str_mainboard:String,str_code_description:String):void {
popcompsys_access = DrillDown(
PopUpManager.createPopUp(this, DrillDown, true));
popcompsys_access.sessid = my_sid;
popcompsys_access.dd_mainBoard= str_mainboard;
popcompsys_access.dd_usercode= myName_main;
popcompsys_access.dd_compcode = my_c_code1;
popcompsys_access.dd_firstcolumn = str_code;
popcompsys_access.button_title = event.currentTarget.label;
popcompsys_access.code_description = str_code_description;
}
*/   			
public var poparboretum:ArboretumGetFile;
private function launchArboretumFileDisplay(event:Event,str_order:String, str_client:String):void {
	poparboretum = ArboretumGetFile(
		PopUpManager.createPopUp(this, ArboretumGetFile, true));
	poparboretum.orderid = str_order;
	poparboretum.client = str_client;
}


public var pop_views:Views;
public function startViews(event:Event, views:String ):void {
	
	//Alert.show(Application.application.parameters.av); 
	pop_views = Views(
		PopUpManager.createPopUp(this, Views, true));
	pop_views.currentfilter_views = views;
	if (views == "fh"){
		pop_views.btn_views_default.enabled = false;   
	}
	if ( Application.application.parameters.av == 'O'){
		pop_views["btn_views_delete"].enabled = false;
	}
	if (views == "fhp"){
		pop_views.titleviews = "Persistent Views"
		pop_views.currentview = lbl_persistent_view.text;
		pop_views.arr_views = fhp;
	}
	if (views == "fh"){    
		pop_views.titleviews = "Transient Views"
		pop_views.currentview = lbl_transient_view.text;
		pop_views.arr_views = fh;      
	}
	if (views == "fhp"){
		//Alert.show("go here");
		//pop_views["dg_views"].addEventListener("click", selectPersistentView);
		pop_views["btn_apply"].addEventListener("click", selectPersistentView);
		pop_views["btn_views_delete"].addEventListener("click", del_filterview);
		pop_views["btn_views_default"].addEventListener("click", default_view);      
		pop_views["btn_views_settings"].addEventListener("click", launchHistoryLog);      
	}   
	if (views == "fh"){
		//pop_views["dg_views"].addEventListener("click", selectTransientView);
		pop_views["btn_apply"].addEventListener("click", selectTransientView);
		pop_views["btn_views_delete"].addEventListener("click", del_filterview);
		pop_views["btn_views_settings"].addEventListener("click", launchHistoryLog);   
	}
}

private function selectPersistentView(event:Event):void {
	
	
	if (pop_views.dg_views.selectedItems.length > 0){
		lbl_persistent_view.text = pop_views.dg_views.selectedItem.filtercode;
		//cb_column_group.selectedIndex = 0;
		FilterDescription('P');
		change_filtermacro_persistent(event);
		//cb_filter_macro.selectedIndex = -1;
		lbl_transient_view.text = 'No selection';
		addTotal(event);     
		refreshButton(event);
		//PopUpManager.removePopUp(pop_views);
	} else {
		AlertMessageShow("Please select a row.");
		return;
	}	
}
private function selectTransientView(event:Event):void {
	if (pop_views.dg_views.selectedItems.length > 0){
		lbl_transient_view.text = pop_views.dg_views.selectedItem.filtercode;
		//cb_column_group.selectedIndex = 0;
		FilterDescription('T');
		change_filtermacro_persistent(event);
		change_filtermacro(event);
		//PopUpManager.removePopUp(pop_views);
	} else {
		AlertMessageShow("Please select a row.");
		return;
	}		
}
public var pop11:Rendition;
public function startRender(event:Event):void {
	PopUpManager.removePopUp(pop2);	
	pop11 = Rendition(
		PopUpManager.createPopUp(this, Rendition, true));
	
	pop11.loc_mbdcode = toxml_mbdcode;
	pop11.loc_user = myName_main;
	pop11.loc_sid = my_sid;
	pop11.loc_ccode = my_c_code1;
	pop11.txt_current.text = "Current Rendition: " + _xlcRenditionCode;
	if ( Application.application.parameters.ar == 'N'){
		pop11.btn_rendition_create.enabled = false;
		pop11.btn_rendition_modify.enabled = false;
		pop11.btn_rendition_delete.enabled = false;
		
	}
	pop11["btn_rendition_create"].addEventListener("click", createRendition);
	pop11["btn_rendition_create"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	pop11["btn_rendition_create"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	pop11["btn_rendition_modify"].addEventListener("click", modifyRendition);
	pop11["btn_rendition_modify"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	pop11["btn_rendition_modify"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	pop11["btn_rendition_switch"].addEventListener("click", switchRendition);
	pop11["btn_rendition_switch"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	pop11["btn_rendition_switch"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	
	//PopUpManager.centerPopUp(pop11);   
	
}

public var popcmrendition:RenditionCM
private function createRendition(event:Event):void {
	
	PopUpManager.removePopUp(pop11);
	popcmrendition = RenditionCM(
		PopUpManager.createPopUp(this, RenditionCM, true));
	popcmrendition.r_sessid = my_sid;
	popcmrendition.r_company_code = my_c_code1;
	popcmrendition.r_user_code = myName_main;
	popcmrendition.r_passed_mainboard = mainBoard;
	popcmrendition.r_passed_mainboardtitle = _xlcTitle + ' Panel/Column';
	popcmrendition.r_passed_eventtitle = 'Create New Rendition';
	//popcmrendition.r_file_passed = "BASE";
	popcmrendition.r_file_passed = "MASTER";
	popcmrendition.r_flag_type = "Create";
	popcmrendition.r_lock_columns = _xlcLockColumn;
	popcmrendition.showCloseButton = false;
	popcmrendition["btn_close_window"].addEventListener("click", closeRendition);
	popcmrendition.callbackFunction = startRender;
	//	popcmrendition["btn_save_current"].addEventListener("click", closeRendition);
	//popcmrendition.addEventListener(CloseEvent.CLOSE, closeRendition);
}


private function closeWorkflow(event:Event):void{
	
	PopUpManager.removePopUp(popworkfloweditor);
	startWorkflow(event);
	
}

private function closeRendition(event:Event):void{
	
	PopUpManager.removePopUp(popcmrendition);
	startRender(event);
	
}
private function closeMapper(event:Event):void{
	
	PopUpManager.removePopUp(popmapper);
	startMapper(event);
}
private function saveCurrentRendition(event:Event):void{
	PopUpManager.removePopUp(popcmrendition);
	startRender(event);
}

private function modifyRendition(event:Event):void {
	if (pop11.dg_rendition.selectedItems.length == 0){
		AlertMessageShow("Please select a row to modify.");
		return;
	}
	
	
	
	
	if ((myName_main).toUpperCase() != "MAVES"){
		//if (pop11.dg_rendition.selectedItem.rendcode == 'BASE'){
		if ((pop11.dg_rendition.selectedItem.rendcode).substr(0,4) == 'BASE'){	
			AlertMessageShow("You are not allowed to modify a 'BASE' Code.")
			return;
		}
		if (pop11.dg_rendition.selectedItem.rendcode == 'BASE'){	
			AlertMessageShow("You are not allowed to modify a 'BASE' Code.")
			return;
		}
		
	}     
	
	if (pop11.dg_rendition.selectedItem.rendcode == 'MASTER'){
		AlertMessageShow("'MASTER' Code is not allowed. Please try another code")
		return;     
	}
	
	if ( Application.application.parameters.ar == 'O'){
		if((pop11.dg_rendition.selectedItem.rendcode).substr(0,1) != '*'){
			AlertMessageShow("You are not allowed to modify a Generic Rendition");
			return;
		}
	}
	
	PopUpManager.removePopUp(pop11);
	//PopUpManager.removePopUp(pop2);
	popcmrendition = RenditionCM(
		PopUpManager.createPopUp(this, RenditionCM, true));
	popcmrendition.r_sessid = my_sid;
	popcmrendition.r_company_code = my_c_code1;
	popcmrendition.r_user_code = myName_main;
	popcmrendition.r_passed_mainboard = mainBoard;
	popcmrendition.r_passed_mainboardtitle = _xlcTitle + ' Panel/Column';
	popcmrendition.r_passed_eventtitle = 'Modify Rendition';
	popcmrendition.r_file_passed = "MASTER"; 
	popcmrendition.r_flag_type = "Modify";
	popcmrendition.r_file_modify = pop11.dg_rendition.selectedItem.rendcode; 
	popcmrendition.r_description_modify = pop11.dg_rendition.selectedItem.renddesc; 
	popcmrendition.r_default_modify = pop11.dg_rendition.selectedItem.default_rendition;
	popcmrendition.r_lock_columns = _xlcLockColumn;
	popcmrendition.showCloseButton = false;
	popcmrendition["btn_close_window"].addEventListener("click", closeRendition); 
	popcmrendition.callbackFunction = startRender;
	//popcmrendition.addEventListener("close", closeRendition);
	//popcmrendition.popsaverendition["btn_save_current"].addEventListener("click", closeRendition); 
	//popcmrendition.addEventListener(CloseEvent.CLOSE, closeRendition);
	
}

public var retfromrendition:Boolean = false;	



private function switchRendition(e:Event):void {
	updateMyViewSequence(e);
	myview_flag = 1;  
	myviews_code.text = popmyviews.dg_rendition.selectedItem.viewcode;
	
	if (popmyviews.dg_rendition.selectedItems.length == 0){
		AlertMessageShow("Please select a row to render.");
		return;  
	}   
	popmyviews.txt_current.text = "Currently in use: " + popmyviews.dg_rendition.selectedItem.viewcode;  
	popmyviews.loc_rendcode = popmyviews.dg_rendition.selectedItem.viewcode; 
	PopUpManager.removePopUp(popmyviews);  
	retfromrendition = true; 
	reqParms = "REFRESH,RETRIEVE|GRIDHEADERDOC2|" + myName_main + "|" + toxml_mbdcode + "|" + popmyviews.dg_rendition.selectedItem.viewcode + "|";
	_xlcRenditionCode = popmyviews.dg_rendition.selectedItem.viewcode; 
	_xlcRenditionbtntitle = popmyviews.dg_rendition.selectedItem.btnlabel;
	propertiesList.send();
	
}   
private function closeMyView(e:Event):void { 
	
	//MyViewButtons.send();  
	
	PopUpManager.removePopUp(popmyviews); 
	updateMyViewSequence(e);
	 
}

public var loc_coltitle:String;
public var loc_coldatafield:String;
public var loc_datavalue:String;


public var popddc:DrillDownDisplayColumnRow;

public function LaunchDisplayColumn(event:Event, col_title:String, value:String, col_datafield:String):void {
	
	popddc = DrillDownDisplayColumnRow(
		PopUpManager.createPopUp(this, DrillDownDisplayColumnRow, true));
	popddc.loc_coltitle = col_title;
	popddc.loc_coldatafield = col_datafield;
	popddc.loc_datavalue = value;
	
	
}
private var pop9:SubCrunchEntry;
private function launch_SubCrunch(event:Event):void {
	// check for sorted fields for SubTotal parameters;
	if (Array1.sort == null){
		AlertMessageShow("Please select column(s) to Sort.");
		return;
	}
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
	//	if   (myview_flag == 1){ 
	pop9 = SubCrunchEntry(
		PopUpManager.createPopUp(this, SubCrunchEntry, true));
	pop9.arr_colsorted = cb_sorted;
	PopUpManager.centerPopUp(pop9); 
	pop9["btn_sc_submit"].addEventListener("click", crunch_subtotal); 
	pop9["btn_sc_submit"].addEventListener(KeyboardEvent.KEY_DOWN, enterHandlerST);
	
	
	pop9["btn_sc_submit"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	pop9["btn_sc_submit"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	
	//	}
	
	
	//pop9.cb_sort.selectedIndex = 1;
	//crunch_subtotal(event);
}
private var aPanel:Array = new Array();
private function addObjectToArrayPanel(formField:DisplayObject):void{
	this.aPanel.push(formField);
}			 
private function leftClickforBottomCommands(event:Event):void {
	bx_bottom_commands.horizontalScrollPosition = bx_bottom_commands.horizontalScrollPosition - 30;
} 
private function rightClickforBottomCommands(event:Event):void {
	bx_bottom_commands.horizontalScrollPosition = bx_bottom_commands.horizontalScrollPosition + 30;
}


private function switchAutoRefresh(event:Event):void{
	
	if (_xlcHistory == "Yes"){
		AlertMessageShow("Auto-Refresh is not allowed on a Query ActionGrid.");
		return;
		
	}
	if (autorefresh_flag == "OFF"){
		launchAutoRefreshTimer(event);
	}else {
		autorefresh_flag = "OFF";
		img_autorerefreshswitch.source="image/ico_auto_refresh_off.png"
		//btn_autorefresh.setStyle("icon",this["autorefreshOFF"]);
		//autorefresh_ctr.visible = false;
		AR_stopTimer(); 
	}       
} 	


private const AR_HR_MASK:String = "00";
private const AR_MIN_MASK:String = "00";
private const AR_SEC_MASK:String = "00";
private const AR_MS_MASK:String = "000"; 
private const AR_TIMER_INTERVAL:int = 10;
private var AR_baseTimer:int;

private var AR_t:Timer;
private var AR_d:Date;
public var popautorefreshtimer:AutoRefreshTimer;
private var f_hr:String = "00";
private var f_min:String = "02";
private var f_sec:String = "00";
private function launchAutoRefreshTimer(event:Event):void{
	//Alert.show(_xlcTitle);
	popautorefreshtimer = AutoRefreshTimer(
		PopUpManager.createPopUp(this, AutoRefreshTimer, false));
	popautorefreshtimer.p_hr = f_hr;
	popautorefreshtimer.p_min = f_min;
	popautorefreshtimer.p_sec = f_sec;
	popautorefreshtimer.p_mainboardtitlename = _xlcTitle;
	popautorefreshtimer["btn_ok"].addEventListener("click",  submitAutoRefresh); 
}


private function validateAutoRefreshTimer(event:Event):Boolean{
	var ret_boolean:Boolean = true;
	if ((popautorefreshtimer.ti_hr.text == "")||(popautorefreshtimer.ti_min.text == "")||(popautorefreshtimer.ti_sec.text == "")){
		ret_boolean = false;
	}
	return ret_boolean;	
}
private function appendZeroAutoRefreshTimer():void{
	if (popautorefreshtimer.ti_hr.text.length == 1){
		popautorefreshtimer.ti_hr.text = "0" + popautorefreshtimer.ti_hr.text; 
	}
	if (popautorefreshtimer.ti_min.text.length == 1){
		popautorefreshtimer.ti_min.text = "0" + popautorefreshtimer.ti_min.text; 
	}
	if (popautorefreshtimer.ti_sec.text.length == 1){
		popautorefreshtimer.ti_sec.text = "0" + popautorefreshtimer.ti_sec.text; 
	}
	return;
}
private function submitAutoRefresh(event :Event):void{
	//btn_autorefresh.setStyle("icon",this["autorefreshON"]);
	
	autorefresh_flag = "ON";
	img_autorerefreshswitch.source="image/ico_auto_refresh_on.png"
	
	
	// do timer for auto refresh
	
	var retTimer:Boolean = validateAutoRefreshTimer(event);
	if (retTimer == false){
		AlertMessageShow("Timer should not be null");
		return;
	}
	
	appendZeroAutoRefreshTimer();
	
	if (popautorefreshtimer.ti_hr.text > '11'){
		AlertMessageShow("Hours should not be greater than 11");
		return;
	}
	if (popautorefreshtimer.ti_min.text > '59'){
		AlertMessageShow("Minutes should not be greater than 59");
		return;
	}
	if (popautorefreshtimer.ti_sec.text > '59'){
		AlertMessageShow("Seconds should not be greater than 59");
		return;
	}
	
	autorefreshTimeLimit = popautorefreshtimer.ti_hr.text.toString() + ":" + popautorefreshtimer.ti_min.text.toString() +":"+ popautorefreshtimer.ti_sec.text.toString(); 
	// Validation for timer
	
	if (autorefreshTimeLimit <= '00:00:29'){
		AlertMessageShow("Timer should not be less than 00:00:30");
		return;
	}
	
	//autorefresh_ctr.visible = true;
	//Alert.show(autorefreshTimeLimit);
	f_hr =  popautorefreshtimer.ti_hr.text;
	f_min =  popautorefreshtimer.ti_min.text;
	f_sec =  popautorefreshtimer.ti_sec.text;
	
	
	
	AR_t = new Timer(AR_TIMER_INTERVAL);
	AR_t.addEventListener(TimerEvent.TIMER, AR_updateTimer); 
	AR_startTimer();
	PopUpManager.removePopUp(popautorefreshtimer);
	
}

private function AR_updateTimer(evt:TimerEvent):void {
	
	var AR_d:Date = new Date(getTimer() - AR_baseTimer);
	var AR_hr:String = (AR_HR_MASK + AR_d.hoursUTC).substr(-AR_HR_MASK.length);
	var AR_min:String = (AR_MIN_MASK + AR_d.minutes).substr(-AR_MIN_MASK.length);
	var AR_sec:String = (AR_SEC_MASK+ AR_d.seconds).substr(-AR_SEC_MASK.length); 
	autorefresh_ctr.text = String(AR_hr + ":" + AR_min + ":" + AR_sec );
	if  (autorefresh_ctr.text >= autorefreshTimeLimit){
		// Refresh everything first to look for new records.
		/*
		for(var ix:int = 0; ix < aCheckBox.length; ix++){
		if (ArrayShow[ix].Array1.sort != null){
		ArrayShow[ix].CheckSortGeneral(evt);
		}
		ArrayShow[ix].dataList2_trigger(evt,true);
		}   
		*/
		//for(var ix:int = 0; ix < aCheckBox.length; ix++){
		if (Array1.sort != null){
			CheckSortGeneral(evt);
		}
		dataList2_trigger(evt,true);
		//}
		AR_startTimer();
	}
	
}

private function AR_startTimer():void {
	AR_baseTimer = getTimer();
	AR_t.start();
}

private function AR_stopTimer():void {
	AR_t.stop();
}


private var pop_okCancel:OkCancel; 


private function launchOkCancel(event:Event):void {
	pop_okCancel = OkCancel(
		PopUpManager.createPopUp(this, OkCancel, true));
	pop_okCancel["btn_ok"].addEventListener("click", action_reset);
	pop_okCancel["btn_ok"].addEventListener(KeyboardEvent.KEY_DOWN, enter_action_reset);
	
}


private function enter_action_reset(event :KeyboardEvent):void{
	//	Alert.show("Arnold");
	//	Alert.show(event.keyCode.toString());
	
	if (event.keyCode == Keyboard.ENTER)
	{      
		action_reset(event);
	}
	
}
/*
private function createParameterXML(targetActionGrid:String, targetrowdata:String, targetcolumn:String, targetselectedrow:Number):void {
Alert.show("Yeah! " + targetActionGrid + " : " +targetrowdata + " : " + targetcolumn + " : " + targetselectedrow.toString() );
//createParameterXML(_xlcColumn[dsColumnIndex]['drilldowntoactiongrid'],newValuecol.dataField);

}
*/
public function intialize_Arrays():void{
	tdObjectCollection = null;
	tdObjectCollectionRefresh = null;	
	Array1 = null;
	Array2 = null;
	Array3 = null;
	Array4 = null;
	Array5 = null;
	Array6 = null;
	ArrayColumnGroup = null;
	ArrayMultipleFilter = null;
	ArrayFilterInsert = null;
	_xlcColumn = null;
	_xlcColumnGroup = null;
	
	tdObjectCollection = new ArrayCollection;
	tdObjectCollectionRefresh = new ArrayCollection;	
	Array1 = new ArrayCollection;
	Array2 = new ArrayCollection;
	Array3 = new ArrayCollection;
	Array4 = new ArrayCollection;
	Array5 = new ArrayCollection;
	Array6 = new ArrayCollection;
	ArrayColumnGroup = new ArrayCollection;
	ArrayMultipleFilter = new ArrayCollection;
	ArrayFilterInsert = new ArrayCollection;
	_xlcColumn = new ArrayCollection
	_xlcColumnGroup = new ArrayCollection;
	parentApplication.global_dd = true
	//	Alert.show("All Clean");
	
}

private function backDrillDown_1(evt:Event):void {
	if (drilldown_flag == "Y"){
		intialize_Arrays();
		parentApplication.mainboard_backDrillDown_1(evt);
	}	else {
		AlertMessageShow("Only works on a Hyperlinked ActionGrid");
	}
}
private function backDrillDown_all(evt:Event):void {
	if (drilldown_flag == "Y"){  
		//intialize_Arrays(evt);
		parentApplication.global_dd = false;
		parentApplication.mainboard_backDrillDown_all(evt);
	}	else {
		AlertMessageShow("Only works on a Hyperlinked ActionGrid");
	}	
}



private function aDDIncluded(evt:ResultEvent):void {
	
	Array1 = new ArrayCollection();
	_xlcColumn = new ArrayCollection
	_xlcColumnGroup = new ArrayCollection;
	
	//	Alert.show(evt.result.ezware_response.)
	if ( evt.result.ezware_response.status == 'FAIL' ) {
		PopUpManager.removePopUp(popwait);
		AlertMessageShow(evt.result.ezware_response.reason);
		return;
	}
	
	if (evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumn.column == null)
	{
		_xlcColumn=new ArrayCollection()
	}
	else if (evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumn.column is ArrayCollection)
	{
		_xlcColumn=evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumn.column;
	}
	else if (evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumn.column is ObjectProxy)
	{
		_xlcColumn = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumn.column)); 
	}
	
	//	_xlcColumn.refresh();
	
	_xlcTitle = evt.result.ezware_response.refresh_data.root.Panel.title;
	_xlcCode = evt.result.ezware_response.refresh_data.root.Panel.code;
	_xlcHistory = evt.result.ezware_response.refresh_data.root.Panel.history;
	_xlcRefreshAll = evt.result.ezware_response.refresh_data.root.Panel.refreshall;
	_xlcSetupJob = evt.result.ezware_response.refresh_data.root.Panel.setupjob;
	_xlcActionCommand = evt.result.ezware_response.refresh_data.root.Panel.actioncommand;
	_xlcLockColumn = evt.result.ezware_response.refresh_data.root.Panel.lockcolumn;
	_xlcRenditionCode = evt.result.ezware_response.refresh_data.root.Panel.rendcode;
	_xlcRenditionDescription = evt.result.ezware_response.refresh_data.root.Panel.renddesc;
	
	
	reqParmsColumnsSetting = "REFRESH,RENDITION," + mainBoard + "," + myName_main + "," + _xlcRenditionCode;
	getColumnSettings.send();
	
	
	//Alert.show("2nd pass: " + _xlcColumn.length.toString());
	/*
	if (_xlcHistory != "Yes"){
	lbl_query.text = "Refresh"; //dbrefresh.toolTip = "Retrieves and displays any new/changed data from the database. IF this data MATCHES the current column filters.  A 'History database refresh involves collecting information that rarely or does NOT change (i.e. 'Shipped Orders' action gird in the WMS History HighView)";
	}else {
	lbl_query.text = "Query";  
	}
	*/
	
	//Alert.show("go here");
	//initfilterheaderlist(_xlcCode);
	//initfilterdetaillist(evt, _xlcCode);
	//	buildDatagrid();         
	
	
	var cg:Object = new Object();
	
	if (evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumnGroup.columngroup == null)
	{
		_xlcColumnGroup=new ArrayCollection()
	}
	else if (evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumnGroup.columngroup is ArrayCollection)
	{
		_xlcColumnGroup=evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumnGroup.columngroup;
	}
	else if (evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumnGroup.columngroup is ObjectProxy)
	{
		_xlcColumnGroup = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumnGroup.columngroup)); 
	}
	
	_xlcColumnGroup.refresh();
	
	//  Gets the type of the XML Header Doc.
	xmlheaderdoc_type = evt.result.ezware_response.refresh_data.root.Panel.type;
	//Alert.show(_xlcColumnGroup.length + ":" + mainBoard);
	
	/*
	if (_xlcColumnGroup.length == 0){
	AlertMessageShow(mainBoard + "do not have the necessary Datagrid Dolumn Group");
	PopUpManager.removePopUp(popwait);
	return;
	}
	*/
	ArrayColumnGroup = new ArrayCollection([]);
	for (var i:int=0;i<_xlcColumnGroup.length;i++)  { 
		var cg = new Object;
		var headerText:String = (_xlcColumnGroup[i]["headerText"]);
		var columnstart:String = (_xlcColumnGroup[i]["columnstart"]);
		var extensible:String = (_xlcColumnGroup[i]["extensible"]);
		cg.headerText = headerText;
		cg.columnstart = columnstart;
		cg.extensible = extensible;
		cg.idx = i;
		ArrayColumnGroup.addItem(cg);
	}
	
	ArrayColumnGroup.refresh();
	// This is for Ribbons population of Panels	
	
	createPanelButtons();		 	  
	//Alert.show("Drill: " + drilldown_flag + " : " + drilldown_reqparm);
	
	//var loc_xlcHistory:String = "No";
	loc_xlcHistory = _xlcHistory;
	if (drilldown_flag == "Y"){
		if (_xlcHistory == "Yes"){
			loc_xlcHistory = _xlcHistory;
			_xlcHistory = "No";
		}
		
	}
	
	buildDatagrid();    
	 
	
	//  Remove this for now.  4/12/2013
	//initfilterheaderlist(_xlcCode);
	// Replac with
	initfilterdetaillist(evt, _xlcCode);
	
	//	initfilterdetaillist(evt, _xlcCode);
	// Re-paint Action Grid
	
	//			correctWidth(evt);
	//			flagger(evt);
	
	
	
	//	buildDatagrid();            
	/////       
	_xlcHistory = loc_xlcHistory;
	
	/////    
	
	/*
	//if (evt.result.ezware_response.refresh_data.addincluded != "Y"){
	//Alert.show(fhp.length.toString());
	for (var ia:int=0;ia < fhp.length; ia++)  {              
	//Alert.show(fhp[i].filtercode);
	if (fhp[ia].default_view == "Y"){
	lbl_persistent_view.text = fhp[ia].filtercode;
	}
	}
	change_filtermacro_persistent(evt);
	lbl_transient_view.text = 'No selection';
	//	addTotal();    
	//refreshButton(evt);
	//Alert.show("Done Filter HEader: " + lbl_persistent_view.text);
	//cb_filter_macro_persistent.dataProvider = fhp;
	
	
	refreshButton(evt); 
	correctWidth(evt);  
	//}
	*/	
	//Alert.show(extensible_field);
	
	
	PopUpManager.removePopUp(myAlert);
}


private function xmlLineUpforLot(evt:Event, arret:ArrayCollection):String {
	//Alert.show(arret.length.toString());
	
	var checkflag:Boolean = false;
	var history_reqparms:String = new String;
	
	
	
	
	
	
	// Should get from botton to top - as per Christine.
	//for (var i:int=0;i<arret.length;i++){
	//for (var i:int=arret.length - 1;i>=0;i--){
	
		
		
	//  Return to orignial from top to bottom - as per Christine.	
	for (var i:int=0;i<arret.length;i++){	
				
		var str:String = new String;
		var type:String = arret[i].datatype;
		var col:String = arret[i].dataField;
		var val:String = arret[i].value;
		//var f_seq:String = pophrmp.mfArray[i].filter_seq;
		val = c_utils.trim(val);
		if (val.length > 0){
			
			// put "=" as a prefix for numeric and date
			if ((type == "D") || (type == "N" )){
				val = val.replace("+", ";")
				if ((val.substr(0,1) != '>') && (val.substr(0,1) != '<')&&(val.substr(0,1) != '=')){
					val = "=" + val;
				}
			} 
			if (type == "S"){
				str = "type:"+type+",col:"+col+",val:"+val+"|";  
			}else {
				
				str = "type:"+type+",col:"+col+",val:"+val.replace("+", ";")+"|";
			}
			
			
			//str = "type:"+type+",col:"+col+",val:"+val.replace("+", ";")+"|";  
			checkflag = true;
		}
		history_reqparms = history_reqparms + str;
		//Alert.show(history_reqparms);
	}	
	
	
	history_reqparms = history_reqparms.substring(0, history_reqparms.length -1);
	history_reqparms = "<query2>" + history_reqparms + "</query2>" 
	history_reqparms = "REFRESH,"+mainBoard + "," + myName_main + "," + _xlcRenditionCode+ "," + history_reqparms	
	// history_reqparms = "REFRESH,"+mainBoard+",FILTER|" + history_reqparms 
	reqParms = history_reqparms;
	//buildDatagrid();
	//dataList_history.send();    
	//Alert.show(reqParms);
	
	return reqParms;
}


private function xmlLineUpforLotpass2(evt:Event, arret:ArrayCollection):String {
	//Alert.show(arret.length.toString());
	
	var checkflag:Boolean = false;
	var history_reqparms:String = new String;
	// Should get from botton to top - as per Christine.
	//for (var i:int=0;i<arret.length;i++){
	for (var i:int=arret.length - 1;i>=0;i--){
		var str:String = new String;
		var type:String = arret[i].datatype;
		var col:String = arret[i].dataField;
		var val:String = arret[i].value;
		//var f_seq:String = pophrmp.mfArray[i].filter_seq;
		val = c_utils.trim(val);
		if (val.length > 0){
			val = val.replace("+", ";")
			// put "=" as a prefix for numeric and date
			if ((type == "D") || (type == "N" )){
				if ((val.substr(0,1) != '>') && (val.substr(0,1) != '<')&&(val.substr(0,1) != '=')){
					val = "=" + val;
				}
			} 
			
			str = "type:"+type+",col:"+col+",val:"+val.replace("+", ";")+"|";  
			checkflag = true;
		}
		history_reqparms = history_reqparms + str;
	}	
	
	
	history_reqparms = history_reqparms.substring(0, history_reqparms.length -1);
	history_reqparms = "<lotquery>" + history_reqparms + "</lotquery>" ; 
	//history_reqparms = "REFRESH,"+mainBoard + "," + myName_main + "," + _xlcRenditionCode+ "," + history_reqparms	
	// history_reqparms = "REFRESH,"+mainBoard+",FILTER|" + history_reqparms 
	//reqParms = history_reqparms;
	//buildDatagrid();
	//dataList_history.send();    
	//Alert.show(reqParms);
	
	return history_reqparms;
}
private function executePersistentDefault(event:Event):void {
	
	
	//  Remove for now  4/12/2013
	/*
	for (var ia:int=0;ia < fhp.length; ia++)  {                
		
		if (fhp[ia].default_view == "Y"){
			
			lbl_persistent_view.text = fhp[ia].filtercode;
		}
	}
	
	*/
	lbl_persistent_view.text = _xlcRenditionCode;
	
	change_filtermacro_persistent(event);
	
	lbl_transient_view.text = 'No selection';
	refreshButton(event);                
	
	
	if (myview_flag == 1){	 
		/* Time to fire up the crunch */
		reqSJ = "";
		reqParmsmvquery = "REFRESH,RETRIEVE|MV_CRUNCH|" + myName_main + "|" + mainBoard + "|"+_xlcRenditionCode+ "|";
		
		retrievemvcrunch.send();              
	}    
	
}
//private var newObject3:datagrid_test = new datagrid_test();
//public var sh_cha:CrunchAnalysis = new CrunchAnalysis;



private function precreateMapper(event:Event):void {
	
	poplistmapper.currentState = 'createmapper';
	poplistmapper.btn_mapper_create.visible = false;
	poplistmapper.btn_mapper_modify.visible = false;
	poplistmapper.btn_mapper_copy.visible = false;
	poplistmapper.btn_mapper_delete.visible = false;
	poplistmapper.btn_mapper_close.visible = false;
	
	poplistmapper.dg_mapper.enabled = false;
	
	poplistmapper["btn_submit"].addEventListener("click", submitMapper);
	
	//	poplistmapper["btn_browse"].addEventListener("click", LaunchTradingParter);
	
	poplistmapper.ti_mapcode.setFocus();
	poplistmapper.ti_mapcode.drawFocus(true);         
}   
/*
public var poptr:TradingPartnerMaintenance;
private function LaunchTradingParter(event:Event):void{

poptr = TradingPartnerMaintenance(
PopUpManager.createPopUp(this, TradingPartnerMaintenance, true)); 


poptr.tp_user_code = myName_main;
poptr.tp_sessid = my_sid;
poptr.tp_company_code = my_c_code1;


poptr["adg_tp"].addEventListener(MouseEvent.CLICK, ClickDatagridViews_tp);
poptr["adg_tp"].addEventListener(KeyboardEvent.KEY_DOWN, EnterDatagridViews_tp);


}

private function ClickDatagridViews_tp(event:Event):void{
Alert.show(poptr.adg_tp.selectedItems.tp_code);
GetChosenDataViews_tp(event);


}
private function EnterDatagridViews_tp(event:KeyboardEvent):void{     

if (event.keyCode == 27){
PopUpManager.removePopUp(poptr);

}
if (event.keyCode == 13){
GetChosenDataViews_tp(event);
}
}    

private function GetChosenDataViews_tp(event:Event):void{
Alert.show("go here again");
Alert.show(poptr.adg_tp.selectedItem.tp_code);
poplistmapper.ti_tradingpartner.text = poptr.adg_tp.selectedItem.tp_code;

PopUpManager.removePopUp(poptr);

}   
*/

private function submitMapper(event:Event):void {
	
	/* Validate Items */
	
	
	if (c_utils.trim(poplistmapper.ti_mapcode.text).length < 1){
		AlertMessageShow("Please enter Map Name");
		return;
	}
	if (c_utils.trim(poplistmapper.ta_mapdescription.text).length < 1){
		AlertMessageShow("Please enter Map Description");
		return;
	}
	if (c_utils.trim(poplistmapper.ti_tradingpartner.text).length < 1){
		AlertMessageShow("Please enter Trading Partner");
		return;
	}
	if (c_utils.trim(poplistmapper.ti_transactionset.text).length < 1){
		AlertMessageShow("Please enter Trading Partner Transaction Set");
		return;
	}
	
	
	
	if (poplistmapper.ti_authenticationfile.text.length > 0){
		
		
		var res_bool:String = "nothing";
		res_bool = poplistmapper.checkIfExist(poplistmapper.ti_authenticationfile.text);
		if (res_bool == "nothing"){
			
			AlertMessageShow("Please enter a correct Authentication File Code or clear the Authentication File code if not required. ");
			return;
		} 
		
		
	}
	
	
	for( var a:int = 0; a < poplistmapper.MapperCollection.length; a++ ){
		
		if (c_utils.trim(poplistmapper.ti_mapcode.text) == poplistmapper.MapperCollection[a]["mapper_cd"]){
			AlertMessageShow("Mapping Code already exist.  Please create a new Mapping Code.");
			return;
			break;
		}        
	}
	
	createMapper(event);
}

private var popshowChart:ShowChart; 
public var popmapper:Mapper;


private function createMapper(event:Event):void {
	
	PopUpManager.removePopUp(poplistmapper);
	popmapper = Mapper(            
		PopUpManager.createPopUp(this, Mapper, true));
	popmapper["btn_close_window"].addEventListener("click", closeMapper);
	popmapper.loc_xlcColumn = _xlcColumn;
	popmapper.r_passed_mainboard = mainBoard;
	popmapper.r_user_code = myName_main;
	popmapper.r_file_passed = "MASTER";
	popmapper.r_sessid = my_sid;
	popmapper.r_company_code = my_c_code1;
	popmapper.r_flag_type = "Create";
	popmapper.r_mapper_code = poplistmapper.ti_mapcode.text;
	popmapper.r_mapper_description = poplistmapper.ta_mapdescription.text;
	popmapper.r_trading_partner = poplistmapper.ti_tradingpartner.text;
	popmapper.r_trading_partner_description = poplistmapper.ti_tradingpartner_desc.text;
	popmapper.r_transaction_set = poplistmapper.ti_transactionset.text;
	popmapper.r_authentication_file = poplistmapper.ti_authenticationfile.text;
	popmapper.r_authentication_file_desc = poplistmapper.ti_authenticationfiledesc.text;
	popmapper.r_root_tag = poplistmapper.ti_roottag.text;
	/*
	popmapper.r_mapper_code = "";
	popmapper.r_mapper_description = "";
	popmapper.r_mapper_tp_code = "";
	popmapper.r_client = "";
	popmapper.r_exp_flname = "";
	popmapper.r_exp_method = "";
	*/
	popmapper.callbackFunction = startMapper;
	
	//reqParms = "REFRESH,RENDITION," + r_passed_mainboard + "," + r_user_code + "," + r_file_passed;
	/*
	popcmrendition.r_sessid = my_sid;
	popcmrendition.r_company_code = my_c_code1;
	popcmrendition.r_user_code = myName_main;
	popcmrendition.r_passed_mainboard = mainBoard;
	popcmrendition.r_passed_mainboardtitle = _xlcTitle + ' Panel/Column';
	popcmrendition.r_passed_eventtitle = 'Create New Rendition';
	//popcmrendition.r_file_passed = "BASE";
	popcmrendition.r_file_passed = "MASTER";
	popcmrendition.r_flag_type = "Create";
	popcmrendition.r_lock_columns = _xlcLockColumn;
	popcmrendition.showCloseButton = false;
	*/
	
	
	
	/*	
	popcmrendition.r_sessid = my_sid;
	popcmrendition.r_company_code = my_c_code1;
	popcmrendition.r_user_code = myName_main;
	popcmrendition.r_passed_mainboard = mainBoard;
	popcmrendition.r_passed_mainboardtitle = _xlcTitle + ' Panel/Column';
	popcmrendition.r_passed_eventtitle = 'Create New Rendition';
	//popcmrendition.r_file_passed = "BASE";
	popcmrendition.r_file_passed = "MASTER";
	popcmrendition.r_flag_type = "Create";
	popcmrendition.r_lock_columns = _xlcLockColumn;
	popcmrendition.showCloseButton = false;
	popcmrendition["btn_close_window"].addEventListener("click", closeRendition);
	popcmrendition.callbackFunction = startRender;
	*/
	//	popcmrendition["btn_save_current"].addEventListener("click", closeRendition);
	//popcmrendition.addEventListener(CloseEvent.CLOSE, closeRendition);
}






private function copyMapper(event:Event):void {
	//Alert.show(poplistmapper.MapperCollection.length.toString());
	if (poplistmapper.dg_mapper.selectedItems.length == 0){
		AlertMessageShow("Please select a row to copy.");
		return;
	}
	
	
	
	
	
	//PopUpManager.removePopUp(pop2);
	popmapper = Mapper(
		PopUpManager.createPopUp(this, Mapper, true));
	popmapper["btn_close_window"].addEventListener("click", closeMapper);
	popmapper.loc_xlcColumn = _xlcColumn;
	popmapper.r_passed_mainboard = mainBoard;
	popmapper.r_user_code = myName_main;
	popmapper.r_file_passed = "MASTER";
	popmapper.r_sessid = my_sid;       
	popmapper.r_company_code = my_c_code1;
	popmapper.r_arr_mapcollection = poplistmapper.MapperCollection;
	popmapper.r_flag_type = "Copy";
	
	
	popmapper.r_mapper_code = poplistmapper.dg_mapper.selectedItem.mapper_cd;
	popmapper.r_mapper_description = poplistmapper.dg_mapper.selectedItem.mapper_ds;
	
	popmapper.r_trading_partner = poplistmapper.dg_mapper.selectedItem.tp_code;
	
	popmapper.r_trading_partner_description = poplistmapper.dg_mapper.selectedItem.tp_name;
	popmapper.r_transaction_set = poplistmapper.dg_mapper.selectedItem.trans_set;
	popmapper.r_authentication_file = poplistmapper.dg_mapper.selectedItem.auth_file;
	popmapper.r_authentication_file_desc = poplistmapper.dg_mapper.selectedItem.auth_desc;
	
	
	popmapper.callbackFunction = startMapper;
	
	PopUpManager.removePopUp(poplistmapper);
}




private function modifyMapper(event:Event):void {
	
	if (poplistmapper.dg_mapper.selectedItems.length == 0){
		AlertMessageShow("Please select a row to modify.");
		return;
	}
	
	
	
	
	
	//PopUpManager.removePopUp(pop2);
	popmapper = Mapper(
		PopUpManager.createPopUp(this, Mapper, true));
	popmapper["btn_close_window"].addEventListener("click", closeMapper);
	popmapper.loc_xlcColumn = _xlcColumn;
	popmapper.r_passed_mainboard = mainBoard;
	popmapper.r_user_code = myName_main;
	popmapper.r_file_passed = "MASTER";
	popmapper.r_sessid = my_sid;
	popmapper.r_company_code = my_c_code1;
	
	popmapper.r_flag_type = "Modify";
	
	
	
	popmapper.r_mapper_code = poplistmapper.dg_mapper.selectedItem.mapper_cd;
	popmapper.r_mapper_description = poplistmapper.dg_mapper.selectedItem.mapper_ds;
	
	popmapper.r_trading_partner = poplistmapper.dg_mapper.selectedItem.tp_code;
	
	popmapper.r_trading_partner_description = poplistmapper.dg_mapper.selectedItem.tp_name;
	popmapper.r_transaction_set = poplistmapper.dg_mapper.selectedItem.trans_set;
	popmapper.r_authentication_file = poplistmapper.dg_mapper.selectedItem.auth_file;
	popmapper.r_authentication_file_desc = poplistmapper.dg_mapper.selectedItem.auth_desc;
	popmapper.r_root_tag = poplistmapper.dg_mapper.selectedItem.root_tag;
	
	
	
	popmapper.callbackFunction = startMapper;  
	
	PopUpManager.removePopUp(poplistmapper);
}



private function pre_startMapper(event:Event):void {
	
	startMapper(event);
	
	
}




public var poplistmapper:ListMapper;
public function startMapper(event:Event):void {
	PopUpManager.removePopUp(pop2);	
	poplistmapper = ListMapper(
		PopUpManager.createPopUp(this, ListMapper, true));
	
	
	
	poplistmapper.loc_mbdcode = toxml_mbdcode;
	poplistmapper.loc_user = myName_main;
	poplistmapper.loc_sid = my_sid;
	poplistmapper.loc_ccode = my_c_code1;
	poplistmapper.loc_ag_application_entry = ag_application_entry;
	
	
	//poplistmapper["btn_mapper_create"].addEventListener("click", createMapper);
	poplistmapper["btn_mapper_create"].addEventListener("click", precreateMapper);
	
	
	poplistmapper["btn_mapper_modify"].addEventListener("click", modifyMapper);
	poplistmapper["btn_mapper_copy"].addEventListener("click", copyMapper);
	
}











private function pre_startExporttoXML(event:Event):void{
	/*
	choose(event:Event)
	var numItems:int = dg.selectedItems.length;
	*/
	if (dg.selectedItems.length > 0){
		startExporttoXML(event);
		choose(event);
	} else {
		startExporttoXML(event);
	}
}         

public var popexporttoxml:ExportToXML;
public function startExporttoXML(event:Event):void {
	
	
	popexporttoxml = ExportToXML(
		PopUpManager.createPopUp(this, ExportToXML, true));
	
	popexporttoxml.loc_mbdcode = mainBoard; 
	popexporttoxml.loc_mbcode = parentApplication.toxml_mbcode;
	
	popexporttoxml.loc_user = myName_main;
	popexporttoxml.loc_sid = my_sid;
	popexporttoxml.loc_ccode = my_c_code1;
	
	popexporttoxml["btn_export_to_xml"].addEventListener("click", validatexportMapperExcel);
	
	
	PopUpManager.centerPopUp(popexporttoxml);   
	
}

private function validatexportMapperExcel(event:Event):void {
	//Alert.show("In Progress");
	
	if (popexporttoxml.detail_grid.text.length <1){
		AlertMessageShow('Mapper Code for should not be null');
		
		return;		
	}
	popexporttoxml.exp_pbar.visible = true;
	/*
	if (popexporttoxml.ti_filename.text.length <1){
	AlertMessageShow('Filename grid should not be null');
	return;		
	}
	*/
	/*
	if (popexporttoxml.detail_grid_map_code.text.length <1){
	AlertMessageShow('Map Code for Detail grid should not be null');
	return;		
	}
	if (popexporttoxml.ti_filename.text.length <1){
	AlertMessageShow('Filename should not be null');
	return;		
	}
	if (popexporttoxml.ti_saveas.text.length >0){
	if (popexporttoxml.ti_tradingpartner.text.length <1){
	AlertMessageShow('Trading Partner should not be null');
	return;		
	}
	if (popexporttoxml.ti_company.text.length <1){
	AlertMessageShow('Company should not be null');
	return;		
	}
	}
	if (popexporttoxml.ti_tradingpartner.text.length >0){
	if (popexporttoxml.ti_saveas.text.length <1){
	AlertMessageShow('Save As should not be null');
	return;		
	}
	
	}
	*/
	exportMapperExcel(event);
	
}







private function exportMapperExcel(event:Event):void {
	//AlertMessageShow(Array1.length.toString());
	//mapper_code,file_name,company_code,<data>311471,311507,311581</data>
	
	var uniquekeys:String = new String();
	for( var a:int = 0; a < Array1.length; a++ ){
		
		uniquekeys = uniquekeys + Array1[a]['upd_unique'] + ',';
	}
	uniquekeys = uniquekeys.substr(0,uniquekeys.length-1);       
	reqParmse2e = "REFRESH,EXPORT_XML,"+ popexporttoxml.detail_grid.text + ',' +
		popexporttoxml.ti_tradingpartner.text + ',' + 
		
		popexporttoxml.ti_company.text + ',' + 
		popexporttoxml.ti_filename.text+ ',<data>' + 
		
		
		
		uniquekeys + '</data>';
	
	//PopUpManager.removePopUp(popexporttoxml);
	exporttoxml.send();	    
	
	
}

public var popworkflow:Workflow;
private function startWorkflow(event:Event):void {
	
	popworkflow = Workflow(
		PopUpManager.createPopUp(this, Workflow, true));
	/*
	pop11.loc_mbdcode = toxml_mbdcode;
	pop11.loc_user = myName_main;
	pop11.loc_sid = my_sid;
	pop11.loc_ccode = my_c_code1;
	pop11.txt_current.text = "Current Rendition: " + _xlcRenditionCode;
	if ( Application.application.parameters.ar == 'N'){
	pop11.btn_rendition_create.enabled = false;
	pop11.btn_rendition_modify.enabled = false;
	pop11.btn_rendition_delete.enabled = false;
	
	}
	*/
	popworkflow["btn_workflow_create"].addEventListener("click", createWorkflow);
	popworkflow["btn_workflow_create"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	popworkflow["btn_workflow_create"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	/*     
	pop11["btn_rendition_modify"].addEventListener("click", modifyRendition);
	pop11["btn_rendition_modify"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	pop11["btn_rendition_modify"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	pop11["btn_rendition_switch"].addEventListener("click", switchRendition);
	pop11["btn_rendition_switch"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	pop11["btn_rendition_switch"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	*/
	//PopUpManager.centerPopUp(pop11);   
	
}





public var popworkfloweditor:WorkflowEditor;
private function createWorkflow(event:Event):void {
	
	PopUpManager.removePopUp(popworkflow);
	popworkfloweditor = WorkflowEditor(
		PopUpManager.createPopUp(this, WorkflowEditor, true));
	
	popworkfloweditor.r_sessid = my_sid;
	popworkfloweditor.r_company_code = my_c_code1;
	popworkfloweditor.r_user_code = myName_main;
	popworkfloweditor.r_passed_mainboard = mainBoard;
	popworkfloweditor.r_passed_mainboardtitle = 'Available Jobs and Workflows';
	popworkfloweditor.r_passed_eventtitle = 'Create New WorkFlow';
	//popcmrendition.r_file_passed = "BASE";
	popworkfloweditor.r_file_passed = "MASTER";
	popworkfloweditor.r_flag_type = "Create";
	popworkfloweditor.r_lock_columns = _xlcLockColumn; 
	popworkfloweditor.r_array_1= Array1;
	
	popworkfloweditor.showCloseButton = false;    
	popworkfloweditor["btn_close_window"].addEventListener("click", closeWorkflow);
	popworkfloweditor.callbackFunction = startWorkflow;
	
	
}

private function launchXMLControl(event:ResultEvent):void{
	var url_str:String =event.result.data.xmlcontrolurl; 
	navigateToURL(new URLRequest(url_str+ '&c='+ my_c_code1 + '&cd='+ mx.core.FlexGlobals.topLevelApplication.parameters.cd),'_blank');
}






//public var popcmrendition:RenditionCM
private var Arr_columnRendition_temp:ArrayCollection = new ArrayCollection;
private function runColumn(event:Event):void {
	//Alert.show(history_reqParms_str);  
	//Alert.show(Arr_columnRendition.length.toString());
	 //Arr_columnRendition_temp= Arr_columnRendition;
	 //Alert.show("1: " + Arr_columnRendition_temp.length.toString());
	
	Arr_columnRendition_temp = new ArrayCollection;
	for (var b:uint=0;b<Arr_columnRendition.length;b++){
		
		
			var NewObj:Object = new Object;
			NewObj.id = Arr_columnRendition[b]["id"];
			NewObj.type = Arr_columnRendition[b]["type"];
			NewObj.columnname = Arr_columnRendition[b]["columnname"];
			NewObj.headertext = Arr_columnRendition[b]["headertext"];
			NewObj.bgcolor = Arr_columnRendition[b]["bgcolor"];
			Arr_columnRendition_temp.addItem(NewObj);
			
			
		
	}   
	
	 
	
	popcmrendition = RenditionCM(
		PopUpManager.createPopUp(this, RenditionCM, true));      
	popcmrendition.r_sessid = my_sid;  
	popcmrendition.r_company_code = my_c_code1;
	popcmrendition.r_user_code = myName_main;
	popcmrendition.r_passed_mainboard = mainBoard;
	popcmrendition.r_passed_mainboardtitle = _xlcTitle + ' Panel/Column';
	popcmrendition.r_passed_maintitle = _xlcTitle;
	popcmrendition.r_passed_eventtitle = 'Create New Rendition';
	popcmrendition.r_file_passed = "MASTER";
	popcmrendition.r_flag_type = "Create";  
	popcmrendition.r_lock_columns = _xlcLockColumn; 
	popcmrendition.showCloseButton = false;
	popcmrendition.history_query = history_reqParms_str;
	popcmrendition.col_xlcHistory = _xlcHistory;   
	popcmrendition.UserRenditiontdObjectCollection = Arr_columnRendition;
	popcmrendition.ArrayColumnList = ArrayFilterInsert;
	
	
	popcmrendition["btn_close_window"].addEventListener("click", runColumn_close);
	//popcmrendition["btn_dg2_implement"].addEventListener("click", runColumn_implement);
	popcmrendition.callbackFunctionImplement = startRenderImplement;
	popcmrendition.callbackFunctionImplementRetain = startRenderImplementRetain;
	
} 


private function runColumn_close(event:Event):void{
	
	//Alert.show("2: " + Arr_columnRendition_temp.length.toString());
	
	Arr_columnRendition = new ArrayCollection;
	
	for (var b:uint=0;b<Arr_columnRendition_temp.length;b++){
		
		
		var NewObj:Object = new Object;
		NewObj.id = Arr_columnRendition_temp[b]["id"];
		NewObj.type = Arr_columnRendition_temp[b]["type"];
		NewObj.columnname = Arr_columnRendition_temp[b]["columnname"];
		NewObj.headertext = Arr_columnRendition_temp[b]["headertext"];
		NewObj.bgcolor = Arr_columnRendition_temp[b]["bgcolor"];
		Arr_columnRendition.addItem(NewObj);
		
		
		
	}   
	
//	Alert.show("2: " + Arr_columnRendition_temp.length.toString());
//	Arr_columnRendition = Arr_columnRendition_temp;
//	Alert.show("3: " + Arr_columnRendition.length.toString());
	
	PopUpManager.removePopUp(popcmrendition);
}
private var Arr_columnRendition:ArrayCollection;
public function startRenderImplement(event:Event):void {
	global_rr_return = "refresh";
	
	Arr_columnRendition = new ArrayCollection;
	Arr_columnRendition = popcmrendition.UserRenditiontdObjectCollection;
	
	_xlcRenditionCode = "No Selection";
	var filter_head:String = '<filter>'
	var filter_tail:String = '</filter>'
		var string_detail:String = new String;
	 string_detail = string_detail + '<data>' +
		'<action>' +  '</action>' +
		'<datafield>' + '</datafield>' +
		'<datatype>' + '</datatype>' +
		//'<value>' + (ArrayFilterInsert[i].value.toString()) + '</value>' +
		'<value>' + '</value>' +
		'<sequence>' +  '</sequence>' +
		'</data>';
	var finalFilterXML = ('REFRESH,UPD_MV_FILTER,' + filter_head + 
		'<usercode>' + myName_main + '</usercode>' +  
		//'<filtercode>' + popcmmyviews.inputcode.text + '</filtercode>' +
		'<filtercode>' + "No Selection" + '</filtercode>' +
		'<xmlhdrcode>' + _xlcCode + '</xmlhdrcode>' +
		'<xmlhdrname>' + _xlcTitle + '</xmlhdrname>' +
		'<clientcode>' + '001' + '</clientcode>' +
		'<filtertype>' + 'P' + '</filtertype>' +
		string_detail +
		filter_tail);
	reqParmsMyViewParameters = finalFilterXML;
	saveMyViewFilters.send();
	
	retfromrendition = true;
	//reqParms = "REFRESH,RETRIEVE|GRIDHEADERDOC|" + myName_main + "|" + toxml_mbdcode + "|" +_xlcRenditionCode+ "|";
	reqParms = "REFRESH,RETRIEVE|GRIDHEADERDOC2|" + myName_main + "|" + toxml_mbdcode + "|" + "No Selection" + "|";
	propertiesList.send();
} 
 
public function startRenderImplementRetain(event:Event):void {
	global_rr_return = "retain";
	
	Arr_columnRendition = new ArrayCollection;
	Arr_columnRendition = popcmrendition.UserRenditiontdObjectCollection;
	
	_xlcRenditionCode = "No Selection";
	
	saveCurSort(event);
	
	
	
	 
	
	
	retfromrendition = true;
	//reqParms = "REFRESH,RETRIEVE|GRIDHEADERDOC|" + myName_main + "|" + toxml_mbdcode + "|" +_xlcRenditionCode+ "|";
	reqParms = "REFRESH,RETRIEVE|GRIDHEADERDOC2|" + myName_main + "|" + toxml_mbdcode + "|" + "No Selection" + "|";
	propertiesList.send();
}


public var popmyviews:MyViewsList;
public function startMyViews(event:Event):void {
	
	//MyViewButtons.send();
	
	popmyviews = MyViewsList(
		PopUpManager.createPopUp(this, MyViewsList, true));
	
	popmyviews.loc_mbdcode = toxml_mbdcode;
	popmyviews.loc_user = myName_main;
	popmyviews.loc_sid = my_sid;
	popmyviews.loc_ccode = my_c_code1;
	popmyviews.loc_rendcode = _xlcRenditionCode;   
	popmyviews.txt_current.text = "Current View: " + _xlcRenditionCode;
	
	
	
	popmyviews["btn_myviews_create"].addEventListener("click", createMyViews);
	popmyviews["btn_myviews_create"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	popmyviews["btn_myviews_create"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	
	
	
	popmyviews["btn_myviews_merge"].addEventListener("click", mergeMyViews);
	popmyviews["btn_myviews_merge"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	popmyviews["btn_myviews_merge"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	
	   
	    
	
	popmyviews["btn_rendition_switch"].addEventListener("click", switchRendition);
	popmyviews["btn_rendition_switch"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	popmyviews["btn_rendition_switch"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	
	popmyviews["btn_myview_close"].addEventListener("click", closeMyView);
	popmyviews["btn_myview_close"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	popmyviews["btn_myview_close"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	
	
	
} 

public var popcmmyviews:MyViewsCM;
private function createMyViews(event:Event):void {
	
	

	
	
	
	updateMyViewSequence(event);
	 
	PopUpManager.removePopUp(popmyviews);
	popcmmyviews = MyViewsCM(
		PopUpManager.createPopUp(this, MyViewsCM, true));
	popcmmyviews.inUse = true;
	
	popcmmyviews.r_sessid = my_sid;
	popcmmyviews.r_company_code = my_c_code1;
	popcmmyviews.r_user_code = myName_main;
	popcmmyviews.create_modify = "C"; 
	popcmmyviews.arr_columns = arr_myviewbuttons;
	
	popcmmyviews.loc_mbdcode = toxml_mbdcode;
//	popmyviews.loc_user = myName_main;
	
	//popcmmyviews.arr_listviews = popmyviews.RenditionCollection;
	
	//inputcode
	
	//inputdescription
	
	
	if (_xlcHistory == "Yes"){
	popcmmyviews.hbox_aa.visible = true;
	popcmmyviews.aa_yes.selected = true;
	popcmmyviews.aa_no.selected = false;
	}else { 
		popcmmyviews.hbox_aa.visible = false;
		popcmmyviews.aa_yes.selected = true;
		popcmmyviews.aa_no.selected = false; 
	}
	popcmmyviews["btn_save_current"].addEventListener("click", saveMyView);
	popcmmyviews["btn_cancel"].addEventListener("click", closeMyViewCM);
	
	
	
	
	
	
}



  
public var popcmmyviewsmerge:MyViewsMerge;
private function mergeMyViews(event:Event):void {
	updateMyViewSequence(event);
	
	
	
	PopUpManager.removePopUp(popmyviews);
	popcmmyviewsmerge = MyViewsMerge(
		PopUpManager.createPopUp(this, MyViewsMerge, true));
	
	
	popcmmyviewsmerge.r_sessid = my_sid;
	popcmmyviewsmerge.r_company_code = my_c_code1;
	popcmmyviewsmerge.r_user_code = myName_main;
	popcmmyviewsmerge.r_actiongricode = mainBoard;
	popcmmyviewsmerge.r_ag_application_entry = ag_application_entry;
	
	
	popcmmyviewsmerge["btn_save_current"].addEventListener("click", saveMyViewMigration);
	
	popcmmyviewsmerge["btn_cancel"].addEventListener("click", closeMyViewMerge);
	
	
	    
	  
}





private function saveMyViewMigration(event:Event):void {
	
	// Check operator access.
	// O - Operator Code
	// N - Not Allowed
	// G - Generic
	var flag_y_n:String = new String();
	if (popcmmyviewsmerge.gen.selected == true){
		flag_y_n = "Y"
	} else {
		flag_y_n = "N"
			
	}
	if ( Application.application.parameters.av == 'O'){
		if (popcmmyviewsmerge.gen.selected == true){
			AlertMessageShow('You are not allowed to create/modify a Generic View.')
			return;
		}    
	}
	
	//if (popcmmyviews.create_modify == "C"){
		
		
		if (popcmmyviewsmerge.inputcode.text == ""){
			AlertMessageShow("Please Enter Code.");
			popcmmyviewsmerge.inputcode.setFocus();
			popcmmyviewsmerge.inputcode.setStyle("backgroundColor", "#C7CECC");
			popcmmyviewsmerge.inputdescription.setStyle("backgroundColor", "#ffffff");
			return;
			
		}
		
		
		if (myName_main.toUpperCase() != 'MAVES'){
			if(((popcmmyviewsmerge.inputcode.text).toUpperCase()).substr(0,4) == 'BASE'){
				AlertMessageShow("'BASE' Code is not allowed");
				popcmmyviewsmerge.inputcode.setFocus();
				popcmmyviewsmerge.inputcode.setStyle("backgroundColor", "#C7CECC");
				popcmmyviewsmerge.inputdescription.setStyle("backgroundColor", "#ffffff");
				return;
			}	
		}
		
		if (popcmmyviewsmerge.inputdescription.text == ""){
			AlertMessageShow("Please Enter Description.");
			popcmmyviewsmerge.inputdescription.setFocus();
			popcmmyviewsmerge.inputcode.setStyle("backgroundColor", "#ffffff"); 	
			popcmmyviewsmerge.inputdescription.setStyle("backgroundColor", "#C7CECC");
			return;
		}
	//}
	
		
		
		if (popcmmyviewsmerge.rendcode.text.length < 1){
			AlertMessageShow("Please choose Rendition");
			
			return;
		}
		
		if ((popcmmyviewsmerge.persistentviewcode.text.length > 1) && (popcmmyviewsmerge.rendcode.text.length < 1)) {
			AlertMessageShow("Please choose Rendition");
			
			return;
		}
		
	if (popcmmyviewsmerge.uoc.selected == true){
		if (popcmmyviewsmerge.inputcode.text.substr(0,1) != '*'){
			popcmmyviewsmerge.inputcode.text = '*' + popcmmyviewsmerge.inputcode.text
			
		}
		usermv = myName_main; 
	}
	
	if (popcmmyviewsmerge.gen.selected == true){
		if (popcmmyviewsmerge.inputcode.text.substr(0,1) == '*'){ 
			popcmmyviewsmerge.inputcode.text = popcmmyviewsmerge.inputcode.text.substr(1,popcmmyviewsmerge.inputcode.text.length);
		}
		usermv = "gen"; 
	}
	
	
	 
	
	for( var a:int = 0; a < popmyviews.RenditionCollection.length; a++ ){
		
		
		if (popmyviews.RenditionCollection[a]["viewcode"] == c_utils.trim(popcmmyviewsmerge.inputcode.text)){
			AlertMessageShow("MyView Code already exist!");
			if (popcmmyviewsmerge.inputcode.text.substr(0,1) == '*'){ 
				popcmmyviewsmerge.inputcode.text = popcmmyviewsmerge.inputcode.text.substr(1,popcmmyviewsmerge.inputcode.text.length);
			}
			return;
			break;
			
			
		}
		
		
	}
	
	
	reqParmsMyViewParametersOldRenditionPersistent =  "REFRESH,CREATE|MYVIEW|" + popcmmyviewsmerge.inputcode.text + "|" + 
		popcmmyviewsmerge.inputdescription.text + "|" + 
		flag_y_n + "|" + 
			myName_main + "|" + 
			mainBoard + "|" +
			popcmmyviewsmerge.rendcode.text + "|" + 
			popcmmyviewsmerge.persistentviewcode.text + "|";
			
			saveMyViewOldRenditionPerstent.send();
	//saveMyViewParts(event);
	
}   

private function closeMyViewMerge(event:Event):void {
	PopUpManager.removePopUp(popcmmyviewsmerge);
	startMyViews(event);
}


private function closeMyViewCM(event:Event):void {
	PopUpManager.removePopUp(popcmmyviews);
	popcmmyviews.inUse = false;
	startMyViews(event);
}

private function saveMyView(event:Event):void {
	popcmmyviews.inUse = false;
	// Check operator access.
	// O - Operator Code
	// N - Not Allowed
	// G - Generic
	
	
	
	if ( Application.application.parameters.av == 'O'){
		if (popcmmyviews.gen.selected == true){
			AlertMessageShow('You are not allowed to create/modify a Generic View.')
			return;
		}    
	}

	if (popcmmyviews.create_modify == "C"){
		
		
		if (popcmmyviews.inputcode.text == ""){
			AlertMessageShow("Please Enter Code.");
			popcmmyviews.inputcode.setFocus();
			popcmmyviews.inputcode.setStyle("backgroundColor", "#C7CECC");
			popcmmyviews.inputdescription.setStyle("backgroundColor", "#ffffff");
			return;
			
		}
		
		
		if (myName_main.toUpperCase() != 'MAVES'){
			if(((popcmmyviews.inputcode.text).toUpperCase()).substr(0,4) == 'BASE'){
				AlertMessageShow("'BASE' Code is not allowed");
				popcmmyviews.inputcode.setFocus();
				popcmmyviews.inputcode.setStyle("backgroundColor", "#C7CECC");
				popcmmyviews.inputdescription.setStyle("backgroundColor", "#ffffff");
				return;
			}	
		}
		
		if (popcmmyviews.inputdescription.text == ""){
			AlertMessageShow("Please Enter Description.");
			popcmmyviews.inputdescription.setFocus();
			popcmmyviews.inputcode.setStyle("backgroundColor", "#ffffff"); 	
			popcmmyviews.inputdescription.setStyle("backgroundColor", "#C7CECC");
			return;
		}
	}
	

	if (popcmmyviews.uoc.selected == true){
		if (popcmmyviews.inputcode.text.substr(0,1) != '*'){
			popcmmyviews.inputcode.text = '*' + popcmmyviews.inputcode.text
			
		}
		usermv = myName_main; 
	}
	
	if (popcmmyviews.gen.selected == true){
		if (popcmmyviews.inputcode.text.substr(0,1) == '*'){ 
			popcmmyviews.inputcode.text = popcmmyviews.inputcode.text.substr(1,popcmmyviews.inputcode.text.length);
		}
		usermv = "gen"; 
	}
	

	/*  Remove this for now to test the modify function.*/
	
	for( var a:int = 0; a < popmyviews.RenditionCollection.length; a++ ){
		
		
		if (c_utils.trim(popmyviews.RenditionCollection[a]["viewcode"]) == c_utils.trim(popcmmyviews.inputcode.text)){
			
			
			
			if (c_utils.trim(popmyviews.RenditionCollection[a]["create_by"]) != c_utils.trim(myName_main)){
				AlertMessageShow("You are not allowed to edit this MyView Code.  This Code belongs to user " + c_utils.trim(popmyviews.RenditionCollection[a]["create_by"]) + "." )
				return;
				break;
			}
			/*
			AlertMessageShow("MyView Code already exist!"); 
			if (popcmmyviews.inputcode.text.substr(0,1) == '*'){ 
				popcmmyviews.inputcode.text = popcmmyviews.inputcode.text.substr(1,popcmmyviews.inputcode.text.length);
			}
			
			if (popcmmyviews.inputcode.text.substr(0,1) == '*'){ 
			popcmmyviews.inputcode.text = popcmmyviews.inputcode.text.substr(1,popcmmyviews.inputcode.text.length);
			}
			
			
			*/
			
			
			 
		}
		
		
	}

	saveMyViewParts(event);
	
}   

private function saveChart(event:Event):void {
	
	Alert.show("go here");
}



private function saveChart_Grandtotal(event:Event):void{
	//	Alert.show(	popshowChart_crunch.cap_title + " : " + 
	//		popshowChart_crunch.showlocal_crunch );
	myview_level = 2;
	createMyViews_ChartGrandTotal(event);
}

private function saveCrunch(event:Event):void {
	
	
	
	
	
	myview_level = 1;
	createMyViews_Crunch(event);
	
}


private function saveCrunchSubtotal(event:Event):void {
	//Alert.show(subtotalselectedindex.toString()); 
	myview_level = 1;
	createMyViews_Crunch(event);
	
}

private function createMyViews_ChartGrandTotal(event:Event):void {
	startMyViews(event);
	PopUpManager.removePopUp(popmyviews);
	//	createMyViews(event);
	
	
	popcmmyviews = MyViewsCM(
		PopUpManager.createPopUp(this, MyViewsCM, true));
	
	
	popcmmyviews.r_sessid = my_sid;
	popcmmyviews.r_company_code = my_c_code1;
	popcmmyviews.r_user_code = myName_main;
	popcmmyviews.create_modify = "C"; 
	popcmmyviews.arr_columns = arr_myviewbuttons;
	popcmmyviews.hbox_aa.visible = false;
	popcmmyviews.aa_yes.selected = true;
	popcmmyviews.aa_no.selected = false; 
	
	popcmmyviews["btn_save_current"].addEventListener("click", saveMyView_Crunch);
	popcmmyviews["btn_cancel"].addEventListener("click", closeMyViewCM_Crunch);
	
}

private function createMyViews_Crunch(event:Event):void {
	startMyViews(event);
	PopUpManager.removePopUp(popmyviews);
	//	createMyViews(event);
	
	
	popcmmyviews = MyViewsCM(
		PopUpManager.createPopUp(this, MyViewsCM, true));
	
	
	popcmmyviews.r_sessid = my_sid;   
	popcmmyviews.r_company_code = my_c_code1;
	popcmmyviews.r_user_code = myName_main;
	popcmmyviews.create_modify = "C"; 
	popcmmyviews.arr_columns = arr_myviewbuttons;
	
	
	 
		popcmmyviews.hbox_aa.visible = false;
		popcmmyviews.aa_yes.selected = true;
		popcmmyviews.aa_no.selected = false; 
	
	
	popcmmyviews["btn_save_current"].addEventListener("click", saveMyView_Crunch);
	popcmmyviews["btn_cancel"].addEventListener("click", closeMyViewCM_Crunch);
	
}
private function saveMyView_Crunch(event:Event):void {
	saveMyView(event);
	PopUpManager.removePopUp(popcmmyviews);  
}
private function closeMyViewCM_Crunch(event:Event):void {
	PopUpManager.removePopUp(popcmmyviews);
	//startMyViews(event);
}

private var popresetchoices:ResetChoices;
private function launchResetChoices(event:Event):void {
	if(!popresetchoices || !popresetchoices.inUse)
	{
		popresetchoices = ResetChoices(
			
			PopUpManager.createPopUp(this, ResetChoices, false));
		popresetchoices.inUse = true;  
	}     
	
	popresetchoices.myviewcode = _xlcRenditionCode;
	popresetchoices["btn_previous"].addEventListener("click", action_reset); 
	//popresetchoices["btn_previous"].addEventListener(KeyboardEvent.KEY_DOWN, action_reset);
	popresetchoices["btn_previous"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	popresetchoices["btn_previous"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	      
	
	
	popresetchoices["btn_default"].addEventListener("click", applyResetChoice); 
	//popresetchoices["btn_previous"].addEventListener(KeyboardEvent.KEY_DOWN, action_reset);
	popresetchoices["btn_default"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
	popresetchoices["btn_default"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
	
			
		
			
}


private function applyResetChoice(e:Event):void {
	
	
	
	
	
	myview_flag = 1;
	myviews_code.text = popmyviews.dg_rendition.selectedItem.viewcode;
	
	if (popmyviews.dg_rendition.selectedItems.length == 0){
		AlertMessageShow("Please select a row to render.");
		return;  
	}   
	popmyviews.txt_current.text = "Currently in use: " + popmyviews.dg_rendition.selectedItem.viewcode;
	popmyviews.loc_rendcode = popmyviews.dg_rendition.selectedItem.viewcode; 
	
	retfromrendition = true;
	reqParms = "REFRESH,RETRIEVE|GRIDHEADERDOC2|" + myName_main + "|" + toxml_mbdcode + "|" + popmyviews.dg_rendition.selectedItem.viewcode + "|";
	_xlcRenditionCode = popmyviews.dg_rendition.selectedItem.viewcode;  
	propertiesList.send();
	
}

private function createMyViewButtons(event:Event):void {
	
	var MyViewbuttonNew:HighViewButton;
	 
	//myview_buttons = new HBox;
	myview_buttons.removeAllChildren();
	for( var x:int = 0; x < arr_myviewbuttons.length; x++ ){
		
		/*  Check only for allowed display by the user  */
		if (arr_myviewbuttons[x].display == "Y"){
				MyViewbuttonNew = new HighViewButton;
				
				if ((arr_myviewbuttons[x].viewcode).substr(0,1) == "*"){
					//MyViewbuttonNew.label = (arr_myviewbuttons[x].viewcode).substr(1,(arr_myviewbuttons[x].viewcode).length);
					MyViewbuttonNew.label = arr_myviewbuttons[x].btnlabel;
				} 
				else{
				MyViewbuttonNew.label = arr_myviewbuttons[x].btnlabel;
				}
				MyViewbuttonNew.viewcode = arr_myviewbuttons[x].viewcode;
				MyViewbuttonNew.label = arr_myviewbuttons[x].btnlabel;
				MyViewbuttonNew.toolTip = arr_myviewbuttons[x].viewdesc + " [" + arr_myviewbuttons[x].type  + "]";
				MyViewbuttonNew.addEventListener("click",choose_myviewbutton);  //set an event listener 
				MyViewbuttonNew.addEventListener( "click",profiledatagridListROver);    
				MyViewbuttonNew.addEventListener( "click",profiledatagridListROut);
				
				
				
				myview_buttons.addChild(MyViewbuttonNew); 
		}		
	}
	

	
	
	/*
	
	
	for (var a:int = 0; a<ArrayColumnGroup.length; a++){
		var PanelsbuttonNew:HighViewButton;
		PanelsbuttonNew = new HighViewButton; 
		PanelsbuttonNew.label = ArrayColumnGroup[a].headerText;
		
		PanelsbuttonNew.columnstart = ArrayColumnGroup[a].columnstart;
		PanelsbuttonNew.extensible = ArrayColumnGroup[a].extensible;
		//Alert.show(ArrayColumnGroup[a].extensible);
		if (ArrayColumnGroup[a].extensible == 'yes'){
			PanelsbuttonNew.loc_color = 'orange'
		} else {   
			PanelsbuttonNew.loc_color = 'black'
			
		}
		PanelsbuttonNew.index = ArrayColumnGroup[a].idx;      
		PanelsbuttonNew.addEventListener("click",change_columngroup_for_panels);  //set an event listener 
		PanelsbuttonNew.addEventListener( "click",profiledatagridListROver);
		PanelsbuttonNew.addEventListener( "click",profiledatagridListROut);
		
		addObjectToArrayPanel(PanelsbuttonNew);
		hbox_special_panel.addChild(PanelsbuttonNew); 
		//tab_panels.addChild(PanelsbuttonNew);    
		
		   
	}	  
	*/
	
	
}

private function choose_myviewbutton(event:Event):void {
	//Alert.show(event.currentTarget.viewcode);
	  
	myview_flag = 1;
	myviews_code.text = event.currentTarget.viewcode
	//_xlcRenditionCode = event.currentTarget.viewcode;
	myviews_btntitle.text = event.currentTarget.label; 
	
	
	retfromrendition = true;
	reqParms = "REFRESH,RETRIEVE|GRIDHEADERDOC2|" + myName_main + "|" + toxml_mbdcode + "|" + event.currentTarget.viewcode + "|";
	_xlcRenditionCode =event.currentTarget.viewcode;  
	_xlcRenditionbtntitle = event.currentTarget.label;
	
	propertiesList.send();
/*
	
	
	myview_flag = 1;
	myviews_code.text = popmyviews.dg_rendition.selectedItem.viewcode;
	
	if (popmyviews.dg_rendition.selectedItems.length == 0){
	AlertMessageShow("Please select a row to render.");
	return;  
	}   
	popmyviews.txt_current.text = "Currently in use: " + popmyviews.dg_rendition.selectedItem.viewcode;
	popmyviews.loc_rendcode = popmyviews.dg_rendition.selectedItem.viewcode; 
	
	retfromrendition = true;
	reqParms = "REFRESH,RETRIEVE|GRIDHEADERDOC|" + myName_main + "|" + toxml_mbdcode + "|" + popmyviews.dg_rendition.selectedItem.viewcode + "|";
	_xlcRenditionCode = popmyviews.dg_rendition.selectedItem.viewcode;  
	propertiesList.send();
	
	 
	*/
}    



private function updateMyViewSequence(event:Event):void{
	
	var finalres:String = new String;
	for (var i:int=0;i<popmyviews.RenditionCollection.length;i++)  {
		finalres = finalres + c_utils.trim(popmyviews.RenditionCollection[i]['viewcode']) + ",";
		//Alert.show(finalres);
	}
	  
	finalres = finalres.substr(0,finalres.length-1);
	
	reqParmsmvquery = 'REFRESH,UPDATE|MYVIEWSEQ|' +  myName_main + "|" + toxml_mbdcode + "|" + finalres + "|";
	//Alert.show(reqParms);     
	updatemyview_sequence.send();
	
}
