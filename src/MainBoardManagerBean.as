// ActionScript file
import flash.events.Event;
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.containers.HBox;
import mx.containers.VBox;
import mx.containers.VDividedBox;
import mx.utils.ArrayUtil;

import spark.components.ToggleButton;


private var aFormFields:Array = new Array();
public var newObject1:datagrid_test = new datagrid_test();
public var newObject2:CrunchAnalysisActionGrid = new CrunchAnalysisActionGrid();
public var newObject3:ShowChart = new ShowChart();

     
	private function actioncommand_FilterFunc(item:Object):Boolean {
		
		var ac_f:Boolean = false;
		if (item.command == (c_utils.trim(allcommandsactiongrid)).toUpperCase()){
			ac_f = true;   
		}
		return ac_f;
	}
	public function removeSort(event:Event):void{
	 for(var ix:int = 0; ix < aCheckBox.length; ix++){
 			    		ArrayShow[ix].Array1.sort = null;
			    		ArrayShow[ix].Array1.refresh(); 
			    		if (aCheckBox.length - 1 == ix){
			    			takeActionCommand(event);
			    		}
		}      
	}
	public function takeActionCommand(event:Event):void{
		var retac:String;
		var ref_table:String;
		var ref_numofrec:int;
		var ref_paramcolumnname:String;
		var pass_command_str:String = new String;
		var str_segment_array:Array = [];
		var refresh_code:String = new String;
		var str_len:int;
		var str_entry:String;   
		var ret_date_main:String;
		var ret_time_main:String;
		var main_refresh:String = new String;
		var int_ctr:int = 0;
	    
		
		
		  
		var arr_SelectedAG2:ArrayCollection = new ArrayCollection;
	
		for( var ir:int = 0; ir < aCheckBox.length; ir++ ){
			if(aCheckBox[ir]["selected"] == true){
				arr_SelectedAG2.addItem(aCheckBox[ir]['custom_code']);
			}   
		}  
		
		var arr_FinaltdActionCommand:ArrayCollection = new ArrayCollection;
		for( var i:int = 0; i < arr_SelectedAG2.length; i++ ){
			for( var x:int = 0; x < tdActionCommand.length; x++ ){
				if (arr_SelectedAG2[i] == tdActionCommand[x]["actiongrid"]){
					var obj:Object = new Object;
					obj.command = tdActionCommand[x]["command"];
					obj.description = tdActionCommand[x]["description"];
					obj.jobcode =  tdActionCommand[x]["jobcode"];
					obj.actiongrid = tdActionCommand[x]["actiongrid"]; 
					obj.numofrec = tdActionCommand[x]["numofrec"]; 
					obj.paramcolumnname = tdActionCommand[x]["paramcolumnname"];
					arr_FinaltdActionCommand.addItem(obj);
				} 
			}
		}        
		
		arr_FinaltdActionCommand.refresh();
		
		arr_FinaltdActionCommand.filterFunction = actioncommand_FilterFunc;
		arr_FinaltdActionCommand.refresh();
		if (arr_FinaltdActionCommand.length > 0){
				ShowDatagrid(event);  // -- no, everything seems to work without refreshing. Leave this for now.    
				
				retac = arr_FinaltdActionCommand[0].jobcode;
				ref_table = arr_FinaltdActionCommand[0].refresh;
				ref_numofrec = arr_FinaltdActionCommand[0].numofrec;
				ref_paramcolumnname = arr_FinaltdActionCommand[0].paramcolumnname;
				
			 	
			if (retac.length > 4){
				my_c_code = retac.substr(0,2);     
				retac = retac.substr(2,4);
			}
			
			
		 if (ref_numofrec > 0){   
		 	for(var ia:int = 0; ia < aCheckBox.length; ia++){	
				var c_id:String = aCheckBox[ia]['custom_code'];
 		    	var keyval:String = new String;
					if (ArrayShow[ia].Array1.length < ref_numofrec){
						int_ctr = ArrayShow[ia].Array1.length
					} else {      
						int_ctr = ref_numofrec;
					}
				for (var asac:int = 0; asac < int_ctr; asac++){
					
					var str_res:String = (ArrayShow[ia].Array1[asac][ArrayShow[ia]._xlcColumn[0]["dataField"]].toString());
					
						keyval = keyval + ',' + str_res;
						   
				}
				
		    		var c_id:String = aCheckBox[ia]['custom_code'];    
 		    		if ((pass_command_str == null) || (pass_command_str == "")){   
 		    			pass_command_str = c_id +  keyval;
	        		} else{
	        			pass_command_str = pass_command_str + ',' + c_id +  keyval; 
	        		}
	        		
	        }
	       		xml_job = my_c_code + retac;
				xml_parms = "REFRESH"  + main_refresh + ",COMMAND," + (c_utils.trim(allcommandsactiongrid)).toUpperCase() + ',' + pass_command_str;
				
				reqSJ = retac;		
				reqParms = "REFRESH,COMMAND," + (c_utils.trim(allcommandsactiongrid)).toUpperCase() + ',' + pass_command_str;
				
				trigger_job.send();
		 }	  
		 if (ref_numofrec == 0){	
			for(var ia:int = 0; ia < aCheckBox.length; ia++){	
				var keyval:String = new String;
				//keyval = ArrayRetainKeyValue[ia].toString();
				
				if (ref_paramcolumnname == null){
					keyval = ArrayRetainKeyValue[ia].toString();
					
				} else{
					
					
					
					
			
					keyval = CallSpecificJobColumn(ref_paramcolumnname,ia);
					
					
				}
				
				
				if (keyval == "[object Object]"){
					keyval = '';
				}
				
 		    		var c_id:String = aCheckBox[ia]['custom_code'];
 		    	
					if ((pass_command_str == null) || (pass_command_str == "")){
 		    		 
 		    			pass_command_str = c_id + keyval;
	        			
	        		} else{
	        			pass_command_str = pass_command_str + ',' + c_id + keyval;
	        		}
	        		
	        }
	        
	     
	    
	          if (str_len == 0){
	          	 		xml_job = my_c_code + retac;
 						xml_parms = "COMMAND" + (c_utils.trim(allcommandsactiongrid)).toUpperCase() + "," + pass_command_str;
						reqSJ = retac;		
	    				reqParms = "REFRESH,COMMAND," + (c_utils.trim(allcommandsactiongrid)).toUpperCase() + ',' + pass_command_str;
	          } else{
	          	 		xml_job = my_c_code + retac;
 						xml_parms = "REFRESH"  + main_refresh + ",COMMAND," + (c_utils.trim(allcommandsactiongrid)).toUpperCase() + ',' + pass_command_str;
 						reqSJ = retac;		        
						reqParms = xml_parms;	
	          }
				trigger_job.send();
	 	 		
	 	 			
		 }
		} else {
			allcommandsactiongrid = "";	
		
			launchMoreInfo(); 
		}
		allcommandsactiongrid = "";
	}
	
	private function datagridListROver(event:Event):void{
		mbdg_mousehovering(event,event.currentTarget.label,event.currentTarget.custom_code,'BUTTON_AG');
	}
	private function datagridListROut(event:Event):void{
		   	 mbdg_stopHoverTimer();
	}

	public function drillDownActionGrid(event:Event, l_reqparm:String, l_mainboard_code:String, l_prevtitle:String):void{
		
		var newObject:CustomButton = new CustomButton();
		newObject.custom_code = l_mainboard_code;
		newObject.label = l_mainboard_code;
		newObject.doc_id = '';
		newObject.custom_id = ArrayShow.length; 
		newObject.dd = 'Y';
		addObjectToArray(newObject); 
		
	
			
			vdivbox.removeAllChildren();
			if(vdivbox) if( vdivbox.parent ) vdivbox.parent.removeChild( vdivbox );
			vdivbox.height = mainvbox.height - 90;
			vdivbox.width = mainvbox.width - 15;
			vdivboxheight = vdivbox.height  - 25; 	  
			
			var div:int = 0
			var c_id:String = aCheckBox[aCheckBox.length - 1]['custom_code'];
				newObject1 = new datagrid_test();
				newObject1.mainBoard = l_mainboard_code;
				newObject1.myName_main = myName;
				newObject1.height = (vdivboxheight / div); 
				newObject1.id = c_id;
				newObject1.my_c_code1 = my_c_code;
				newObject1.my_sid = session_id;
				newObject1.ag_application_entry =application_entry;
				newObject1.hover_help_actiongrid_domain = hoverhelp_domain;
				newObject1.previous_drilldown = l_prevtitle;
				
				/*  Flag for Drill Down */
				newObject1.drilldown_flag = "Y";
				newObject1.drilldown_reqparm = l_reqparm;
				
				
				ArrayShow.addItem(newObject1);
				
				vdivbox.addChild(newObject1);
				// Alert.show(parentApplication.shortcut_myviewcode);
				//parentApplication.shortcut_myviewcode = "BASE";
			
				for( var ir:int = 0; ir < aCheckBox.length; ir++ ){  
					ArrayRetain.addItem(null);
					ArrayScroll.addItem(null);
					ArrayRetainKey.addItem(null);
					ArrayRetainKeyValue.addItem(null);
				
				}
				 
			
				aCheckBox[aCheckBox.length - 1]["selected"] = true;
				global_dd = true;
			ShowDatagrid(event);

			
	}
	/////////////////////////////////////////////////////////////////////////////////////////////

public function drillDownCrunch(event:Event,loc_cs_SortByArray:ArrayCollection,loc_xlcColumn:Object, loc_cs_CAArray:ArrayCollection,loc_str_title:String, loc_my_sid:String,loc_my_c_code1:String ):void{
	
	var newObject:CustomButton = new CustomButton();
	newObject.custom_code = "crunch";
	newObject.label = "crunch";
	newObject.doc_id = '';
	newObject.custom_id = ArrayShow.length; 
	newObject.dd = 'Y';
	addObjectToArray(newObject); 
	
	
	
	vdivbox.removeAllChildren();
	if(vdivbox) if( vdivbox.parent ) vdivbox.parent.removeChild( vdivbox );
	vdivbox.height = mainvbox.height - 90;
	vdivbox.width = mainvbox.width - 15;
	vdivboxheight = vdivbox.height  - 25; 	  
	
	/////////
	//parentApplication.drillDownCrunch(event,cs_SortByArray,_xlcColumn,cs_CAArray,str_title,my_sid,my_c_code1,);  
	/*
	
	removeMe_9(event);	
	pop404 = CrunchAnalysis(
	PopUpManager.createPopUp(this, CrunchAnalysis, true));
	pop404.columnArray = cs_SortByArray;
	pop404.mainColumnArray = _xlcColumn;
	pop404.mfArray = cs_CAArray;
	pop404.headTitle = str_title;
	pop404.local_sesid = my_sid;
	pop404.local_companycode = my_c_code1; 
	pop404.local_crunch = "Grand Total";
	*/
	/////////////
	
	
	
	
	
	var div:int = 0
	var c_id:String = aCheckBox[aCheckBox.length - 1]['custom_code'];
	newObject2 = new CrunchAnalysisActionGrid();
	
	
	newObject2.columnArray = loc_cs_SortByArray;
	newObject2.mainColumnArray = loc_xlcColumn;
	newObject2.mfArray = loc_cs_CAArray;
	newObject2.headTitle = loc_str_title;
	newObject2.local_sesid = loc_my_sid;
	newObject2.local_companycode = loc_my_c_code1; 
	newObject2.local_crunch = "Grand Total";
	
	//parentApplication.CrunchAnalysisActionGrid["btn_showChart"].addEventListener( MouseEvent.CLICK,showChart_crunch);
	
	
//	newObject2.mainBoard = l_mainboard_code;
//	newObject2.myName_main = myName;
	newObject2.height = (vdivboxheight / div); 
	newObject2.id = c_id;
//	newObject2.my_c_code1 = my_c_code;
//	newObject2.my_sid = session_id;
//	newObject2.ag_application_entry =application_entry;
//	newObject2.hover_help_actiongrid_domain = hoverhelp_domain;
//	newObject2.previous_drilldown = l_prevtitle;
	
	/*  Flag for Drill Down */
//	newObject2.drilldown_flag = "Y";
//	newObject2.drilldown_reqparm = l_reqparm;  
	//newObject2["btn_showChart"].addEventListener( MouseEvent.CLICK,newObject1.showChart_crunch);
	//Alert.show(ArrayShow.length.toString());
	ArrayShow.addItem(newObject2);
	//Alert.show(ArrayShow.length.toString());
	vdivbox.addChild(newObject2);
	//Alert.show("check 3");
	vdivbox.visible = true;
	
	for( var ir:int = 0; ir < aCheckBox.length; ir++ ){  
		ArrayRetain.addItem(null);
		ArrayScroll.addItem(null);
		ArrayRetainKey.addItem(null);
		ArrayRetainKeyValue.addItem(null);
		
	}
	
	
	
	if(vdivbox) if( vdivbox.parent ) vdivbox.parent.removeChild( vdivbox );
	vdivbox = new VDividedBox();
	vdivbox.height = mainvbox.height - 110;
	vdivbox.width = mainvbox.width - 15;
	var vdivboxheight:int = vdivbox.height  - 46;
	mainvbox.addChild(vdivbox);  
	
	aCheckBox[aCheckBox.length - 1]["selected"] = true;
	
	ArrayShow[aCheckBox.length-1].height = (vdivboxheight / 1); 
	vdivbox.addChild(ArrayShow[aCheckBox.length-1]);  	
	  
	
	
	
	//ShowDatagrid(event);
	/*
	if (aCheckBox[aCheckBox.length-1]['selected'] == true){
		Alert.show("Check 1");
		ArrayShow[aCheckBox.length-1].height = (vdivboxheight / 1); 
		vdivbox.addChild(ArrayShow[aCheckBox.length-1]);  	
*/
}


public function drilldownshowChart():void{
	var newObject:CustomButton = new CustomButton();
	newObject.custom_code = "crunch";
	newObject.label = "crunch";
	newObject.doc_id = '';
	newObject.custom_id = ArrayShow.length; 
	newObject.dd = 'Y';
	addObjectToArray(newObject); 
	
	
	
	vdivbox.removeAllChildren();
	if(vdivbox) if( vdivbox.parent ) vdivbox.parent.removeChild( vdivbox );
	vdivbox.height = mainvbox.height - 90;
	vdivbox.width = mainvbox.width - 15;
	vdivboxheight = vdivbox.height  - 25; 	  
	
	/////////
	//parentApplication.drillDownCrunch(event,cs_SortByArray,_xlcColumn,cs_CAArray,str_title,my_sid,my_c_code1,);  
	/*
	
	removeMe_9(event);	
	pop404 = CrunchAnalysis(
	PopUpManager.createPopUp(this, CrunchAnalysis, true));
	pop404.columnArray = cs_SortByArray;
	pop404.mainColumnArray = _xlcColumn;
	pop404.mfArray = cs_CAArray;
	pop404.headTitle = str_title;
	pop404.local_sesid = my_sid;
	pop404.local_companycode = my_c_code1; 
	pop404.local_crunch = "Grand Total";
	*/
	/////////////
	
	
	
	
	
	var div:int = 0
	var c_id:String = aCheckBox[aCheckBox.length - 1]['custom_code'];
	newObject3 = new ShowChart();
	
	newObject3.mfArray = newObject2.newObject1.Array1; 
	newObject3.ca_xlcColumn = newObject2.newObject1._xlcColumn; 
	newObject3.adv_mfArray = newObject2.newObject1.dg;
	newObject3.cap_title = newObject2.crunchtitle.text;
	newObject3.showlocal_crunch = newObject2.local_crunch;
	newObject3.par_select = 0; 
	newObject3.par_type = 0; 
	
	//parentApplication.CrunchAnalysisActionGrid["btn_showChart"].addEventListener( MouseEvent.CLICK,showChart_crunch);
	
	
	//	newObject2.mainBoard = l_mainboard_code;
	//	newObject2.myName_main = myName;
	newObject3.height = (vdivboxheight / div); 
	newObject3.id = c_id;
	//	newObject2.my_c_code1 = my_c_code;
	//	newObject2.my_sid = session_id;
	//	newObject2.ag_application_entry =application_entry;
	//	newObject2.hover_help_actiongrid_domain = hoverhelp_domain;
	//	newObject2.previous_drilldown = l_prevtitle;
	
	/*  Flag for Drill Down */
	//	newObject2.drilldown_flag = "Y";
	//	newObject2.drilldown_reqparm = l_reqparm;  
	//newObject2["btn_showChart"].addEventListener( MouseEvent.CLICK,newObject1.showChart_crunch);
	//Alert.show(ArrayShow.length.toString());
	ArrayShow.addItem(newObject3);
	//Alert.show(ArrayShow.length.toString());
	vdivbox.addChild(newObject3);
	//Alert.show("check 3");
	vdivbox.visible = true;
	
	for( var ir:int = 0; ir < aCheckBox.length; ir++ ){  
		ArrayRetain.addItem(null);
		ArrayScroll.addItem(null);
		ArrayRetainKey.addItem(null);
		ArrayRetainKeyValue.addItem(null);
		
	}
	
	
	
	if(vdivbox) if( vdivbox.parent ) vdivbox.parent.removeChild( vdivbox );
	vdivbox = new VDividedBox();
	vdivbox.height = mainvbox.height - 110;
	vdivbox.width = mainvbox.width - 15;
	var vdivboxheight:int = vdivbox.height  - 46;
	mainvbox.addChild(vdivbox);  
	
	aCheckBox[aCheckBox.length - 1]["selected"] = true;
	
	ArrayShow[aCheckBox.length-1].height = (vdivboxheight / 1); 
	vdivbox.addChild(ArrayShow[aCheckBox.length-1]);  	
	
	
	
}   
  
//////////////////////////////////////////////////////////////////////////////////////////////////////
	public function newCheckBox(event:Event, mb_datagrid:ArrayCollection):void{
		 
 			var space:Spacer = new Spacer();
 			space.width = 20;
			
			
			
			for (var i:int=0;i<mb_datagrid.length;i++)  {
				
				var newObject:CustomButton = new CustomButton();
				newObject.custom_code = mb_datagrid[i]["mbdcode"];
				
				newObject.label = mb_datagrid[i]["btnlabel"];
				newObject.doc_id = mb_datagrid[i]["docid"];
				newObject.custom_id = mb_datagrid[i]["id"]; 
				newObject1.ag_application_entry =application_entry;
				newObject.setStyle('fontWeight','bold');
				newObject.setStyle('fontSize',20);
				newObject.setStyle('i',"image/downbuttoncolor.PNG");
				newObject.addEventListener( MouseEvent.CLICK,ActionButtonsEvent);
				addObjectToArray(newObject); 
				hb_mbdatagrid_actiongrid.addChild(newObject);
				
 			}
			
			
			
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
	 	 	
			for(var ia:int = 0; ia < aCheckBox.length; ia++){
 		    			var c_id:String = aCheckBox[ia]['custom_code'];
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
 				for( var ir:int = 0; ir < aCheckBox.length; ir++ ){
	 			ArrayRetain.addItem(null);
	 			ArrayScroll.addItem(null);
	 			ArrayRetainKey.addItem(null);
	 			ArrayRetainKeyValue.addItem(null);
	 		}
			aCheckBox[actiongrid_code]["selected"] = true;
			aCheckBox[actiongrid_code].setStyle("color","blue"); 
			aCheckBox[actiongrid_code].setStyle("borderColor", "blue");
			aCheckBox[actiongrid_code].setStyle("backgroundImage", "image/downbuttoncolor.PNG");
			aCheckBox[actiongrid_code].styleDeclaration.setStyle("icon",check);
			
			ShowDatagrid(event);
	
		
			
	}
	 private function addObjectToArray(formField:DisplayObject):void{
		 		this.aCheckBox.push(formField);
	}			 
	
		private function SortArray(myArray:ArrayCollection):ArrayCollection
			{ 
				var tempValue:String; 
				var done:String = "no"; 
				var swap:String = "no"; 
				var i:int; 
				
				var fileTemp1:int; 
				var fileTemp2:int; 
				
				
				while (done == "no") { 
				
					for (i = 0; i < (myArray.length - 1); i++) {
					 
						fileTemp1 = myArray[i]; 
						fileTemp2 = myArray[i+1]; 
						if (fileTemp1 > fileTemp2) { 
							tempValue = myArray[i]; 
							myArray[i] = myArray[i+1]; 
							myArray[i+1] = tempValue; 
							swap = "yes"; 
						} 
					} 
					
					if (swap == "no") { 
						done = "yes"; 
					} 
						swap = "no"; 
				 
				     
				} 
				return myArray; 
			} 

	public var vdivboxheight:int;
	
	private function cleanAGDataArray():void{
		for(var ib:int = aCheckBox.length; ib > tdMainBoardDatagrid.length; ib--){
			
		
			
			ArrayShow[ib-1].tdObjectCollection = null;
			ArrayShow[ib-1].tdObjectCollectionRefresh = null;	
			ArrayShow[ib-1].Array1 = null;
			ArrayShow[ib-1].Array2 = null;
			ArrayShow[ib-1].Array3 = null;
			ArrayShow[ib-1].Array4 = null;
			ArrayShow[ib-1].Array5 = null;
			ArrayShow[ib-1].Array6 = null;
			ArrayShow[ib-1].ArrayColumnGroup = null;
			ArrayShow[ib-1].ArrayMultipleFilter = null;
			ArrayShow[ib-1].ArrayFilterInsert = null;
			ArrayShow[ib-1]._xlcColumn = null;
			ArrayShow[ib-1]._xlcColumnGroup = null;
			
			
			   
			ArrayShow[ib-1].tdObjectCollection = new ArrayCollection;
			ArrayShow[ib-1].tdObjectCollectionRefresh = new ArrayCollection;	
			ArrayShow[ib-1].Array1 = new ArrayCollection;
			ArrayShow[ib-1].Array2 = new ArrayCollection;
			ArrayShow[ib-1].Array3 = new ArrayCollection;
			ArrayShow[ib-1].Array4 = new ArrayCollection;
			ArrayShow[ib-1].Array5 = new ArrayCollection;
			ArrayShow[ib-1].Array6 = new ArrayCollection;
			ArrayShow[ib-1].ArrayColumnGroup = new ArrayCollection;
			ArrayShow[ib-1].ArrayMultipleFilter = new ArrayCollection;
			ArrayShow[ib-1].ArrayFilterInsert = new ArrayCollection;
			ArrayShow[ib-1]._xlcColumn = new ArrayCollection
			ArrayShow[ib-1]._xlcColumnGroup = new ArrayCollection;
			
			aCheckBox[aCheckBox.length - 1]["selected"] = false;  
			aCheckBox.splice(aCheckBox.length - 1, 1)
			ArrayShow.removeItemAt(ArrayShow.length-1);
		}  
	}

	public function ActionButtonsEvent(event :MouseEvent):void{
		
		
		cleanAGDataArray();
		
		if (event.shiftKey) {   /* Need to have a Shift+click to generate a split screen of ActionGrids. */
		
			for( var a:int = 0; a < aCheckBox.length; a++ ){
				
				
				
				if (a == (event.currentTarget.custom_id - 1)){
					aCheckBox[a]["selected"] = true;
					aCheckBox[a].setStyle("color","blue"); 
					aCheckBox[a].setStyle("borderColor", "blue");
					
					aCheckBox[a].styleDeclaration.setStyle("icon",check);
				}
				
			}
			
		} else { 
			
		
		
				for( var a:int = 0; a < aCheckBox.length; a++ ){
					if (a != (event.currentTarget.custom_id - 1)){
						aCheckBox[a]["selected"] = false;
						aCheckBox[a].setStyle("color","black"); 
						aCheckBox[a].setStyle("borderColor","");  
					
						aCheckBox[a].styleDeclaration.setStyle("icon",cross);
					}
			
					if (a == (event.currentTarget.custom_id - 1)){
						aCheckBox[a]["selected"] = true;
						aCheckBox[a].setStyle("color","blue"); 
						aCheckBox[a].setStyle("borderColor", "blue");
						aCheckBox[a].styleDeclaration.setStyle("icon",check);
					
					}
				} 
		}
		
		ShowDatagrid(event);
	}

[Embed(source="image/bullet_check.png")] 
[Bindable] public var check:Class; 
[Embed(source="image/button_spacer.png")] 
[Bindable] public var cross:Class;   


public var str_segment_arrayretain:Array = [];

	private function CallSpecificJobColumn(ref_col:String, cb_no:int):String{
		var ArrayRetainKeyLoc:ArrayCollection = new ArrayCollection();
		var arrayselected:int;
		var arrayid:String;
		var arr_bwiset:ArrayCollection = new ArrayCollection;
		var str_segment_array:Array = [];
		var str_len:int;    
		var str_cbcurrentview:int = new int;
		var ArrayRetainLoc:ArrayCollection = new ArrayCollection;	
		var ArrayScrollLoc:ArrayCollection = new ArrayCollection;
		var str_arrdata:String = new String;
		//for( var ir:int = 0; ir < aCheckBox.length ; ir++ )
		//{
		
			
			var newObject2:Object = new Object(); 
			var newObject3:Object = new Object();
			var newObject4:Object = new Object();
			
			//newObject2 = (ArrayShow[ir].dg.selectedIndices).toString();
			newObject2 = (ArrayShow[cb_no].dg.selectedIndices).toString();
			
		
			//arrayselected = ArrayShow[ir].dg.selectedItems.length;
			arrayselected = ArrayShow[cb_no].dg.selectedItems.length;
			var obj:Object = new Object();   
			arr_bwiset = new ArrayCollection();
		  
			if  ((ArrayShow[cb_no].Array1.length == arrayselected)&&(ArrayShow[cb_no].Array1.sort != null)){
				for( var iarr:int = 0; iarr < arrayselected; iarr++ ){
					obj = iarr;
					arr_bwiset.addItem(obj); 
				}
			} else {
				for( var iarr:int = 0; iarr < arrayselected; iarr++ ){
					obj = ArrayShow[cb_no].dg.selectedIndices[iarr];
					arr_bwiset.addItem(obj); 
				}  
				
			}
		
			var list:ArrayCollection = SortArray(arr_bwiset);
			//Alert.show(list.length.toString());
			if (list.length > 0){
			
			newObject3 = list.toString();
			
			/*
			if (newObject3 == null){
				Alert.show("pakshet");
			} else {
				Alert.show(newObject3.toString());
			}
			*/
			/* index has been sorted to Array  */
			//ArrayRetainKeyLoc.removeItemAt(ir);
			//Alert.show("go here: " + cb_no.toString());
			//ArrayRetainKeyLoc.addItemAt(newObject3,cb_no);
			ArrayRetainKeyLoc.addItemAt(newObject3,0);
		
			
			//c_utils.trim(ArrayRetainKeyLoc[cb_no]);
			c_utils.trim(ArrayRetainKeyLoc[0]);
			
			//var dec_rk:String = ArrayRetainKeyLoc[cb_no].toString();
			var dec_rk:String = ArrayRetainKeyLoc[0].toString();
			 
		
			
					if (dec_rk.length > 0){
						
						str_segment_array = new Array;
						//str_segment_array = ArrayRetainKeyLoc[cb_no].split(",");
						str_segment_array = ArrayRetainKeyLoc[0].split(",");
						str_len = str_segment_array.length;
						 
						for( var iarrs:int = 0; iarrs < str_len; iarrs++ ){
							var i_ssar:int = str_segment_array[iarrs]; 
							//Alert.show(ref_col);
							//CheckxlcColumnExist(cb_no, ref_col);
							
							if (CheckxlcColumnExist(cb_no, ref_col) == true ){
							var aair:String = ArrayShow[cb_no].Array1[ i_ssar ][ref_col];
							if (ArrayShow[cb_no].Array1[ i_ssar ][ref_col] == null){
								aair = "";
							}
							//str_arrdata = str_arrdata + ',' + ArrayShow[cb_no].Array1[ i_ssar ][ref_col];
							str_arrdata = str_arrdata + ',' + aair;
							
							} else {
							// Alert.show("go here");
								str_arrdata = str_arrdata + ',' + ArrayShow[cb_no].Array1[ i_ssar ][ArrayShow[cb_no]._xlcColumn[0]["dataField"]];
							}
							//str_arrdata = str_arrdata + ',' + ArrayShow[ir].Array1[ i_ssar ][ArrayShow[ir][ref_col]];
							
							//str_arrdata = str_arrdata + ',' + ArrayShow[ir].Array1[ i_ssar ][ArrayShow[ir]._xlcColumn[0]["dataField"]];
							
							
								 
						}  
						
					}
			}else {
				str_arrdata = "";	
			}	
			//ArrayRetainKeyValue.removeItemAt(ir);	
			//ArrayRetainKeyValue.addItemAt(newObject4,ir);
		//} 
		
	return str_arrdata; 
	}
	 

	private function CheckxlcColumnExist(loc_cb_no:int, loc_refcol:String):Boolean{
	
	 var bol:Boolean = false;
			
		for( var x:int = 0; x < ArrayShow[loc_cb_no]._xlcColumn.length ; x++ ){
			
			if(ArrayShow[loc_cb_no]._xlcColumn[x]["dataField"] == loc_refcol){
				bol = true;
				break;
			}
		}
		
	 return bol		
	}


	 public function ShowDatagrid(event :Event):void{ 
		
		 vdivbox.visible = false;
		 vdivbox.removeAllChildren();		    
		
 		var arrayselected:int;
	 	var arrayid:String;
	 	var arr_bwiset:ArrayCollection = new ArrayCollection;
		var str_segment_array:Array = [];
		var str_len:int;    
		var str_cbcurrentview:int = new int;
	
		for( var ir:int = 0; ir < aCheckBox.length ; ir++ )
		{
	
			var newObject2:Object = new Object(); 
			var newObject3:Object = new Object();
			var newObject4:Object = new Object();
			
			newObject2 = (ArrayShow[ir].dg.selectedIndices).toString();
			
			ArrayRetain.removeItemAt(ir); 
			ArrayRetain.addItemAt(newObject2,ir);
			ArrayScroll.removeItemAt(ir);
			ArrayScroll.addItemAt(ArrayShow[ir].dg.horizontalScrollPosition,ir);
			arrayselected = ArrayShow[ir].dg.selectedItems.length;
	 		var obj:Object = new Object();   
	 		arr_bwiset = new ArrayCollection();
	 		
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
			
			var list:ArrayCollection = SortArray(arr_bwiset);
			newObject3 = list.toString();
			/* index has been sorted to Array  */
			ArrayRetainKey.removeItemAt(ir);		 
			ArrayRetainKey.addItemAt(newObject3,ir);
			c_utils.trim(ArrayRetainKey[ir]);
	
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

		if(vdivbox) if( vdivbox.parent ) vdivbox.parent.removeChild( vdivbox );
		vdivbox = new VDividedBox();
		vdivbox.height = mainvbox.height - 110;
		vdivbox.width = mainvbox.width - 15;
	 	var vdivboxheight:int = vdivbox.height  - 46;
	 	mainvbox.addChild(vdivbox);   
	 	for(var i:int = 0; i < aCheckBox.length; i++){ 
				if (aCheckBox[i]['dd'] == 'N'){
					if (aCheckBox[i]['selected'] == true){
                		div = div + 1;
						
                	}
				}	
 		}  
		if (global_dd == false){
			
 			if (div > 2){   
 				AlertMessageShow("You can only have a maximum of 2 ActionGrids on a page.");
 				return;
 			}    
		}
		if (global_dd == false){
			for(var ia:int = 0; ia < aCheckBox.length; ia++){
						if (aCheckBox[ia]['selected'] == true){
			    			ArrayShow[ia].height = (vdivboxheight / div); 
			    			vdivbox.addChild(ArrayShow[ia]);   
                		}	   
 			}  
		}
		if (global_dd == true){
			if (aCheckBox[aCheckBox.length-1]['selected'] == true){
			
				ArrayShow[aCheckBox.length-1].height = (vdivboxheight / 1); 
				vdivbox.addChild(ArrayShow[aCheckBox.length-1]);  
			} else {
				for(var ia:int = 0; ia < aCheckBox.length; ia++){    
					if (aCheckBox[ia]['selected'] == true){
						ArrayShow[ia].height = (vdivboxheight / div); 
						vdivbox.addChild(ArrayShow[ia]);   
					}	   
				}  
			}
		}
		
		 str_segment_arrayretain = [];
	if (global_dd == false){	 
	 	for(var ib:int = 0; ib < aCheckBox.length; ib++){         
               	if (aCheckBox[ib]['selected'] == true){
                		str_segment_arrayretain = ArrayRetain[ib].split(",");
                		if (ArrayRetain[ib].toString() != ""){
                			ArrayShow[ib].dg.selectedIndices = str_segment_arrayretain;
                		}
						ArrayShow[ib].dg.horizontalScrollPosition = ArrayScroll[ib];
                		ArrayShow[ib].dg_hsb = ArrayScroll[ib];
						
						if (ArrayShow[ib]._xlcHistory != 'Yes'){ 
							
							if (application_entry == 'ml'){ 
								ArrayShow[ib].dataList_2.url = 'ae_tlch_ml_req.php';
								ArrayShow[ib].dataList.url = 'ae_tlch_ml_req.php';
								
							}
							
							if (ArrayShow[ib]._xlcRefreshAll == 'Y'){
								
								ArrayShow[ib].dataList.send();
							}
							else{    
							
							
									ArrayShow[ib].dataList_2.send();
							}
						} else {
							ArrayShow[ib].launchHistoryRetrievalMultipleParameters(event, ArrayShow[ib]._xlcDynamicIndicator)
						}
               	} 
 		}       
	}
	 
	if (global_dd == true){	 
				str_segment_arrayretain = ArrayRetain[ib].split(",");
				if (ArrayRetain[ArrayShow.length -1].toString() != ""){
					ArrayShow[ArrayShow.length -1].dg.selectedIndices = str_segment_arrayretain;
				}
				
	}	
	 }
	 
	   private function setFocusmain(event:MouseEvent):void {
	  	
	  	var str_tar_array:Array = [];
	  	var tar:String = event.target.toString();
	  	str_tar_array = tar.split(".");	
	  	tar = str_tar_array[7].toString();
	  	tar = tar.substr(0,15);
	  	
	  }       
		public var pop6:InterfaceActionCommand;
		public var cc:String;
	
		
        public function launchMoreInfo():void {
      		/*  Select only the active actiongrid */
			var l_str_mbcinterface:String = new String;
			var l_str_mbcinterfacelabel:String = new String;
			
			l_str_mbcinterface =  mbcInterface();
			l_str_mbcinterfacelabel = mbcInterfaceLabel();
			
		    	pop6 = InterfaceActionCommand(  
					
                PopUpManager.createPopUp(this, InterfaceActionCommand, true)); 
                pop6.cc = my_c_code;
              	pop6.sid = session_id;
              	pop6.mbc =  l_str_mbcinterface;
				pop6.mbc_label = l_str_mbcinterfacelabel;
				pop6["dg_action"].addEventListener("itemClick", enterActionCommandmain);
               
                PopUpManager.centerPopUp(pop6);
        }
	  
	
			private function enterActionCommandmain(event:Event){
				
						enterActionCommand(event, pop6.dg_action.selectedItem.command, '');
						PopUpManager.removePopUp(pop6);
							
					 
			}		
	    private function mbcInterface():String{
			var str_job:String = new String();
			for( var ir:int = 0; ir < aCheckBox.length; ir++ ){
				if(aCheckBox[ir]["selected"] == true){
					str_job = str_job + aCheckBox[ir]['custom_code'] + ',';
					
				}      
			}  
			str_job = str_job.substr(0, str_job.length - 1);
			
			return str_job;
		}
		private function mbcInterfaceLabel():String{
			var str_joblabel:String = new String();
			for( var ir:int = 0; ir < aCheckBox.length; ir++ ){
				if(aCheckBox[ir]["selected"] == true){
					str_joblabel = aCheckBox[ir]['label']
					
				}      
			}  
			
			
			return str_joblabel;
		}
		public function passData(evt:Event):void {
		//Alert.show(allcommandsactiongrid);
			var l_str_job:String = new String;
			l_str_job = mbcInterface();
			g_action =  "refreshData";   
			
			reqActionParms = "REFRESH,RETRIEVE|ACTIONCMDS|" +l_str_job + "|"; 
			tdJobCodeMainboard.send();
			   
			 
        }    
        private function removeMe(event:Event):void {
            			allcommandsactiongrid = "";
			
        }  
        public function enterActionCommand_old(event:KeyboardEvent):void
		{
			
					if ((event.keyCode == Keyboard.ENTER))
					{
						passData(event);
					}
					
					if ((event.keyCode == Keyboard.ESCAPE))
					{
						removeMe(event);  
					}
					   
		}
		public function enterActionCommand(event:Event, acag:String, mainboardname:String):void
		{
			
			allcommandsactiongrid = acag;
			passData(event);
			
		}
		private function FaulttriggeractionHandler(evt:FaultEvent):void
		{
			AlertMessageShow("Fault: " + evt.message.toString())
			
		}   
		
		
		   
	private function triggeractionHandler(event:ResultEvent):void{
			
			if ( event.result.ezware_response.status == 'FAIL' ) {
        	
        			AlertMessageShow(event.result.ezware_response.reason);
        			return;    
        		}
			
 	ShowDatagrid(event);
 		
	 }
		
	/////////   Procedure for DatagridList MouseHover as per Tim Legere
   			public var mbdg_pophoverinterface:MouseHoverMenu;
   			private const TIMER_INTERVAL_FOR_HOVER_MBDG:int = 2000;
   			
   			public var mbdg_nt:Timer;
   			public var mbdg_objecttitle:String;
   			public var mbdg_objecttitleheader:String;
   			public var mbdg_objecthelpfortitle:String;
   			
   			
   			private function mbdg_mousehovering_for_help(event:Event, object_title:String,object_id:String, object_type:String, object_code_id:String):void{
   				
				if (mousehoverpars == "YES"){
						 						
					var urlpass:String = "../helpdocs/VLHelp/ApplicationHelp_CSH.htm#" + object_code_id.substr(1,object_code_id.length);
					var jscommand:String = "window.open('" + urlpass + "','win','top=100,left=0,height=775,width=900,toolbar=no,scrollbars=yes');"; 
					
					var url:URLRequest = new URLRequest("javascript:" + jscommand + " void(0);"); 
					navigateToURL(url, "_self");
				}


            }
   			 private function eZLearn_for_help_highview():void{
   				
   					var urlpass:String = hoverhelp_domain + mbdg_objecttitle;
   					
					var jscommand:String = "window.open('" + urlpass + "','win','top=100,left=0,height=775,width=900,toolbar=no,scrollbars=yes');"; 
					
					var url:URLRequest = new URLRequest("javascript:" + jscommand + " void(0);"); 
					navigateToURL(url, "_self");
			}
   			public function mbdg_mousehovering(event:Event, object_title:String,object_id:String, object_type:String):void{
   				
				   
				if (mousehoverpars == "YES"){
					mbdg_objecttitle = object_id;
					mbdg_objecttitleheader =  object_type;
					mbdg_objecthelpfortitle = object_title;
					
            		mbdg_nt = new Timer(TIMER_INTERVAL_FOR_HOVER_MBDG);
            
                	mbdg_nt.addEventListener(TimerEvent.TIMER, mbdg_updateHoverTimer); 
                	mbdg_startHoverTimer();
            	}


            }	

				private function mbdg_PopEZLearn(evt:Event):void {
					
					mbdg_pophoverinterface = MouseHoverMenu(
						PopUpManager.createPopUp(this, MouseHoverMenu,true));
					mbdg_pophoverinterface.helpfortitleheader = mbdg_objecthelpfortitle;
					mbdg_pophoverinterface.helpfortitle = mbdg_objecttitle;
					mbdg_pophoverinterface.object_type = mbdg_objecttitleheader;
					mbdg_pophoverinterface.loc_ccode = my_c_code;
					mbdg_pophoverinterface.loc_sid = session_id;
					mbdg_pophoverinterface.loc_appcode = application_entry;
					
				}
				
				public function pre_mbdg_mousehovering(event:Event, object_title:String,object_id:String, object_type:String):void{
				
					PopUpManager.removePopUp(mbdg_pophoverinterface);
					
					
					if (mousehoverparslabel == "OFF")
					{
						mbdg_objecttitle = object_id;
						mbdg_objecttitleheader =  object_type;
						mbdg_objecthelpfortitle = object_title;
						mbdg_PopEZLearn(event);
						
					}
					else
					{
						mousehoverpars = "NO";
						mousehoverparslabel = "OFF"
					}
					
					
					
						
				
				}	

				private function eZLearn_click(event:Event){
				
					//{pre_mbdg_mousehovering(event,my_c_code_description,my_c_code_description,'BUTTON')}
					
					//Alert.show(toxml_mbcode.search("@").toString());
					
					if   (toxml_mbcode.search("@") > 0) {
						pre_mbdg_mousehovering(event,"HighView Shortcut","HighView Shortcut",'BUTTON')
					} else {
						pre_mbdg_mousehovering(event,my_c_code_description,my_c_code_description,'BUTTON')
					}
					
					
				}
				
				public function scholarcap_mousehovering(event:Event, object_title:String,object_id:String, object_type:String):void{
					
						mbdg_objecttitle = object_id;
						mbdg_objecttitleheader =  object_type;
						mbdg_objecthelpfortitle = object_title;
						mbdg_PopEZLearn(event);
						
				}	

   			  private function mbdg_updateHoverTimer(evt:TimerEvent):void {
             
        		 mbdg_stopHoverTimer();
        		 // Remove the flare for now as per Tim's request
        		 //eZLearn_for_help_highview()
        		
             	mbdg_pophoverinterface = MouseHoverMenu(
                PopUpManager.createPopUp(this, MouseHoverMenu,true));
                mbdg_pophoverinterface.helpfortitleheader = mbdg_objecthelpfortitle;
                mbdg_pophoverinterface.helpfortitle = mbdg_objecttitle;
				
                mbdg_pophoverinterface.object_type = mbdg_objecttitleheader;
                mbdg_pophoverinterface.loc_ccode = my_c_code;
				mbdg_pophoverinterface.loc_sid = session_id;
				mbdg_pophoverinterface.loc_appcode = application_entry;
             	 
            }
   			   private function mbdg_startHoverTimer():void {
                mbdg_nt.start(); 
                
            }

            	public function mbdg_stopHoverTimer():void {
                 mbdg_nt.stop();
            } 
			private function handleMouseWheelMainActionGridCommand(event:MouseEvent):void{
				if (event.delta >= 0){
					LeftPanActionGridButton(event)
				} else {  
					RightPanActionGridButton(event)
				}
			}
            private function RightPanActionGridButton(event:Event):void {
                 bx_ag.horizontalScrollPosition = bx_ag.horizontalScrollPosition + 200;
            } 
            
            private function LeftPanActionGridButton(event:Event):void {
                 bx_ag.horizontalScrollPosition = bx_ag.horizontalScrollPosition - 200;
            } 





           
			public function mainboard_backDrillDown_1(evt:Event):void {
						aCheckBox[aCheckBox.length - 1]["selected"] = false;
						aCheckBox.splice(aCheckBox.length - 1, 1)
						ArrayShow.removeItemAt(ArrayShow.length-1);
						if (tdMainBoardDatagrid.length >= aCheckBox.length){
							global_dd = false;
							ShowDatagrid(evt);
						} else {
							global_dd = true;
							ShowDatagrid(evt)
						}
						
						
							
						
				
			}
			public function mainboard_backDrillDown_all(evt:Event):void {
				
				// Remove dynamic buttons after tdMainBoardDatagrid from the Action Grid buttons.
				
				if (tdMainBoardDatagrid.length < aCheckBox.length){
					cleanAGDataArray();
					
					
					
					ShowDatagrid(evt);
				}
				
			
			}


			public function setHoverHelpOn(event:Event):void{
				PopUpManager.removePopUp(mbdg_pophoverinterface); 
				launchEZLearnMenu(event);
			}
   		