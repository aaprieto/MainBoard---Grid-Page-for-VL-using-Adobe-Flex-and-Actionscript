// ActionScript file
import flash.events.Event;
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.containers.HBox;
import mx.containers.VBox;
import mx.containers.VDividedBox;

import spark.components.ToggleButton;

public function retrieveDashboards(event:Event, mb_datagrid:ArrayCollection):void{
	
	var space:Spacer = new Spacer();
	space.width = 20;
	
	///////////////////////////////////////////////////////////
	/*
	for (var i:int=0;i<mb_datagrid.length;i++)  {
	
	var newObject:ToggleButton = new ToggleButton();
	
	//				newObject.custom_code = mb_datagrid[i]["mbdcode"];
	//newObject.label = mb_datagrid[i]["mbddescription"];
	newObject.label = mb_datagrid[i]["btnlabel"];
	//				newObject.doc_id = mb_datagrid[i]["docid"];
	//				newObject.custom_id = mb_datagrid[i]["id"]; 
	
	//newObject.setStyle('color','#FFFFFF');
	newObject.setStyle('fontWeight','bold');
	newObject.setStyle('fontSize',20);
	//newObject.addEventListener( MouseEvent.CLICK,ShowDatagrid);
	newObject.addEventListener( MouseEvent.CLICK,ActionButtonsEvent);
	newObject.addEventListener( MouseEvent.ROLL_OVER,datagridListROver);
	newObject.addEventListener( MouseEvent.ROLL_OUT,datagridListROut);
	
	addObjectToArray(newObject); 
	
	//hb_mbdatagrid.addChild(newObject);
	hb_mbdatagrid_actiongrid.addChild(newObject);
	
	}
	*/
	////////////////////////////////////////////////////////////
	
	for (var i:int=0;i<mb_datagrid.length;i++)  {
		
		var newObject:CustomButton = new CustomButton();
		newObject.custom_code = mb_datagrid[i]["mbdcode"];
		//newObject.label = mb_datagrid[i]["mbddescription"];
		newObject.label = mb_datagrid[i]["btnlabel"];
		newObject.doc_id = mb_datagrid[i]["docid"];
		newObject.custom_id = mb_datagrid[i]["id"]; 
		newObject1.ag_application_entry =application_entry;
		//newObject.setStyle('color','#FFFFFF');
		newObject.setStyle('fontWeight','bold');
		newObject.setStyle('fontSize',20);
		newObject.setStyle('i',"image/downbuttoncolor.PNG");
		//newObject.setStyle('icon',"image/button_check.png");
		
		//newObject.addEventListener( MouseEvent.CLICK,ShowDatagrid);
		newObject.addEventListener( MouseEvent.CLICK,ActionButtonsEvent);
		newObject.addEventListener( MouseEvent.ROLL_OVER,datagridListROver);
		newObject.addEventListener( MouseEvent.ROLL_OUT,datagridListROut);
		
		addObjectToArray(newObject); 
		
		//hb_mbdatagrid.addChild(newObject);
		hb_mbdatagrid_actiongrid.addChild(newObject);
		
	}
	
	
	
	//hb_mbdatagrid.addChild(space);
	
	
	hb_mbdatagrid_actiongrid.addChild(space);
	
	
	var div:int = 0
	for( i = 0; i < aCheckBox.length; i++){
		div = aCheckBox.length;
	}       
	
	ArrayShow = new ArrayCollection();
	
	vdivbox.removeAllChildren();
	if(vdivbox) if( vdivbox.parent ) vdivbox.parent.removeChild( vdivbox );
	vdivbox.height = mainvbox.height - 90;
	vdivbox.width = mainvbox.width - 15;
	vdivboxheight = vdivbox.height  - 25; 	
	
	//vdivbox.height = mainvbox.height - 200;
	//vdivbox.width = mainvbox.width;
	//vdivboxheight = vdivbox.height - 75; 	
	
	for(var ia:int = 0; ia < aCheckBox.length; ia++){
		var c_id:String = aCheckBox[ia]['custom_code'];
		//Alert.show(c_id);
		//var newObject1:datagrid_test = new datagrid_test();
		newObject1 = new datagrid_test();
		newObject1.mainBoard = c_id;
		newObject1.myName_main = myName;
		newObject1.height = (vdivboxheight / div);
		
		newObject1.id = c_id;
		newObject1.my_c_code1 = my_c_code;
		newObject1.my_sid = session_id;
		newObject1.ag_application_entry =application_entry; 
		newObject1.hover_help_actiongrid_domain = hoverhelp_domain;
		
		ArrayShow.addItem(newObject1);
		
		vdivbox.addChild(newObject1);
		
		
	}
	vdivbox.visible = false;
	//	Alert.show(ArrayShow.length.toString());
	
	// Initialize ArrayRetain 
	for( var ir:int = 0; ir < aCheckBox.length; ir++ ){
		ArrayRetain.addItem(null);
		ArrayScroll.addItem(null);
		ArrayRetainKey.addItem(null);
		ArrayRetainKeyValue.addItem(null);
		//ArrayRetainCombo.addItem("-1");
		//ArrayRetainComboPersistent.addItem("-1");
		//ArrayRetainComboGroup.addItem("-1");
	}
	
	// Call first Actiongrid
	/*
	aCheckBox[0]["selected"] = true;
	aCheckBox[0].setStyle("color","blue"); 
	aCheckBox[0].setStyle("borderColor", "blue");
	ShowDatagrid(event);
	*/
	         
	//Alert.show(actiongrid_code.toString());
	
	aCheckBox[actiongrid_code]["selected"] = true;
	aCheckBox[actiongrid_code].setStyle("color","blue"); 
	aCheckBox[actiongrid_code].setStyle("borderColor", "blue");
	aCheckBox[actiongrid_code].setStyle("backgroundImage", "image/downbuttoncolor.PNG");
	aCheckBox[actiongrid_code].styleDeclaration.setStyle("icon",check);
	
	DashboardShowDatagrid(event);   
	
}




public function DashboardShowDatagrid(event :Event):void{ 
	//Alert.show("go here");
	vdivbox.visible = false;
	vdivbox.removeAllChildren();		    
	
	var arrayselected:int;
	var arrayid:String;
	var arr_bwiset:ArrayCollection = new ArrayCollection;
	var str_segment_array:Array = [];
	var str_len:int;    
	var str_cbcurrentview:int = new int;
	//	Alert.show("2nd pass" + ArrayShow.length);
	
	for( var ir:int = 0; ir < aCheckBox.length ; ir++ )
	{
		//		Alert.show("mainBoard: " + 	ArrayShow[ir]['mainBoard'])
		//		Alert.show("Number: " + ir.toString());
		var newObject2:Object = new Object(); 
		var newObject3:Object = new Object();
		var newObject4:Object = new Object();
		//Alert.show("1");    
		//	Alert.show("Checkpoint 20");
		//	Alert.show(ArrayShow[ir].dg.selectedIndices.toString());  
		newObject2 = (ArrayShow[ir].dg.selectedIndices).toString();
		//Alert.show("2");
		//Alert.show("Checkpoint 21");    
		ArrayRetain.removeItemAt(ir); 
		ArrayRetain.addItemAt(newObject2,ir);
		ArrayScroll.removeItemAt(ir);
		ArrayScroll.addItemAt(ArrayShow[ir].dg.horizontalScrollPosition,ir);
		arrayselected = ArrayShow[ir].dg.selectedItems.length;
		var obj:Object = new Object();   
		arr_bwiset = new ArrayCollection();
		//Alert.show("checkpoint 1");
		if  ((ArrayShow[ir].Array1.length == arrayselected)&&(ArrayShow[ir].Array1.sort != null)){
			for( var iarr:int = 0; iarr < arrayselected; iarr++ ){
				obj = iarr;
				arr_bwiset.addItem(obj); 
			}
		} else {
			for( var iarr:int = 0; iarr < arrayselected; iarr++ ){
				obj = ArrayShow[ir].dg.selectedIndices[iarr];
				arr_bwiset.addItem(obj); 
			}
			
		}
	//	Alert.show("Checkpoint 30");
		var list:ArrayCollection = SortArray(arr_bwiset);
		newObject3 = list.toString();
		/* index has been sorted to Array  */
		ArrayRetainKey.removeItemAt(ir);		 
		ArrayRetainKey.addItemAt(newObject3,ir);
		c_utils.trim(ArrayRetainKey[ir]);
		//	ArrayRetainCombo.removeItemAt(ir);
		//	ArrayRetainComboPersistent.removeItemAt(ir);
		//ArrayRetainComboGroup.removeItemAt(ir);
		//	ArrayRetainCombo.addItemAt(ArrayShow[ir].cb_filter_macro.selectedIndex,ir);		
		//ArrayRetainComboPersistent.addItemAt(ArrayShow[ir].cb_filter_macro_persistent.selectedIndex,ir);
		//ArrayRetainComboGroup.addItemAt(ArrayShow[ir].cb_column_group.selectedIndex,ir);		
		//		Alert.show("Checkpoint 40");
		var dec_rk:String = ArrayRetainKey[ir].toString();	
		if (dec_rk.length > 0){
			str_segment_array = new Array;
			str_segment_array = ArrayRetainKey[ir].split(",");	 
			str_len = str_segment_array.length;
			var str_arrdata:String = new String;
			for( var iarrs:int = 0; iarrs < str_len; iarrs++ ){
				var i_ssar:int = str_segment_array[iarrs];
				str_arrdata = str_arrdata + ',' + ArrayShow[ir].Array1[ i_ssar ][ArrayShow[ir]._xlcColumn[0]["dataField"]];
			}
			newObject4 = str_arrdata.toString();
			
		}  
		ArrayRetainKeyValue.removeItemAt(ir);	
		ArrayRetainKeyValue.addItemAt(newObject4,ir);
	}
	var div:int = 0; 	
	//	  	vdivbox.removeAllChildren();
	if(vdivbox) if( vdivbox.parent ) vdivbox.parent.removeChild( vdivbox );
	vdivbox = new VDividedBox();
	vdivbox.height = mainvbox.height - 110;
	//	vdivbox.height = mainvbox.height;
	vdivbox.width = mainvbox.width - 15;
	//var vdivboxheight:int = vdivbox.height  - 25; 		
	var vdivboxheight:int = vdivbox.height  - 46;
	//		var vdivboxheight:int = vdivbox.height;
	//vdivboxheight = vdivboxheight - 1
	mainvbox.addChild(vdivbox);   
	//Alert.show(global_dd.toString());
	for(var i:int = 0; i < aCheckBox.length; i++){ 
		if (aCheckBox[i]['dd'] == 'N'){
			if (aCheckBox[i]['selected'] == true){
				div = div + 1;
			}
		}	
	}      
	

	if (global_dd == true){    
		//	Alert.show("I was born this way:" + aCheckBox[aCheckBox.length-1]['selected'].toString());
		if (aCheckBox[aCheckBox.length-1]['selected'] == true){
			//global_dd = false;  
			
			ArrayShow[aCheckBox.length-1].height = (vdivboxheight / 1); 
			vdivbox.addChild(ArrayShow[aCheckBox.length-1]);  
			//Alert.show("2");
		} else {
			
			for(var ia:int = 0; ia < aCheckBox.length; ia++){
				if (aCheckBox[ia]['selected'] == true){
					//						Alert.show("Checkpoint 50");
					ArrayShow[ia].height = (vdivboxheight / div); 
					vdivbox.addChild(ArrayShow[ia]);   
					//Alert.show(ia.toString());
				}	   
			}  
		}
	}
	
	
	//	 	vdivbox.visible = true;
	// Alisin muna natin ito	 	 vdivbox.addEventListener(MouseEvent.CLICK,setFocusmain);
	//var str_segment_arrayretain:Array = [];
	str_segment_arrayretain = [];
	// Alert.show("global_dd: " + global_dd.toString()); 
	if (global_dd == false){	 
		for(var ib:int = 0; ib < aCheckBox.length; ib++){         
			if (aCheckBox[ib]['selected'] == true){
				str_segment_arrayretain = ArrayRetain[ib].split(",");
				if (ArrayRetain[ib].toString() != ""){
					ArrayShow[ib].dg.selectedIndices = str_segment_arrayretain;
				}
				ArrayShow[ib].dg.horizontalScrollPosition = ArrayScroll[ib];
				//ArrayShow[ib].cb_filter_macro.selectedIndex = ArrayRetainCombo[ib];
				//ArrayShow[ib].cb_filter_macro_persistent.selectedIndex = ArrayRetainComboPersistent[ib];
				//ArrayShow[ib].cb_column_group.selectedIndex = ArrayRetainComboGroup[ib];
				ArrayShow[ib].dg_hsb = ArrayScroll[ib];
				
				//Alert.show(aCheckBox[ib]['selected']);
				//Alert.show("go here first: " + ArrayShow[ib]._xlcHistory);
				//ArrayShow[ib].launchHistoryRetrievalMultipleParameters(event)
				if (ArrayShow[ib]._xlcHistory != 'Yes'){ 
					//Alert.show("rain rain go away");
					//ArrayShow[ib].dataList2_trigger(event, false);
					
					if (application_entry == 'ml'){ 
						ArrayShow[ib].dataList_2.url = 'ae_tlch_ml_req.php';
						ArrayShow[ib].dataList.url = 'ae_tlch_ml_req.php';
						
						//Alert.show(ArrayShow[ib].dataList_2.url = 'ae_tlch_ml_req.php');
					}
					
					if (ArrayShow[ib]._xlcRefreshAll == 'Y'){
						
						ArrayShow[ib].dataList.send();
					}
					else{
						
						
						ArrayShow[ib].dataList_2.send();
					}
					// Save selected index first before refreshing.  
					//ArrayShow[ib].saveselecteditemsfromMainboard();  
				} else {
					ArrayShow[ib].launchHistoryRetrievalMultipleParameters(event, ArrayShow[ib]._xlcDynamicIndicator)
				}
				//Alert.show(ArrayShow[ib]._xlcHistory); 
				/*
				if (ArrayShow[ib]._xlcHistory == 'Yes'){ 
				ArrayShow[ib].launchHistoryRetrievalMultipleParameters(event); 
				}
				*/
			} 
		}       
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	if (global_dd == true){	 
		
		//for(var ib:int = 0; ib < aCheckBox.length; ib++){
		//Alert.show(ArrayShow.length.toString());
		//		for(var ib:int = ArrayShow.length - 1; ib >= 0; ib--){       
		//	Alert.show("its got to be starting something: " + ib.toString() );
		//	if (aCheckBox[ib]['selected'] == true){
		//aCheckBox[ib]['custom_code']
		str_segment_arrayretain = ArrayRetain[ib].split(",");
		if (ArrayRetain[ArrayShow.length -1].toString() != ""){
			ArrayShow[ArrayShow.length -1].dg.selectedIndices = str_segment_arrayretain;
		}
		
		//	Remove this for now.. filter header does not follow			ArrayShow[ArrayShow.length -1].dg.horizontalScrollPosition = ArrayScroll[ib];
		//ArrayShow[ib].cb_filter_macro.selectedIndex = ArrayRetainCombo[ib];
		//ArrayShow[ib].cb_filter_macro_persistent.selectedIndex = ArrayRetainComboPersistent[ib];
		//ArrayShow[ib].cb_column_group.selectedIndex = ArrayRetainComboGroup[ib];
		//	Remove this for now.. filter header does not follow				ArrayShow[ArrayShow.length -1].dg_hsb = ArrayScroll[ib];           
		
		//Alert.show(aCheckBox[ib]['selected']);
		//Alert.show("go here first: " + ArrayShow[ib]._xlcHistory);
		//ArrayShow[ib].launchHistoryRetrievalMultipleParameters(event)
		/*  Not sure if this matter, Tim/Walter wants to see the last Actiongrid the same way as it was last clicked.  
		No refresh needed.
		if (ArrayShow[ArrayShow.length -1]._xlcHistory != 'Yes'){ 
		ArrayShow[ArrayShow.length -1].dataList_2.send(); 
		}
		*/				
		
		//Alert.show(ArrayShow[ib]._xlcHistory); 
		/*
		if (ArrayShow[ib]._xlcHistory == 'Yes'){ 
		ArrayShow[ib].launchHistoryRetrievalMultipleParameters(event); 
		}
		*/    
		//	break;
		//	} 
		//}
	}	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Alert.show("Refreshing for 2nd time");
	//Alert.show("show : " + ArrayShow[0]._xlcColumn.length.toString());
	if (global_dd == true){
		global_dd = false;
	}
	//vdivbox.visible = true;    
	//mainvbox.addChild(vdivbox);
}



public function retrieveDashboards_temp(event:Event, mb_datagrid:ArrayCollection):void{
	
	var space:Spacer = new Spacer();
	space.width = 20;
	
	///////////////////////////////////////////////////////////
	/*
	for (var i:int=0;i<mb_datagrid.length;i++)  {
	
	var newObject:ToggleButton = new ToggleButton();
	
	//				newObject.custom_code = mb_datagrid[i]["mbdcode"];
	//newObject.label = mb_datagrid[i]["mbddescription"];
	newObject.label = mb_datagrid[i]["btnlabel"];
	//				newObject.doc_id = mb_datagrid[i]["docid"];
	//				newObject.custom_id = mb_datagrid[i]["id"]; 
	
	//newObject.setStyle('color','#FFFFFF');
	newObject.setStyle('fontWeight','bold');
	newObject.setStyle('fontSize',20);
	//newObject.addEventListener( MouseEvent.CLICK,ShowDatagrid);
	newObject.addEventListener( MouseEvent.CLICK,ActionButtonsEvent);
	newObject.addEventListener( MouseEvent.ROLL_OVER,datagridListROver);
	newObject.addEventListener( MouseEvent.ROLL_OUT,datagridListROut);
	
	addObjectToArray(newObject); 
	
	//hb_mbdatagrid.addChild(newObject);
	hb_mbdatagrid_actiongrid.addChild(newObject);
	
	}
	*/
	////////////////////////////////////////////////////////////
	
	for (var i:int=0;i<mb_datagrid.length;i++)  {
		
		var newObject:CustomButton = new CustomButton();
		newObject.custom_code = mb_datagrid[i]["mbdcode"];
		//newObject.label = mb_datagrid[i]["mbddescription"];
		newObject.label = mb_datagrid[i]["btnlabel"];
		newObject.doc_id = mb_datagrid[i]["docid"];
		newObject.custom_id = mb_datagrid[i]["id"]; 
		newObject1.ag_application_entry =application_entry;
		//newObject.setStyle('color','#FFFFFF');
		newObject.setStyle('fontWeight','bold');
		newObject.setStyle('fontSize',20);
		newObject.setStyle('i',"image/downbuttoncolor.PNG");
		//newObject.setStyle('icon',"image/button_check.png");
		
		//newObject.addEventListener( MouseEvent.CLICK,ShowDatagrid);
		newObject.addEventListener( MouseEvent.CLICK,ActionButtonsEvent);
		newObject.addEventListener( MouseEvent.ROLL_OVER,datagridListROver);
		newObject.addEventListener( MouseEvent.ROLL_OUT,datagridListROut);
		
		addObjectToArray(newObject); 
		
		//hb_mbdatagrid.addChild(newObject);
		hb_mbdatagrid_actiongrid.addChild(newObject);
		
	}
	
	
	
	//hb_mbdatagrid.addChild(space);
	
	
	hb_mbdatagrid_actiongrid.addChild(space);
	
	
	var div:int = 0
	for( i = 0; i < aCheckBox.length; i++){
		div = aCheckBox.length;
	}       
	
	ArrayShow = new ArrayCollection();
	
	vdivbox.removeAllChildren();
	if(vdivbox) if( vdivbox.parent ) vdivbox.parent.removeChild( vdivbox );
	vdivbox.height = mainvbox.height - 90;
	vdivbox.width = mainvbox.width - 15;
	vdivboxheight = vdivbox.height  - 25; 	
	
	//vdivbox.height = mainvbox.height - 200;
	//vdivbox.width = mainvbox.width;
	//vdivboxheight = vdivbox.height - 75; 	
	
	for(var ia:int = 0; ia < aCheckBox.length; ia++){
		var c_id:String = aCheckBox[ia]['custom_code'];
		//Alert.show(c_id);
		//var newObject1:datagrid_test = new datagrid_test();
		newObject1 = new datagrid_test();
		newObject1.mainBoard = c_id;
		newObject1.myName_main = myName;
		newObject1.height = (vdivboxheight / div);
		
		newObject1.id = c_id;
		newObject1.my_c_code1 = my_c_code;
		newObject1.my_sid = session_id;
		newObject1.ag_application_entry =application_entry; 
		newObject1.hover_help_actiongrid_domain = hoverhelp_domain;
		
		ArrayShow.addItem(newObject1);
		
		vdivbox.addChild(newObject1);
		
		
	}
	vdivbox.visible = false;
	//	Alert.show(ArrayShow.length.toString());
	
	// Initialize ArrayRetain 
	for( var ir:int = 0; ir < aCheckBox.length; ir++ ){
		ArrayRetain.addItem(null);
		ArrayScroll.addItem(null);
		ArrayRetainKey.addItem(null);
		ArrayRetainKeyValue.addItem(null);
		//ArrayRetainCombo.addItem("-1");
		//ArrayRetainComboPersistent.addItem("-1");
		//ArrayRetainComboGroup.addItem("-1");
	}
	
	// Call first Actiongrid
	/*
	aCheckBox[0]["selected"] = true;
	aCheckBox[0].setStyle("color","blue"); 
	aCheckBox[0].setStyle("borderColor", "blue");
	ShowDatagrid(event);
	*/
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		  
	aCheckBox[actiongrid_code]["selected"] = true;
	aCheckBox[actiongrid_code].setStyle("color","blue"); 
	aCheckBox[actiongrid_code].setStyle("borderColor", "blue");
	aCheckBox[actiongrid_code].setStyle("backgroundImage", "image/downbuttoncolor.PNG");
	aCheckBox[actiongrid_code].styleDeclaration.setStyle("icon",check);
	
	ShowDatagrid(event);
	
	//Alert.show(actiongrid_code.toString());
	//ArrayShow[actiongrid_code].dataList2_trigger(event, false)
	/* 	
	Alert.show(ArrayShow[actiongrid_code]._xlcHistory);
	
	if (ArrayShow[actiongrid_code]._xlcHistory == 'Yes'){ 
	Alert.show("Disaster");
	
	}
	*/	 
	//Alert.show("not sure: " + ArrayShow[actiongrid_code]._xlcHistory);
	/*
	if (ArrayShow[actiongrid_code]._xlcHistory == 'Yes'){ 
	ArrayShow[actiongrid_code].launchHistoryRetrievalMultipleParameters(event);  
	}
	*/
	
	//ArrayShow[0].propertiesList.send();
	//ShowDatagrid(event);
	//Alert.show(ArrayShow[0]._xlcColumn.length.toString());
	
	//ArrayShow[0].launchHistoryRetrievalMultipleParameters(event); 
	
	/*
	aCheckBox[0]["selected"] = true;
	//vdivbox.visible = true;
	//ShowDatagrid(event);
	var div:int = 0; 	
	vdivbox.removeAllChildren();
	if(vdivbox) if( vdivbox.parent ) vdivbox.parent.removeChild( vdivbox );
	vdivbox = new VDividedBox();
	//vdivbox.height = mainvbox.height - 90;
	//mainvbox.height = 813;
	
	vdivbox.height = mainvbox.height - 110;
	vdivbox.width = mainvbox.width - 15;
	//var vdivboxheight:int = vdivbox.height  - 25; 		
	var vdivboxheight:int = vdivbox.height  - 46;
	//vdivboxheight = vdivboxheight - 1
	mainvbox.addChild(vdivbox);
	for(var i:int = 0; i < aCheckBox.length; i++){ 
	if (aCheckBox[i]['selected'] == true){
	div = div + 1;
	}
	}  
	if (div > 2){
	AlertMessageShow("You can only have a maximum of 2 ActionGrids on a page.");
	return;
	}    
	Alert.show("go here");
	for(var ia:int = 0; ia < aCheckBox.length; ia++){
	
	if (aCheckBox[ia]['selected'] == true){
	
	ArrayShow[ia].height = (vdivboxheight / div); 
	vdivbox.addChild(ArrayShow[ia]);
	
	}	
	}  
	vdivbox.visible = true;
	
	vdivbox.addEventListener(MouseEvent.CLICK,setFocusmain);
	*/
	/* ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  */
	/*
	mainvbox.addChild(vdivbox);
	
	var c_id:String = aCheckBox[0]['custom_code'];
	//Alert.show(c_id);
	//var newObject1:datagrid_test = new datagrid_test();
	newObject1 = new datagrid_test();
	newObject1.mainBoard = c_id;
	newObject1.myName_main = myName;
	newObject1.height = (vdivboxheight / div); 
	newObject1.id = c_id;
	newObject1.my_c_code1 = my_c_code;
	newObject1.my_sid = session_id;
	newObject1.hover_help_actiongrid_domain = hoverhelp_domain;
	ArrayShow.addItem(newObject1);
	
	
	vdivbox.addChild(newObject1);
	
	vdivbox.visible = true; 
	
	*/
	
	/* ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  */
	
	
}
////////////////////////////////////////////////////////////////////////////