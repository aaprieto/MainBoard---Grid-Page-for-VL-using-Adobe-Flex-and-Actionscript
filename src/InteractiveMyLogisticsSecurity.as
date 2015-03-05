import flash.ui.Keyboard;

import mx.collections.ArrayCollection;

public var interfacesecuritygroupsoperationsprofile:InterfaceOperatorGroupsSecurityProfile; 
public var interfacesecurityoperationsprofile:InterfaceOperatorSecurityProfile;
private function LaunchMyLogSecurityOperatorGroups(event:Event):void{
	
	if (dg.selectedItems.length > 1){
		AlertMessageShow("You can only select one record");
		return;
	}
	retrieve_maintainrendition.send();
	
}    


 
private function addOperatorGroups(event:Event):void {
	
	/* validate first */
	if (interfacesecuritygroupsoperationsprofile.ti_groupcodesuffix.text.length < 2){
		AlertMessageShow("Please Enter the 2 character Group Code");
		return;
	}     
	
	if (interfacesecuritygroupsoperationsprofile.ti_groupdescription.text.length < 1){
		AlertMessageShow("Please Enter Group Description");
		return;
	}
	if (interfacesecuritygroupsoperationsprofile.rendition_hidden_code.text.length < 1){
		AlertMessageShow("Please Enter a specific Rendition for a Group");
		return;
	}
	if (interfacesecuritygroupsoperationsprofile.view_hidden_code.text.length < 1){
		AlertMessageShow("Please Enter a specific View for a Group");
		return;
	}
	var loc_groupcode:String = interfacesecuritygroupsoperationsprofile.ti_groupcodeprefix.text + interfacesecuritygroupsoperationsprofile.ti_groupcodesuffix.text
	
	for (var i:int=0;i<tdObjectCollection.length;i++)  { 
		if (loc_groupcode.toUpperCase() == tdObjectCollection[i]['group_code'].toUpperCase()){
			AlertMessageShow("Group Code Already Exist")
			return;
			break;
		}	
	}
		/* Everything's good - Time to create the request Baby! */
	reqParms = "REFRESH,UPDATE|OPERATORGROUP|" +  loc_groupcode + "|" + interfacesecuritygroupsoperationsprofile.ti_groupdescription.text +
		"|" + interfacesecuritygroupsoperationsprofile.rendition_hidden_code.text + "|" +interfacesecuritygroupsoperationsprofile.view_hidden_code.text + "|";
	add_maintain_operatorgroup.send();
}

private function deleteOperatorGroups(event:Event):void {
	
	reqParms = "REFRESH,DELETE|OPERATORGROUP|" + 
		interfacesecuritygroupsoperationsprofile.ti_groupcodeprefix.text + 
		interfacesecuritygroupsoperationsprofile.ti_groupcodesuffix.text + "|";
	delete_maintain_operatorgroup.send();
}



private function updateOperatorGroups(event:Event):void {
	//Alert.show( interfacesecuritygroupsoperationsprofile.cb_maintainrenditions.selectedItem.data);
	/* validate first */
	if (interfacesecuritygroupsoperationsprofile.ti_groupcodesuffix.text.length < 1){
		AlertMessageShow("Please Enter Group Code");
		return;
	}
	
	if (interfacesecuritygroupsoperationsprofile.ti_groupdescription.text.length < 1){
		AlertMessageShow("Please Enter Group Description");
		return;
	}
	var loc_groupcode:String = interfacesecuritygroupsoperationsprofile.ti_groupcodeprefix.text + interfacesecuritygroupsoperationsprofile.ti_groupcodesuffix.text
	/* Everything's good - Time to create the request Baby! */
	reqParms = "REFRESH,UPDATE|OPERATORGROUP|" +  loc_groupcode + "|" + interfacesecuritygroupsoperationsprofile.ti_groupdescription.text +
		"|" +  interfacesecuritygroupsoperationsprofile.rendition_hidden_code.text + "|" +interfacesecuritygroupsoperationsprofile.view_hidden_code.text + "|";
	add_maintain_operatorgroup.send();
}
////////////////////////////////////////////////////
///// Configure PassPhrase /////////////////////
///////////////////////////////////////////////

private var interfacepassphraseconfig:InterfacePassphraseConfig;
private function LaunchConfigPassphrase(event:Event, s_id:String, c_code:String):void{
	  
	interfacepassphraseconfig = InterfacePassphraseConfig(
		PopUpManager.createPopUp(this, InterfacePassphraseConfig, true));
	interfacepassphraseconfig.loc_ses_id = s_id;
	interfacepassphraseconfig.loc_c_code = c_code;
	interfacepassphraseconfig.loc_str_app = ag_application_entry;
	interfacepassphraseconfig.loc_user = myName_main;  
	
	
}    



/////////////////////////////////////////////////////
///////  OPERATORS   ////////////////////////////////
/////////////////////////////////////////////////////

 

private function LaunchMyLogSecurityOperator(event:Event):void{
	
	if (dg.selectedItems.length > 1){
		AlertMessageShow("You can only select one record");
		return;
	}
	
	
	if (dg.selectedItems.length == 0){ 
		retrieve_groupforoperators.send();
	}
	if (dg.selectedItems.length == 1){
		retrieve_operator.send();
		//retrieve_groupforoperators.send();
	}
		
	
	//

}    


private var _maintainrenditions:ArrayCollection = new ArrayCollection; 
private function retrieveMaintainRenditionHandler(event:ResultEvent):void{
	if ( event.result.ezware_response.status != 'OK' ) {
		var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
		AlertMessageShow(s_ret);
		return;
	}	    
	_maintainrenditions = new ArrayCollection();
	
	if (event.result.ezware_response.refresh_data.maintainrenditions.data == null)
	{
		_maintainrenditions=new ArrayCollection()
	}
	else if (event.result.ezware_response.refresh_data.maintainrenditions.data is ArrayCollection)
	{
		_maintainrenditions=event.result.ezware_response.refresh_data.maintainrenditions.data;
	}
	else if (event.result.ezware_response.refresh_data.maintainrenditions.data is ObjectProxy)
	{
		_maintainrenditions = new ArrayCollection(ArrayUtil.toArray(event.result.ezware_response.refresh_data.maintainrenditions.data));   
	}
	
	retrieve_maintainview.send();
}    
    

private var _maintainviews:ArrayCollection = new ArrayCollection; 

private function retrieveMaintainViewHandler(event:ResultEvent):void{
	if ( event.result.ezware_response.status != 'OK' ) {
		var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
		AlertMessageShow(s_ret);
		return;
	}	
	_maintainviews = new ArrayCollection();
	
	if (event.result.ezware_response.refresh_data.maintainviews.data == null)
	{
		_maintainviews=new ArrayCollection()
	}
	else if (event.result.ezware_response.refresh_data.maintainviews.data is ArrayCollection)
	{
		_maintainviews=event.result.ezware_response.refresh_data.maintainviews.data;
	}
	else if (event.result.ezware_response.refresh_data.maintainviews.data is ObjectProxy)
	{
		_maintainviews = new ArrayCollection(ArrayUtil.toArray(event.result.ezware_response.refresh_data.maintainviews.data));   
	}
	MaintainViewsPopUp(event);
}


private function MaintainViewsPopUp(event:Event):void{
	
	
	if (dg.selectedItems.length == 0){  // Add 
	
	interfacesecuritygroupsoperationsprofile = InterfaceOperatorGroupsSecurityProfile(
	PopUpManager.createPopUp(this, InterfaceOperatorGroupsSecurityProfile, true));
	interfacesecuritygroupsoperationsprofile.headtitle = "Add"
	interfacesecuritygroupsoperationsprofile.maintenance_code = "A"
	interfacesecuritygroupsoperationsprofile.user = myName_main;
	interfacesecuritygroupsoperationsprofile.group_code = "";
	interfacesecuritygroupsoperationsprofile.group_description = "";
	interfacesecuritygroupsoperationsprofile.maintain_renditions = "N";
	interfacesecuritygroupsoperationsprofile.maintain_views = "N";
	interfacesecuritygroupsoperationsprofile.upd_date = "";
	interfacesecuritygroupsoperationsprofile.upd_time = "";
	interfacesecuritygroupsoperationsprofile.unique_key = "";
	interfacesecuritygroupsoperationsprofile.renditionAC = _maintainrenditions;
	interfacesecuritygroupsoperationsprofile.viewAC = _maintainviews;
	interfacesecuritygroupsoperationsprofile.Array0 = tdObjectCollection;
	
	    
	
	PopUpManager.centerPopUp(interfacesecuritygroupsoperationsprofile);
	}
	if (dg.selectedItems.length == 1){  // Update 
	//	Alert.show(dg.selectedItem.group_code);
	//Alert.show(dg.selectedItem.maint_rend);
	
	
	
	interfacesecuritygroupsoperationsprofile = InterfaceOperatorGroupsSecurityProfile(
	PopUpManager.createPopUp(this, InterfaceOperatorGroupsSecurityProfile, true));
	interfacesecuritygroupsoperationsprofile.headtitle = "Maintain"
	interfacesecuritygroupsoperationsprofile.maintenance_code = "U"
	interfacesecuritygroupsoperationsprofile.user = myName_main;
	interfacesecuritygroupsoperationsprofile.group_code = dg.selectedItem.group_code;
	interfacesecuritygroupsoperationsprofile.group_description = dg.selectedItem.group_desc;
	interfacesecuritygroupsoperationsprofile.maintain_renditions = dg.selectedItem.mrend_desc;
	interfacesecuritygroupsoperationsprofile.maintain_views = dg.selectedItem.mview_desc;
	interfacesecuritygroupsoperationsprofile.upd_date = dg.selectedItem.upd_date;
	interfacesecuritygroupsoperationsprofile.upd_time = dg.selectedItem.upd_time;
	interfacesecuritygroupsoperationsprofile.unique_key = dg.selectedItem.upd_unique;
	interfacesecuritygroupsoperationsprofile.renditionAC = _maintainrenditions;
	interfacesecuritygroupsoperationsprofile.viewAC = _maintainviews;
	interfacesecuritygroupsoperationsprofile.Array0 = tdObjectCollection;
	PopUpManager.centerPopUp(interfacesecuritygroupsoperationsprofile);
	}
	
	interfacesecuritygroupsoperationsprofile["btn_add"].addEventListener(KeyboardEvent.KEY_DOWN, keypressaddOperatorGroups);  
	interfacesecuritygroupsoperationsprofile["btn_add"].addEventListener("click", addOperatorGroups); 
 
	interfacesecuritygroupsoperationsprofile["btn_update"].addEventListener("click", updateOperatorGroups);
	interfacesecuritygroupsoperationsprofile["btn_update"].addEventListener(KeyboardEvent.KEY_DOWN, keyupdateOperatorGroups);
	
	interfacesecuritygroupsoperationsprofile["btn_delete"].addEventListener("click", deleteOperatorGroups);
	interfacesecuritygroupsoperationsprofile["btn_delete"].addEventListener(KeyboardEvent.KEY_DOWN, keydeleteOperatorGroups);
	
	interfacesecuritygroupsoperationsprofile["btn_cancel"].addEventListener(KeyboardEvent.KEY_DOWN, keycancelOperatorGroups);
	
	
}



private function keypressaddOperatorGroups(event:KeyboardEvent):void{
	//Alert.show(event.keyCode.toString());
	if (event.keyCode == 27){
		PopUpManager.removePopUp(interfacesecuritygroupsoperationsprofile);
		
	}
	if (event.keyCode == 13){   
		addOperatorGroups(event);
	}
	if (event.keyCode == 39){
		interfacesecuritygroupsoperationsprofile.btn_cancel.setFocus();
		interfacesecuritygroupsoperationsprofile.btn_cancel.drawFocus(true);
		
	}
}   
private function keyupdateOperatorGroups(event:KeyboardEvent):void{
	
	if (event.keyCode == 27){
		PopUpManager.removePopUp(interfacesecuritygroupsoperationsprofile);
		
	}
	if (event.keyCode == 13){
		updateOperatorGroups(event);
	}
	if (event.keyCode == 39){
		interfacesecuritygroupsoperationsprofile.btn_delete.setFocus();
		interfacesecuritygroupsoperationsprofile.btn_delete.drawFocus(true);
		
	}
}   

private function keydeleteOperatorGroups(event:KeyboardEvent):void{

	if (event.keyCode == 27){  /* Escape key */
		PopUpManager.removePopUp(interfacesecuritygroupsoperationsprofile);
		
	}
	if (event.keyCode == 13){  /* Enter key */
		deleteOperatorGroups(event);
	}
	if (event.keyCode == 37){  /* left arrow */
		interfacesecuritygroupsoperationsprofile.btn_update.setFocus();
		interfacesecuritygroupsoperationsprofile.btn_update.drawFocus(true);
		
	}
	if (event.keyCode == 39){ /* right arrow */
		interfacesecuritygroupsoperationsprofile.btn_cancel.setFocus();
		interfacesecuritygroupsoperationsprofile.btn_cancel.drawFocus(true);
		
	}
} 
private function keycancelOperatorGroups(event:KeyboardEvent):void{

	if ((event.keyCode == 27)||(event.keyCode == 13)){
		interfacesecuritygroupsoperationsprofile.btn_cancel.setStyle("backgroundColor","green");
		PopUpManager.removePopUp(interfacesecuritygroupsoperationsprofile);
		
	}
	if (event.keyCode == 37){  /* left arrow */
		interfacesecuritygroupsoperationsprofile.btn_update.setFocus();
		interfacesecuritygroupsoperationsprofile.btn_update.drawFocus(true);
		
		
		if (interfacesecuritygroupsoperationsprofile.maintenance_code == "A"){
			interfacesecuritygroupsoperationsprofile.btn_add.setFocus();
			interfacesecuritygroupsoperationsprofile.btn_add.drawFocus(true);
		} else {
			interfacesecuritygroupsoperationsprofile.btn_delete.setFocus();
			interfacesecuritygroupsoperationsprofile.btn_delete.drawFocus(true);
			
		}
		
		
	}
	
} 



private var _operatorgroup:ArrayCollection = new ArrayCollection; 
private var _operator:ArrayCollection = new ArrayCollection;


private function retrieveOperatorHandler(event:ResultEvent):void{
	if ( event.result.ezware_response.status != 'OK' ) {
		var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
		AlertMessageShow(s_ret);
		return;
	}	
	_operator = new ArrayCollection();

	if (event.result.ezware_response.refresh_data.operator == null)
	{
		AlertMessageShow("No Operator");
		return;
	}
	if (event.result.ezware_response.refresh_data.operator.data == null)
	{
		_operator=new ArrayCollection()
	}
	else if (event.result.ezware_response.refresh_data.operator.data is ArrayCollection)
	{
		_operator=event.result.ezware_response.refresh_data.operator.data;
	}
	else if (event.result.ezware_response.refresh_data.operator.data is ObjectProxy)
	{
		_operator = new ArrayCollection(ArrayUtil.toArray(event.result.ezware_response.refresh_data.operator.data));   
	}
	
	//OperatorPopUp(event);
	
	if (_operator.length < 1){
		AlertMessageShow("No Operator");
	}
	retrieve_groupforoperators.send();
}


private function retrieveOperatorGroupHandler(event:ResultEvent):void{
	if ( event.result.ezware_response.status != 'OK' ) {
		var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
		AlertMessageShow(s_ret);
		return;
	}	
	_operatorgroup = new ArrayCollection();
	if (event.result.ezware_response.refresh_data.operatorgroups == null)
	{
		AlertMessageShow("No Operator Group");
		return;
	}
	if (event.result.ezware_response.refresh_data.operatorgroups.data == null)
	{
		_operatorgroup=new ArrayCollection()
	}
	else if (event.result.ezware_response.refresh_data.operatorgroups.data is ArrayCollection)
	{
		_operatorgroup=event.result.ezware_response.refresh_data.operatorgroups.data;
	}
	else if (event.result.ezware_response.refresh_data.operatorgroups.data is ObjectProxy)
	{
		_operatorgroup = new ArrayCollection(ArrayUtil.toArray(event.result.ezware_response.refresh_data.operatorgroups.data));   
	}
	
	if (_operatorgroup.length < 1){
		AlertMessageShow("No Operator Group");
		return;
	}
	OperatorPopUp(event);
}


private function OperatorPopUp(event:Event):void{
	
	
	if (dg.selectedItems.length == 0){  // Add 
		
		interfacesecurityoperationsprofile = InterfaceOperatorSecurityProfile(
			PopUpManager.createPopUp(this, InterfaceOperatorSecurityProfile, true));
		interfacesecurityoperationsprofile.headtitle = "Add";
		interfacesecurityoperationsprofile.maintenance_code = "A";
		interfacesecurityoperationsprofile.user = myName_main;
		interfacesecurityoperationsprofile.operatorgroupAC = _operatorgroup;
		interfacesecurityoperationsprofile.initials = "";
		interfacesecurityoperationsprofile.operatorname = "";
		interfacesecurityoperationsprofile.operatorgroup = "";
		interfacesecurityoperationsprofile.upd_date = "";
		interfacesecurityoperationsprofile.upd_time = "";
		interfacesecurityoperationsprofile.Array0 = tdObjectCollection;
		
		//interfacesecuritygroupsoperationsprofile.group_description = "";
		//interfacesecuritygroupsoperationsprofile.maintain_renditions = "N";
		//interfacesecuritygroupsoperationsprofile.maintain_views = "N";
		//interfacesecuritygroupsoperationsprofile.upd_date = "";
		//interfacesecuritygroupsoperationsprofile.upd_time = "";
		//interfacesecuritygroupsoperationsprofile.unique_key = "";
		//interfacesecuritygroupsoperationsprofile.renditionAC = _maintainrenditions;
		//interfacesecuritygroupsoperationsprofile.viewAC = _maintainviews;
		//interfacesecuritygroupsoperationsprofile.Array0 = tdObjectCollection
		
		
		
		PopUpManager.centerPopUp(interfacesecurityoperationsprofile);
	}
	
	if (dg.selectedItems.length == 1){  // Update 
		//	Alert.show(dg.selectedItem.group_code);
		//Alert.show(dg.selectedItem.maint_rend);
		
		interfacesecurityoperationsprofile = InterfaceOperatorSecurityProfile(
			PopUpManager.createPopUp(this, InterfaceOperatorSecurityProfile, true));
		interfacesecurityoperationsprofile.headtitle = "Maintain";
		interfacesecurityoperationsprofile.maintenance_code = "U";
		interfacesecurityoperationsprofile.user = myName_main;
		interfacesecurityoperationsprofile.operatorgroupAC = _operatorgroup;
		
		interfacesecurityoperationsprofile.operatorcode = dg.selectedItem.operator_code;
		interfacesecurityoperationsprofile.initials = dg.selectedItem.operator_init;
		interfacesecurityoperationsprofile.operatorname = dg.selectedItem.operator_name;
		interfacesecurityoperationsprofile.operatorgroup = dg.selectedItem.group;
		interfacesecurityoperationsprofile.upd_date = dg.selectedItem.upd_date;
		interfacesecurityoperationsprofile.upd_time = dg.selectedItem.upd_time;
		interfacesecurityoperationsprofile.Array0 = tdObjectCollection;
		interfacesecurityoperationsprofile.ArrayPassphrases = _operator;
		
		
		
		
		/*
		interfacesecuritygroupsoperationsprofile = InterfaceOperatorGroupsSecurityProfile(
			PopUpManager.createPopUp(this, InterfaceOperatorGroupsSecurityProfile, true));
		interfacesecuritygroupsoperationsprofile.headtitle = "Maintain"
		interfacesecuritygroupsoperationsprofile.maintenance_code = "U"
		interfacesecuritygroupsoperationsprofile.user = myName_main;
		interfacesecuritygroupsoperationsprofile.group_code = dg.selectedItem.group_code;
		interfacesecuritygroupsoperationsprofile.group_description = dg.selectedItem.group_desc;
		interfacesecuritygroupsoperationsprofile.maintain_renditions = dg.selectedItem.mrend_desc;
		interfacesecuritygroupsoperationsprofile.maintain_views = dg.selectedItem.mview_desc;
		interfacesecuritygroupsoperationsprofile.upd_date = dg.selectedItem.upd_date;
		interfacesecuritygroupsoperationsprofile.upd_time = dg.selectedItem.upd_time;
		interfacesecuritygroupsoperationsprofile.unique_key = dg.selectedItem.upd_unique;
		interfacesecuritygroupsoperationsprofile.renditionAC = _maintainrenditions;
		interfacesecuritygroupsoperationsprofile.viewAC = _maintainviews;
		interfacesecuritygroupsoperationsprofile.Array0 = tdObjectCollection
		PopUpManager.centerPopUp(interfacesecuritygroupsoperationsprofile);
		
		*/
		PopUpManager.centerPopUp(interfacesecurityoperationsprofile);
	}
	
	
	
	interfacesecurityoperationsprofile["btn_unlock"].addEventListener("click", unlockOperator);
	interfacesecurityoperationsprofile["btn_unlock"].addEventListener(KeyboardEvent.KEY_DOWN, keypressunlockOperator);	
	
	interfacesecurityoperationsprofile["btn_add"].addEventListener(KeyboardEvent.KEY_DOWN, keypressaddOperator);  
	interfacesecurityoperationsprofile["btn_add"].addEventListener("click", addOperator);
	
	interfacesecurityoperationsprofile["btn_update"].addEventListener("click", updateOperator);
	interfacesecurityoperationsprofile["btn_update"].addEventListener(KeyboardEvent.KEY_DOWN, keyupdateOperator);
	 
	
	interfacesecurityoperationsprofile["btn_delete"].addEventListener("click", deleteOperator);            
	interfacesecurityoperationsprofile["btn_delete"].addEventListener(KeyboardEvent.KEY_DOWN, keydeleteOperator);
	
	
	interfacesecurityoperationsprofile["btn_cancel"].addEventListener(KeyboardEvent.KEY_DOWN, keycancelOperator);
	
	/*
	interfacesecuritygroupsoperationsprofile["btn_add"].addEventListener(KeyboardEvent.KEY_DOWN, keypressaddOperatorGroups);  
	interfacesecuritygroupsoperationsprofile["btn_add"].addEventListener("click", addOperatorGroups); 
	
	interfacesecuritygroupsoperationsprofile["btn_update"].addEventListener("click", updateOperatorGroups);
	interfacesecuritygroupsoperationsprofile["btn_update"].addEventListener(KeyboardEvent.KEY_DOWN, keyupdateOperatorGroups);
	
	interfacesecuritygroupsoperationsprofile["btn_delete"].addEventListener("click", deleteOperatorGroups);
	interfacesecuritygroupsoperationsprofile["btn_delete"].addEventListener(KeyboardEvent.KEY_DOWN, keydeleteOperatorGroups);
	
	interfacesecuritygroupsoperationsprofile["btn_cancel"].addEventListener(KeyboardEvent.KEY_DOWN, keycancelOperatorGroups);
	*/
	
}



private function keypressunlockOperator(event:KeyboardEvent):void{
	
	if (event.keyCode == 27){
		PopUpManager.removePopUp(interfacesecurityoperationsprofile);
		
	}
	if (event.keyCode == 13){   
		unlockOperator(event);
	}
	if (event.keyCode == 39){
		interfacesecurityoperationsprofile.btn_cancel.setFocus();
		interfacesecurityoperationsprofile.btn_cancel.drawFocus(true);
		
	}
}   
private function unlockOperator(event:Event):void {
	var loc_operatorcode:String = interfacesecurityoperationsprofile.ti_operatorprefix.text + interfacesecurityoperationsprofile.ti_operatorsuffix.text;	
	
	reqParms = "REFRESH,UNLOCK|OPERATOR|" +  loc_operatorcode + "|";
	
	
	unlock_operator.send();
}
	


private function keypressaddOperator(event:KeyboardEvent):void{
	
	if (event.keyCode == 27){
		PopUpManager.removePopUp(interfacesecurityoperationsprofile);
		
	}
	if (event.keyCode == 13){   
		addOperator(event);
	}
	if (event.keyCode == 39){
		interfacesecurityoperationsprofile.btn_cancel.setFocus();
		interfacesecurityoperationsprofile.btn_cancel.drawFocus(true);
		
	}
}   

private function addOperator(event:Event):void {
	
	/* validate first */
	if (interfacesecurityoperationsprofile.ti_operatorsuffix.text.length < 2){
		AlertMessageShow("Please Enter the 2 character Operator Code");
		return;
	}     
	
	if (interfacesecurityoperationsprofile.ti_operatorname.text.length < 1){
		AlertMessageShow("Please Enter Operator Name");
		return;
	}
	if (interfacesecurityoperationsprofile.ti_initials.text.length < 1){
		AlertMessageShow("Please Enter Initials");
		return;
	}
	if (interfacesecurityoperationsprofile.ti_groupcode.text.length < 1){
		AlertMessageShow("Please Enter Group Code");
		return;
	}
	
	if (interfacesecurityoperationsprofile.ti_passphrase1.text.length > 1){
		if (interfacesecurityoperationsprofile.ti_passphrase1.text != interfacesecurityoperationsprofile.ti_passphrase2.text){
			AlertMessageShow("Passphrase does not match.  Please re-enter Passphrase");
			return;
		}
		
	}
	
	var loc_operatorcode:String = interfacesecurityoperationsprofile.ti_operatorprefix.text + interfacesecurityoperationsprofile.ti_operatorsuffix.text;	
	
	for (var i:int=0;i<tdObjectCollection.length;i++)  { 
		if (loc_operatorcode.toUpperCase() == tdObjectCollection[i]['operator_code'].toUpperCase()){
			AlertMessageShow("Operator Code Already Exist")
			return;
			break;
		}	
	}
	
	
	if (interfacesecurityoperationsprofile.ti_passphrase1.text.length < 1){
		AlertMessageShow("Please Enter Passphrase");
		return;
	}
	
	if (interfacesecurityoperationsprofile.ti_passphrase1.text != interfacesecurityoperationsprofile.ti_passphrase2.text){
		AlertMessageShow("Passphrase does not match.  Please Re-enter Passphrase");
		return;
	}
	
	
	/* Everything's good - Time to create the request Baby! */
	/*
	reqParms = "REFRESH,UPDATE|OPERATOR|" +  loc_operatorcode + "|" + 
		interfacesecurityoperationsprofile.ti_groupcode.text +
		"|" + 
		interfacesecurityoperationsprofile.ti_initials.text + 
		"|" +
		interfacesecurityoperationsprofile.ti_operatorname.text + 
		"|";
	*/
	
	var mcp_flag:String = 'N';
	if (interfacesecurityoperationsprofile.mcp_yes.selected == true){
		mcp_flag = 'Y';
	}
	

	reqParms = "REFRESH,UPDATE|OPERATOR|" +  loc_operatorcode + "|" + 
		interfacesecurityoperationsprofile.ti_groupcode.text +
		"|" + 
		interfacesecurityoperationsprofile.ti_initials.text + 
		"|" +
		interfacesecurityoperationsprofile.ti_operatorname.text + 
		"|" +
		interfacesecurityoperationsprofile.ti_minimumpasswordageindays.text + 
		"|" +
		interfacesecurityoperationsprofile.ti_maximumpasswordageindays.text + 
		"|" +
		interfacesecurityoperationsprofile.ti_maximumexpiredpasswordageindays.text + 
		"|" +
		interfacesecurityoperationsprofile.ti_passwordwarningperiodindays.text + 
		"|" +
		mcp_flag + 
		"|" +
		interfacesecurityoperationsprofile.ti_passphrase1.text +
		"|" +
		interfacesecurityoperationsprofile.ti_passphrase2.text + 
		"|";
		
	
	add_maintain_operator.send();
	
}

private function keyupdateOperator(event:KeyboardEvent):void{
	
	if (event.keyCode == 27){
		PopUpManager.removePopUp(interfacesecurityoperationsprofile);
		
	}
	if (event.keyCode == 13){
		updateOperator(event);
	}
	if (event.keyCode == 39){
		interfacesecurityoperationsprofile.btn_delete.setFocus();
		interfacesecurityoperationsprofile.btn_delete.drawFocus(true);
		
	}
}   
private function updateOperator(event:Event):void {
	
	//Alert.show( interfacesecuritygroupsoperationsprofile.cb_maintainrenditions.selectedItem.data);    
	/* validate first */
	if (interfacesecurityoperationsprofile.ti_operatorname.text.length < 1){
		AlertMessageShow("Please Enter Operator Name");
		return;
	}
	if (interfacesecurityoperationsprofile.ti_initials.text.length < 1){
		AlertMessageShow("Please Enter Initials");
		return;
	}
	if (interfacesecurityoperationsprofile.ti_groupcode.text.length < 1){
		AlertMessageShow("Please Enter Group Code");
		return;
	}
	
	if (interfacesecurityoperationsprofile.ti_groupcode.text.length < 1){
		AlertMessageShow("Please Enter Group Code");
		return;
	}
	
	if (interfacesecurityoperationsprofile.ti_passphrase1.text.length > 1){
		if (interfacesecurityoperationsprofile.ti_passphrase1.text != interfacesecurityoperationsprofile.ti_passphrase2.text){
			AlertMessageShow("Passphrase does not match.  Please Re-enter Passphrase");
			return;
		}
	}
	
	
	var loc_operatorcode:String = interfacesecurityoperationsprofile.ti_operatorprefix.text + interfacesecurityoperationsprofile.ti_operatorsuffix.text;	
	
		/* Everything's good - Time to create the request Baby! */
	/* Everything's good - Time to create the request Baby! */
	
	var mcp_flag:String = 'N';
	if (interfacesecurityoperationsprofile.mcp_yes.selected == true){
		mcp_flag = 'Y';
	}
	
	
	reqParms = "REFRESH,UPDATE|OPERATOR|" +  loc_operatorcode + "|" + 
		interfacesecurityoperationsprofile.ti_groupcode.text +
		"|" + 
		interfacesecurityoperationsprofile.ti_initials.text + 
		"|" +
		interfacesecurityoperationsprofile.ti_operatorname.text + 
		"|" +
		interfacesecurityoperationsprofile.ti_minimumpasswordageindays.text + 
		"|" +
		interfacesecurityoperationsprofile.ti_maximumpasswordageindays.text + 
		"|" +
		interfacesecurityoperationsprofile.ti_maximumexpiredpasswordageindays.text + 
		"|" +
		interfacesecurityoperationsprofile.ti_passwordwarningperiodindays.text + 
		"|" +
		mcp_flag + 
		"|" +
		interfacesecurityoperationsprofile.ti_passphrase1.text +
		"|" +
		interfacesecurityoperationsprofile.ti_passphrase2.text + 
		"|";
	
	add_maintain_operator.send();
}


private function keydeleteOperator(event:KeyboardEvent):void{
	
	if (event.keyCode == 27){  /* Escape key */
		PopUpManager.removePopUp(interfacesecurityoperationsprofile);
		
	}
	if (event.keyCode == 13){  /* Enter key */
		deleteOperator(event);
	}
	if (event.keyCode == 37){  /* left arrow */
		interfacesecurityoperationsprofile.btn_update.setFocus();
		interfacesecurityoperationsprofile.btn_update.drawFocus(true);
		
	}
	if (event.keyCode == 39){ /* right arrow */
		interfacesecurityoperationsprofile.btn_cancel.setFocus();
		interfacesecurityoperationsprofile.btn_cancel.drawFocus(true);
		
	}
} 

private function deleteOperator(event:Event):void {
	
	reqParms = "REFRESH,DELETE|OPERATOR|" + 
		interfacesecurityoperationsprofile.ti_operatorprefix.text + 
		interfacesecurityoperationsprofile.ti_operatorsuffix.text + "|";
	delete_maintain_operator.send();
}

private function keycancelOperator(event:KeyboardEvent):void{
	
	if ((event.keyCode == 27)||(event.keyCode == 13)){
		PopUpManager.removePopUp(interfacesecurityoperationsprofile);
		
	}    
	if (event.keyCode == 37){  /* left arrow */
		interfacesecurityoperationsprofile.btn_update.setFocus();
		interfacesecurityoperationsprofile.btn_update.drawFocus(true);
		
		
		if (interfacesecurityoperationsprofile.maintenance_code == "A"){
			interfacesecurityoperationsprofile.btn_add.setFocus();
			interfacesecurityoperationsprofile.btn_add.drawFocus(true);
		} else {
			interfacesecurityoperationsprofile.btn_delete.setFocus();
			interfacesecurityoperationsprofile.btn_delete.drawFocus(true);
			
		}
		
		
	}
	
} 
