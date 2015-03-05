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
import mx.containers.Panel;
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

		public var analyzeColumns:ArrayCollection = new ArrayCollection;
		public var numericColumns:ArrayCollection = new ArrayCollection;	
		public var nonnumericColumns:ArrayCollection = new ArrayCollection;	
		private var obj_num:Object = new Object;
 
			private function toolTipHandler(event:Event):void{
				if (parentApplication.mousehoverpars == "NO"){
					ToolTipManager.enabled = true;
				}
				if (parentApplication.mousehoverpars == "YES"){
					ToolTipManager.enabled = false;
				}
			}
			private var tip:ToolTip;
			
			private function FilterDescription(type:String):void{
				if (type == "P"){
					for (var i:int=0;i < fhp.length; i++)  {
						if (lbl_persistent_view.text == fhp[i].filtercode){
							filterDescription_persistent = fhp[i].filterdescription;
							filterDescription_transient = "";
							lbl_transient_view.text = "No selection"
							
						}
					}
				}	
				if (type == "T"){
					for (var ia:int=0;ia < fh.length; ia++)  {  
						if (lbl_transient_view.text == fh[ia].filtercode){
							filterDescription_transient = fh[ia].filterdescription
						}
					}
				}
				
			}
		private function myDataTipFunction(value:Object):String{ 
			return (value.filtercode + ' - ' +  value.filterdescription);
		}

		private function init(event:Event):void {
			
			//lbl_maximumnumberofrows.width = 0;
			
			/* Check Speed Option Connection */
			checkSpeedOptionConnection(event);
			
			httpRequestUrlDatagrid(ag_application_entry);
			
			/*  Only for mylogitics*/
			if (ag_application_entry == "ml"){
				tabnav_buttons.removeChildAt(6);
				tabnav_buttons.removeChildAt(3);
				
			}

			   
			myDropdownFactory = new ClassFactory(List);
			myDropdownFactory.properties = {showDataTips:true, dataTipFunction:myDataTipFunction,x:24 }
			//	launchErgo();     
			//////////////////////////////////////
			/*  Fire Alert for Waiting Display */
			Alert.buttonWidth =141; 
			 myAlert = Alert.show("","Database Refresh...",0,this,null,confirmIcon);  
			// modify the look of the Alert box
			myAlert.setStyle("backgroundColor", '#C3D9FA');
			myAlert.setStyle("borderColor", 0xffffff);
			myAlert.setStyle("borderAlpha", 0.75);
			myAlert.setStyle("fontSize", 14); 
			myAlert.setStyle("fontWeight", "bold");
			myAlert.setStyle("color", 0x000000); // text color
			///////////////////////////////////////
			 t = new Timer(TIMER_INTERVAL);
                t.addEventListener(TimerEvent.TIMER, updateTimer); 
                startTimer();
				ToolTip.maxWidth = 1000;
				ToolTipManager.hideDelay = 9000;
				// Retrieve action buttons on the bottom of the actiongrid
				ActionButtons.send();
				// Retrive My View buttons
				MyViewButtons.send();
				//req_sq = "REFRESH,RETRIEVE|VARIABLEDATES|" + user_sq + "|" + cc_sq + "|";  
				SubmitDateVariable.send();
				// initialize Auto Refresh
				autorefresh_flag = "OFF"
				
              	g_my_action =  "refreshData";
				
				reqParms = "REFRESH,RETRIEVE|MBDMODULE|" + mainBoard + "|"; 
				
    		 	if (crunch != true){
					
					if (pivot == true){
						
						tdObjectCollection = new ArrayCollection;
						Array1 = new ArrayCollection; 
						Array2 = new ArrayCollection;
						Array3 = new ArrayCollection;
						PopUpManager.removePopUp(myAlert);
						buildDatagrid();
						ArraySwapfromPivot();
						refreshButton(event);
						correctWidth(event);
					} else {           
						mbdmodule_getpropertylist.send();
					}
					
					
    		 	} else {
    		 		
    		 	tdObjectCollection = new ArrayCollection;
    		 	Array1 = new ArrayCollection; 
    		 	Array2 = new ArrayCollection;
    		 	Array3 = new ArrayCollection;
    				PopUpManager.removePopUp(myAlert);
					
					
					tab_userpreferences.enabled = false; 
					tab_panels.enabled = false;
					tab_commands.enabled = false; 
					tab_specials.enabled = false;
					tab_xml.enabled = false; tabnav_buttons.selectedIndex = 0;
					   
					
					buildDatagrid(); 
					ArraySwapfromCrunch();
					
					change_filtermacro_persistent_crunch(event);
					
					refreshButton(event);
 					correctWidth(event);
					    
					
    		 	}
		
			 	
				/*  Set the Tab Navigation button to 'Preferences' */
				tabnav_buttons.selectedIndex = 0;
				tabnav_buttons.addEventListener(MouseEvent.MOUSE_WHEEL,handleMouseWheel);
				
        }         

[Embed(source='image/Lightning3.png')]
private var confirmIcon:Class;
        		[Bindable]
				private var scroll_loc:int = 0;
				private function handleMouseWheel(event:MouseEvent):void{
					
					if (event.delta >= 0){
						if (tabnav_buttons.selectedIndex != 0){
							tabnav_buttons.selectedIndex = tabnav_buttons.selectedIndex - 1;
						}
					} else {  
						if (tabnav_buttons.selectedIndex <= 5){
							
							tabnav_buttons.selectedIndex = tabnav_buttons.selectedIndex + 1;
						}	
					} 
					
					
					
				}       

				private function ribbonMouseOver(event:MouseEvent):void{
					
					mousehovering(event,'Ribbon','BUTTON');
					
				}
				private function ribbonMouseOut(event:MouseEvent):void{
					
					stopHoverTimer();
					
				}


			private function handlerViewStack(event:Event):void{
				Alert.show(event.currentTarget.id);
			}
        
        private function ArraySwapfromCrunch():void{
			 tdObjectCollection = new ArrayCollection();
 					for( var i:int = 0; i < crunch_Array1.length; i++ ){
						var obj:Object = new Object();	
						for (var ix:int=0;ix< _xlcColumn.length; ix++)  { 
							var datafield:String = (_xlcColumn[ix]["dataField"]).toString();
								obj[datafield] = crunch_Array1[i][datafield];
						}
					tdObjectCollection.addItem(obj);
					}
 			 Array1 = new ArrayCollection();
 					for( var i2:int = 0; i2 < crunch_Array1.length; i2++ ){x
						var obj2:Object = new Object();	
						for (var ix2:int=0;ix2< _xlcColumn.length; ix2++)  { 
							var datafield2:String = (_xlcColumn[ix2]["dataField"]).toString();
								obj2[datafield2] = crunch_Array1[i2][datafield2];
						}
					Array1.addItem(obj2);
					}
 		}
		private function ArraySwapfromPivot():void{
			tdObjectCollection = new ArrayCollection();
			for( var i:int = 0; i < pivot_Array1.length; i++ ){
				var obj:Object = new Object();	
				for (var ix:int=0;ix< _xlcColumn.length; ix++)  { 
					var datafield:String = (_xlcColumn[ix]["dataField"]).toString();
					obj[datafield] = pivot_Array1[i][datafield];
				}
				tdObjectCollection.addItem(obj);
			}
			Array1 = new ArrayCollection();
			for( var i2:int = 0; i2 < pivot_Array1.length; i2++ ){x
				var obj2:Object = new Object();	
				for (var ix2:int=0;ix2< _xlcColumn.length; ix2++)  { 
					var datafield2:String = (_xlcColumn[ix2]["dataField"]).toString();
					obj2[datafield2] = pivot_Array1[i2][datafield2];
				}
				Array1.addItem(obj2);
			}
		}
		private function Workflow_func(event:Event):void{
			// Add button Workflows to Command Button
			var hbox_special2:HBox = new HBox;
			var lbl_pipe2:Label = new Label;    
			lbl_pipe2.text = "|";
			lbl_pipe2.width = 14;
			lbl_pipe2.setStyle("fontSize", "18");
			lbl_pipe2.setStyle("fontWeight", 'bold');
			lbl_pipe2.setStyle("color", '#1E555B');
			hbox_special2.addChild(lbl_pipe2);     
			hbox_special.addChild(hbox_special2);
			
			// Add the small Workflow chicklet image.  
			hbox_special2 = new HBox;							
			var image_workflowchicklet_command:ActionGridimageCommands;
			image_workflowchicklet_command = new ActionGridimageCommands; 
			image_workflowchicklet_command.width = 25;
			image_workflowchicklet_command.height = 25;
			image_workflowchicklet_command.source = "image/ico_smallchicklet_command.png";
			image_workflowchicklet_command.addEventListener("click",startWorkflow);  //set an event listener 
			hbox_special2.addChild(image_workflowchicklet_command);     
			hbox_special.addChild(hbox_special2);
			
			//							
			//							/* Start layout Command functions. */      
			hbox_special2 = new HBox;	
			var buttonNew_workflow:ActionGridlabelCommands;  
			buttonNew_workflow = new ActionGridlabelCommands; 
			buttonNew_workflow.text = "Workflows";       //set some properties
			buttonNew_workflow.addEventListener("click",startWorkflow);  //set an event listener 
			buttonNew_workflow.addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
			buttonNew_workflow.addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
			
			
			
			hbox_special2.addChild(buttonNew_workflow);        
			hbox_special.addChild(hbox_special2);

		}
        private function ddlevel1function(event:Event):void{
			
			h_footer.removeAllChildren();
        		var hbox_special_underactiongrid:HBox = new HBox;
				hbox_special_underactiongrid.width = dg.width;
				hbox_special_underactiongrid.setStyle("horizontalGap",0);
				hbox_special_underactiongrid.horizontalScrollPolicy="off"   
    			var buttonAccess:HighViewButton;
    				buttonAccess = new HighViewButton;                         //create the button
    				buttonAccess.label = "Access";      						//set some properties
    				buttonAccess.doc_id = "1065";
    				buttonAccess.addEventListener("click",DDAcess);  			//set an event listener
    				buttonAccess.addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
					buttonAccess.addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
					hbox_special_underactiongrid.addChild(buttonAccess); 
    			var buttonDeny:HighViewButton;
    				buttonDeny = new HighViewButton;                         //create the button
    				buttonDeny.label = "Deny";      						 //set some properties 
    				buttonDeny.doc_id = "1066";
    				buttonDeny.addEventListener("click",DDDeny);  			//set an event listener
    				buttonDeny.addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
					buttonDeny.addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
					hbox_special_underactiongrid.addChild(buttonDeny); 
    			var buttonSubmit:HighViewButton;
    				buttonSubmit = new HighViewButton;                          //create the button
    				buttonSubmit.label = "Submit";      						//set some properties
    				buttonSubmit.doc_id = "1067";
    				buttonSubmit.addEventListener("click",OpSecSendXML);        //set an event listener
    				buttonSubmit.addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
					buttonSubmit.addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
					hbox_special_underactiongrid.addChild(buttonSubmit);
					
					h_footer.addChild(hbox_special_underactiongrid);
				
				 
        }
         private function OperatorAssignment(event:Event):void{
        		var hbox_special:HBox = new HBox;
    				hbox_special.width = dg.width;
    				hbox_special.setStyle("horizontalGap",0);
    		 		hbox_special.horizontalScrollPolicy="off"   
    			var buttonAccess:HighViewButton;
    				buttonAccess = new HighViewButton;                         //create the button
    				buttonAccess.id = "assignops";
    				buttonAccess.label = "Assign Ops";      						//set some properties
    				buttonAccess.doc_id = "1604";
    				buttonAccess.addEventListener("click",AssignOpsSubmit);  			//set an event listener
    				buttonAccess.addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
					buttonAccess.addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
    		 		hbox_special.addChild(buttonAccess); 
    			var buttonDeny:HighViewButton;
    				buttonDeny = new HighViewButton;                         //create the button
    				buttonDeny.id = "deassignops";
    				buttonDeny.label = "Deassign Ops";      						 //set some properties
    				buttonDeny.doc_id = "1606";
    				buttonDeny.addEventListener("click",DeAssignOpsSubmit);  			//set an event listener
    				buttonDeny.addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
					buttonDeny.addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
    		 		hbox_special.addChild(buttonDeny); 
    			panel.addChild(hbox_special);
        }
        	public function OpSecSendXML(event:Event):void{
					dd_xml_str = new String;
					var root_head:String = '<' + mainBoard + '>';
					var root_tail:String = '</' + mainBoard + '>';
					var Ops_operator:String  = '<operator>' + dd_columnone + '</operator>';
					var data_head:String = '<data>';
					var data_tail:String = '</data>';
					
					dd_xml_str = dd_xml_str + root_head;
					dd_xml_str = dd_xml_str + Ops_operator;
				
						for (var i:int=0;i<Array1.length;i++){
         			
         						// As per Christine to remove the "Y" filter but instead pass everything: "Y", "N", "U"
         						//if 	((Array1[i][_xlcColumn[_xlcColumn.length-2]["dataField"]] == 'Y')||(Array1[i][_xlcColumn[_xlcColumn.length-2]["dataField"]] == 'N')){
							if 	((Array1[i][_xlcColumn[0]["dataField"]] == 'Y')||(Array1[i][_xlcColumn[0]["dataField"]] == 'N')){ 	
         								dd_xml_str = dd_xml_str + data_head;
         								for (var j:int=0;j<((_xlcColumn.length) - 1);j++){
         									dd_xml_str = dd_xml_str + '<' + _xlcColumn[j]["dataField"] + '>';
         									dd_xml_str = dd_xml_str + Array1[i][_xlcColumn[j]["dataField"]];
         									dd_xml_str = dd_xml_str + '</' + _xlcColumn[j]["dataField"] + '>';
         								}
         								
         								dd_xml_str = dd_xml_str + data_tail;
         								
         						}		
      					}
      				dd_xml_str = dd_xml_str + root_tail;
      				finalxmlResults = 	new XML(dd_xml_str);
      				xmlResults = new XML("<ezware_request>" + 
     				 "<action>refreshData</action>" + 
					 "<company>" + my_c_code1 + "</company>" +
     				 "<sid>" + my_sid + "</sid>" + 
     				 "<parameters>" +  "REFRESH,UPD_" + mainBoard + "," + finalxmlResults  + "</parameters>" + 
     				 "<systemAndJob></systemAndJob>" + 
     				 "<version>1</version>" +  
     				 "</ezware_request>");
      				SubmitDDOpsSec.send(); 
      					removeMe_popcompsys_access(event);  
         		}
       private function profiledatagridListROver(event:Event):void{
       	
		mousehovering(event,event.currentTarget.label,'BUTTON');
		
	   }
	   private function profiledatagridListROut(event:Event):void{
		   	 stopHoverTimer();
	}
        
        private function createAndMaintain(event:Event):void{
			
			h_footer.removeAllChildren();
			//panel = new Panel;  
			   //  panel.removeChild(buttonCompanySystemAccess);
				// panel.removeChild(buttonMenuItemAccess);
			 
        		var hbox_special:HBox = new HBox;
    		 	hbox_special.width = dg.width;
    			hbox_special.setStyle("horizontalGap",0);
    		 	hbox_special.horizontalScrollPolicy="off"   
    		   var buttonNew:HighViewButton;
    			var companysesacess:String;
				     
			   buttonNew = new HighViewButton;                         //create the button
			   if (ag_application_entry == 'ml'){
				   companysesacess = 'Campus Access'   
				   
			   } else {
				   companysesacess = 'Company System Access'
			   } 
			     
			  
    		 	 if (_xlcTitle == "Operator Groups"){
					           
					          
					 var buttonCompanySystemAccess:HighViewButton;
					 buttonCompanySystemAccess = new HighViewButton;                         //create the button
					 buttonCompanySystemAccess.label = companysesacess;      //set some properties    
					 buttonCompanySystemAccess.doc_id = "1063";  // set document id for hover help
					 buttonCompanySystemAccess.addEventListener("click",launch_compsys_access);  //set an event listener
					 buttonCompanySystemAccess.addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
					 buttonCompanySystemAccess.addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
					 hbox_special.addChild(buttonCompanySystemAccess);	
					    
					 var buttonMenuItemAccess:HighViewButton;
					 buttonMenuItemAccess = new HighViewButton;                         //create the button
					 buttonMenuItemAccess.label = "Menu Item Access";      //set some properties
					 buttonMenuItemAccess.doc_id = "1064";
					 buttonMenuItemAccess.addEventListener("click",launch_ssysjob_access);  //set an event listener
					 buttonMenuItemAccess.addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
					 buttonMenuItemAccess.addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
					 hbox_special.addChild(buttonMenuItemAccess);	
					 
					        
    		   		var buttonCopytoGroup:HighViewButton;
    					buttonCopytoGroup = new HighViewButton;                         //create the button
    					buttonCopytoGroup.label = "Copy Menu Items to Another Group";      //set some properties
    					buttonCopytoGroup.doc_id = "1062";
    					buttonCopytoGroup.addEventListener("click",validate_copy_group);  //set an event listener
    		 			buttonCopytoGroup.addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
						buttonCopytoGroup.addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
    		 			hbox_special.addChild(buttonCopytoGroup);	
    		 	
    		 	}	
    		 
    		 	if (_xlcTitle == "Operators"){
    		   		var buttonChangeOperationGroup:HighViewButton;
    					buttonChangeOperationGroup = new HighViewButton;                         //create the button
    					buttonChangeOperationGroup.label = "Assign to Operator Group";      //set some properties
    					buttonChangeOperationGroup.doc_id = "1062";
    					buttonChangeOperationGroup.addEventListener("click",launch_reassign_group);  //set an event listener
    		 			buttonChangeOperationGroup.addEventListener( MouseEvent.ROLL_OVER,profiledatagridListROver);
						buttonChangeOperationGroup.addEventListener( MouseEvent.ROLL_OUT,profiledatagridListROut);
    		 			hbox_special.addChild(buttonChangeOperationGroup);	
    		 	
    		 	}		
				
				h_footer.addChild(hbox_special);
    	
        
        }    
             
        private function newEntry_old(event:Event):void{
        	Alert.show(_xlcColumn.length.toString());
        }    

		public var popentryinterface:EntryInterface;	
 		private function launchEntry(event:Event):void {
                if(dg.selectedItems.length > 1){
                	AlertMessageShow("Please select only 1 record");
                }
            
            	if(dg.selectedItems.length == 1){
            			dd_reqParms = "REFRESH,COMMAND,"+ _xlcActionCommand +"," + mainBoard +","+ dg.selectedItem[_xlcColumn[0]["dataField"]];
            			navigateToJobProgram.send()
            
                }
                if(dg.selectedItems.length < 1){
            			dd_reqParms = "REFRESH,COMMAND,"+ _xlcActionCommand +"," + mainBoard;
            			navigateToJobProgram.send()
                }
   		 }




        private function editEntry_old(event:Event):void{
        	Alert.show("Edit Entry");
        } 
        
        
        public var popcompsys_access:DrillDown;	
        private function launch_compsys_access(event:Event):void {
        	var str_namecode_profile:String = new String;
        	var str_namecode_profile_description:String = new String;
         
            	if (dg.selectedItems.length > 1){
            		AlertMessageShow("You can only select one record.");
            		return;
            	}
            	if (dg.selectedItems.length == 0){
            		AlertMessageShow("Please select a record.");
            		return;
            	}
            	// as per christine.  I will hardcode the mainBoard name for now to distinguish the column to be passed.
            	
				if (mainBoard == "OPERATOR"){            	
            		if ((dg.selectedItem[(_xlcColumn[1]["dataField"])]) == null || (dg.selectedItem[(_xlcColumn[1]["dataField"])]) == '')    {
            	  		str_namecode_profile = dg.selectedItem[(_xlcColumn[0]["dataField"]).toString()];
            			launch_Drilldown_compsys(event,str_namecode_profile, 'COMPSYS','');
            		}             	 
            		//Check for Operator Group.  If the Operator Code has an Operator Group,
            		// then pass the Operator Group. Else, pass the Operator Code.
            		if ((dg.selectedItem[(_xlcColumn[1]["dataField"]).toString()]).length > 0){
            			str_namecode_profile = (dg.selectedItem[(_xlcColumn[1]["dataField"]).toString()])
            			launch_Drilldown_compsys(event,str_namecode_profile, 'COMPSYS',''); 
            		}
				} else {
						str_namecode_profile = (dg.selectedItem[(_xlcColumn[0]["dataField"]).toString()])
						str_namecode_profile_description = (dg.selectedItem[(_xlcColumn[1]["dataField"]).toString()])
            			launch_Drilldown_compsys(event,str_namecode_profile, 'COMPSYS',str_namecode_profile_description);
				}     
   		}
   		
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
				
					popcompsys_access.dd_application_entry = ag_application_entry;
   		 }
   		
   		public var popreassign_group:ReassignGroupOperator;	
   		private function launch_reassign_group(event:Event):void{
   				if (dg.selectedItems.length == 0){
            		AlertMessageShow("Please select a record.");
            		return;
            	}
   					popreassign_group = ReassignGroupOperator(
   		 		 	PopUpManager.createPopUp(this, ReassignGroupOperator, true));
   		 		 	popreassign_group.dd_compcode = my_c_code1;
   		 		 	popreassign_group["btn_submit"].addEventListener("click",  submitOperGroup);
   		}
        
        private function submitOperGroup(event:Event):void {
        	
        	if (popreassign_group.cb_operatorgroup.selectedIndex == -1){
					AlertMessageShow("Please select a group.");
					return;
            }
            PopUpManager.removePopUp(popreassign_group);
                var numItems:int = dg.selectedItems.length;
            	var dg_key:String = new String; 
            	var final_dg_key:String = "";
            	if (numItems == 1){
            		final_dg_key =  dg.selectedItems[ 0 ][_xlcColumn[0]["dataField"]]  + ";" ;
            	} else if (numItems > 1){ 
            		for( var i:int = 0; i < numItems; i++ )
					{
						dg_key =  dg.selectedItems[ i ][_xlcColumn[0]["dataField"]];
						c_utils.trim(dg_key);
						final_dg_key = final_dg_key + dg_key + ";" ;
					}
				}
				finalvarOprGrp = popreassign_group.cb_operatorgroup.selectedLabel + ";" + final_dg_key
				SubmitOprGroup.send(); 
        }
        private function launch_ssysjob_access(event:Event):void {
        	var str_namecode_profile:String = new String;
        	var str_namecode_profile_description:String = new String;
            	if (dg.selectedItems.length > 1){
            		AlertMessageShow("You can only select one record.");
            		return;
            	}
            	if (dg.selectedItems.length == 0){
            		AlertMessageShow("Please select a record.");
            		return;
            	}
            	if (mainBoard == "OPERATOR"){            	
            		
            		if ((dg.selectedItem[(_xlcColumn[1]["dataField"])]) == null || (dg.selectedItem[(_xlcColumn[1]["dataField"])]) == '')    {
            	  		str_namecode_profile = dg.selectedItem[(_xlcColumn[0]["dataField"]).toString()];
            			launch_Drilldown_compsys(event,str_namecode_profile, 'SSYSJOB','');
            		}
            		//Check for Operator Group.  If the Operator Code has an Operator Group,
            		// then pass the Operator Group. Else, pass the Operator Code.
            		if ((dg.selectedItem[(_xlcColumn[1]["dataField"]).toString()]).length > 0){
            			str_namecode_profile = (dg.selectedItem[(_xlcColumn[1]["dataField"]).toString()])
            			launch_Drilldown_compsys(event,str_namecode_profile, 'SSYSJOB','');
            		}
            	} else {
						str_namecode_profile = (dg.selectedItem[(_xlcColumn[0]["dataField"]).toString()])
						str_namecode_profile_description = (dg.selectedItem[(_xlcColumn[1]["dataField"]).toString()])
            			launch_Drilldown_compsys(event,str_namecode_profile, 'SSYSJOB',str_namecode_profile_description);
            	
				} 
   		}        
          
		public var popwait:Ergo;
        private function launchErgo():void {
        	popwait = Ergo(PopUpManager.createPopUp(this, Ergo, false));
                 
        }
        private function launchErgo_nofloat():void {
        	popwait = Ergo(PopUpManager.createPopUp(this, Ergo, true));
                 
        }
        
		private function textField_link(evt:TextEvent):void {
                Alert.show("In Process.", evt.text);
        }

		private function sortNumeric(obj1:Object, obj2:Object):int {
		
		
			var value1:Number = (obj1[clickedColumn] == "" || obj1[clickedColumn] == null) ? null : new Number(obj1[clickedColumn]);
			var value2:Number = (obj2[clickedColumn] == "" || obj2[clickedColumn] == null) ? null : new Number(obj2[clickedColumn]);

			if (value1 < value2) {
				return -1;
			} else if (value1 > value2) {
				return 1;
			} else {
				return 0;
			}
			
			
		}




	 private function numeric_labelFunc(item:Object, column:DataGridColumn):String 
	 {
               return numberFormatter.format(item[column.dataField]);
     }
     private function string_labelFunc(item:Object, column:DataGridColumn):String
	 {
     			return "";
     }
	  
 		private function buildDatagrid():void{
 		    var analyzeColumnDef:Object;
		    var numericColumnDef:Object;
		    var nonnumericColumnDef:Object;
 			var oColumnDef:Object;
			var aColumnsNew:Array = [];
		
			
			 
		 	for (var i:int=0;i<_xlcColumn.length;i++)  { 
			 var columnId:String = (_xlcColumn[i]["columnId"]);
			 var title_header:String = (_xlcColumn[i]["title_header"]);
			 var width:String = (_xlcColumn[i]["width"]);
			 var datafield:String = (_xlcColumn[i]["dataField"]).toString();
			 var datatype:String = (_xlcColumn[i]["datatype"]).toString();
			 var wordwrap:Boolean = (_xlcColumn[i]["wordwrap"]);
			 var analyzeby:String = (_xlcColumn[i]["analyzeby"]);
			 var drilldown:String = (_xlcColumn[i]["drilldown"])
			 var edocs:String = (_xlcColumn[i]["edocs"]);
			 var externallink:String = (_xlcColumn[i]["externallink"]);
			 var extensible_field2:String = (_xlcColumn[i]["extensible"]);	  
				       
				
				
				dgc = new AdvancedDataGridColumn();
				dgc.dataField = datafield;  
				dgc.headerText = title_header.toString();
				dgc.wordWrap = wordwrap;
				
			
				var int_width:int = parseInt(width);
				if ((flash.system.Capabilities.screenResolutionX < 1680) && (flash.system.Capabilities.screenResolutionY < 1050)){
					int_width = (int_width - 20);
				
				}
				dgc.width = int_width;
				//  Set the First column color to  blue.
				if (_xlcColumn[i]["dataField"] == _xlcColumn[0]["dataField"]){
					dgc.setStyle('color','#0000FF');
				} 
				if ((datatype == "S")||(datatype == "D")){
					
				//	dgc.labelFunction = string_labelFunc;
				//	dgc.sortCompareFunction = sortNumeric;  
				}         
				   
				//  This is for Charting Dialog. This is just a test.///////
				
				if (datatype == "N"){ 
					 
					numericColumnDef = new Object;
					numericColumnDef.headerText = (_xlcColumn[i]["dataField"]).toString();
					numericColumnDef.title_header = (_xlcColumn[i]["title_header"]);
					numericColumns.addItem(numericColumnDef);
				}    
				if (datatype == "N"){
					
					 
					dgc.sortCompareFunction = sortNumeric;
					
					dgc.setStyle("textAlign", "right");
					dgc.setStyle('color','green');
					
				}       
				
				if (extensible_field2 == "yes"){  
					dgc.setStyle("fontStyle","italic")              
					dgc.setStyle('color','#CC3311');      
				}
				
				if (drilldown == "yes" || edocs == "yes" || externallink == "yes"){  
					
					dgc.setStyle('color','purple');       
					dgc.setStyle('textDecoration','underline');
					
					
				
				}
				aColumnsNew.push(dgc);
			
			}
				 
				dg.columns = aColumnsNew;   
				
				
				
				
				if (drilldown_flag == "Y"){  
					img_backall.source = "image/ico_backall_red.png";
					img_back1.source = "image/ico_back1_red.png";      
				   
					panel.title = "Hyperlink - From: " + previous_drilldown + " - To: " + _xlcTitle;
					
				}
				
		
				detectScreenResolutionforActionGrid();       
				//Alert.show("final response");
				/*
				reqParms = "REFRESH,RENDITION," + r_passed_mainboard + "," + r_user_code + "," + r_file_modify;
				retrievemodifyrendition.send();
			*/
		}
		


		public function handleDragOver(event:DragEvent):void{
				var dropIndex:int        = dg.calculateDropIndex(event);
				var rowsDisplayed:Number = dg.rowCount;
				var topvisibleIndex:int  = dg.verticalScrollPosition;
				var botvisibleIndex:int  = topvisibleIndex + rowsDisplayed;

			
				if ( dropIndex <= topvisibleIndex) {
    					dg.verticalScrollPosition = Math.max( dg.verticalScrollPosition- 1, 0 );
				} else if( dropIndex >= botvisibleIndex - 1 ){
					dg.verticalScrollPosition += 1;
				}
		}		
		
	
     	   private var myFormatter:NumberFormatter=new NumberFormatter();
     	private function numberLabelFunction(data:Object, column:Object):String {
				myFormatter.precision=2;
				return myFormatter.format(data[column.dataField]);
				
		}

		private function isManager(itemA:Object, itemB:Object):int {
   			 if (itemA[g_datafield] > itemB[g_datafield]) {
        			return -1;
    			} else if (itemA[g_datafield] < itemB[g_datafield]) {
        			return 1;
    		} else {
        			return 0;
    		}
    		
    		return 0;
		}
		private function sortNumeric1(obj1:Object, obj2:Object):int {
			var value1:Number = (obj1[g_datafield] == "" || obj1[g_datafield] == null) ? null : new Number(obj1[g_datafield]);
			var value2:Number = (obj2[g_datafield] == "" || obj2[g_datafield] == null) ? null : new Number(obj2[g_datafield]);
			if (value1 < value2) {
				return -1;
			} else if (value1 > value2) {
				return 1;
			} else {
				return 0;
			}
		}
		private var cnt:int = 0;
		private function catchRenderer(evt:Event):void{
			cnt = cnt + 1;
			
			if (globalstringforrender == false){
					aFormFields = [];
					
			  correctWidth(evt);
			}
			globalstringforrender = true;
			
			
		}           
	
		public var newObject:CustomTextInput;
		
		private function correctWidth(evt:Event):void{
			
			hb.removeAllChildren();
			//Alert.show(dg.horizontalScrollPosition.toString()); 
			if (dg.horizontalScrollPosition != 0){    
				for (var a:int=0;a<dg.lockedColumnCount;a++){
					newObject = new CustomTextInput();
					
					newObject.custom_id = _xlcColumn[a]["columnId"];
				
					newObject.data_type = _xlcColumn[a]["datatype"];
					
					newObject.data_field = _xlcColumn[a]["dataField"];
					
					newObject.width = dg.columns[a].width;
					
				
				
						newObject.addEventListener( "keyDown",event_list);
						
					
						newObject.addEventListener( MouseEvent.CLICK,click_event_list);
						addObjectToArray(newObject);
						hb.addChild(newObject);
 				}
			       
			}
			var dg_hp:int = dg.horizontalScrollPosition;
			if (dg.horizontalScrollPosition != 0){
			
				
				dg_hp = dg_hp + dg.lockedColumnCount;
				
			}
			for (var i:int=(dg_hp);i<_xlcColumn.length;i++)  {
				
				newObject = new CustomTextInput(); 
				newObject.custom_id = _xlcColumn[i]["columnId"];
				newObject.data_type = _xlcColumn[i]["datatype"];
				newObject.data_field = _xlcColumn[i]["dataField"];
				newObject.width = dg.columns[i].width;
		
		  
				newObject.addEventListener( "keyDown",event_list);
			
				newObject.addEventListener( MouseEvent.CLICK,click_event_list);
			
				
				addObjectToArray(newObject);
			
				hb.addChild(newObject);
 			}
			
			addTotal(evt);
			return;
		}
		private var colxlc:int= new int;
		private function runColumnFilterHoverHelp(event:Event):void{
			mousehovering(event, "Generic", "COLUMN_FILTER");
		}
		
		private function click_event_list(e:Event):void{
						colxlc = parseInt(e.currentTarget.custom_id);
						custom_id = e.currentTarget.custom_id;
                		custom_datatype  = e.currentTarget.data_type;
                		custom_datafield = e.currentTarget.data_field;
			if (e.currentTarget.data_type.toString() == "D"){
				removeMe(e);
				launchFilterDateRange(e);
			}
			if (e.currentTarget.data_type.toString() != "D"){ 
				launchMoreInfo(e);
				pop1.btn_keep.drawFocus(true);
 			}
 			e.currentTarget.setFocus();
 		}
		
		
		
		
		private function DashSubmit(event :Event):void{
				custom_text = "-";
   				action_command = "keep";
   				removeMe_fdr(event);
   				FilterHistoryLog(event);	
   		}
   		private function SlashSubmit(event :Event):void{
				custom_text = "/";
   				action_command = "keep";
   				removeMe_fdr(event);
   				FilterHistoryLog(event);	
   		} 
   		private function FilterHistoryLog(event:Event):void{
                		var obj:Object = new Object();
                					obj = new Object();
                					    obj.type = custom_datatype;
										obj.value = custom_text;
										obj.column = custom_datafield; 
                						obj.action =  action_command;
										obj.view = "AH";
										ArrayFilterInsert.addItem(obj);
									if (action_command!= "add"){
										//refreshButton(event);
										ActionEvent(event); 
									}
									if (action_command == "add"){
										addFunction(event);
									}
                	CheckSortAH(event);
                	addTotal(event);
              		help_flag = false;
   		}
	
	
	
		private function fdr_esckey(event :KeyboardEvent):void{
					
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_fdr(event);
					}
   			}


		public function getDate(stringvar:String):String{
			var ret_str:String = "nothing";
			for (var x:int=0;x<DateValueArr.length;x++) {
			
			  if (stringvar == DateValueArr[x]['code']){
			     ret_str = DateValueArr[x]['date']
			  		break;
			  }
			}
			return ret_str
			
		}

		private function FilterKeepSubmit(event :Event):void{
				action_command = "keep";
				
				var from_int:int = (popfdr.from_dateField.text).length;
				
				var to_int:int = (popfdr.to_dateField.text).length;
				
				if ((from_int > 0)&&(to_int == 0)){ 
						custom_text = ">= " + popfdr.from_dateField.text;
						removeMe_fdr(event);
   						FilterHistoryLog(event);
				}
				if ((from_int > 0)&& (to_int > 0)){
					var str_datefrom:String  = getDate(popfdr.from_dateField.text);
					var str_dateto:String  = getDate(popfdr.to_dateField.text);
					
					
					if (str_datefrom == "nothing"){
						str_datefrom = popfdr.from_dateField.text;
					}
					
					if (str_dateto == "nothing"){
						str_dateto = popfdr.to_dateField.text;
					}
					
					/*
					if (popfdr.from_dateField.text > popfdr.to_dateField.text){
						AlertMessageShow("From Date should not be greater than To Date.");
						return;
					}
					*/
					
					if (str_datefrom > str_dateto){
						AlertMessageShow("From Date should not be greater than To Date.");
						return;
					}
						
					
						custom_text = ">= " + popfdr.from_dateField.text + " + " + "<= " + popfdr.to_dateField.text;
						removeMe_fdr(event);
   						FilterHistoryLog(event);
				}
				if ((from_int == 0)&&(to_int > 0)){
						AlertMessageShow("Please Enter From Date Field");
						return;
				}
				if ((from_int == 0)&&(to_int == 0)){
						AlertMessageShow("Please Enter From Date Field.");
						return;
				}
				
   		}
   		private function FilterDiscardSubmit(event :Event):void{
				action_command = "discard";
				var from_int:int = (popfdr.from_dateField.text).length;
				var to_int:int = (popfdr.to_dateField.text).length;
				
				if ((from_int > 0)&&(to_int == 0)){ 
						custom_text = ">= " + popfdr.from_dateField.text;
						removeMe_fdr(event);
   						FilterHistoryLog(event);
				}
				if ((from_int > 0)&& (to_int > 0)){
					
					if (popfdr.from_dateField.text > popfdr.to_dateField.text){
						AlertMessageShow("From Date should not be greater than To Date.");
						return;
					}
						custom_text = ">= " + popfdr.from_dateField.text + " + " + "<= " + popfdr.to_dateField.text;
						removeMe_fdr(event);
   						FilterHistoryLog(event);
				}
				if ((from_int == 0)&&(to_int > 0)){
						AlertMessageShow("Please Enter From Date Field.");
						return;
				}
				if ((from_int == 0)&&(to_int == 0)){
						AlertMessageShow("Please Enter From Date Field");
						return;
				}
				
   		}
   		
   		  private function FilterAddSubmit(event :Event):void{
				action_command = "add";
				var from_int:int = (popfdr.from_dateField.text).length;
				var to_int:int = (popfdr.to_dateField.text).length;
				
				if ((from_int > 0)&&(to_int == 0)){ 
						custom_text = ">= " + popfdr.from_dateField.text;
						removeMe_fdr(event);
   						FilterHistoryLog(event);
				}
				if ((from_int > 0)&& (to_int > 0)){
					
					if (popfdr.from_dateField.text > popfdr.to_dateField.text){
						AlertMessageShow("From Date should not be greater than To Date.");
						return;
					}
					
						custom_text = ">= " + popfdr.from_dateField.text + " + " + "<= " + popfdr.to_dateField.text;
						removeMe_fdr(event);
   						FilterHistoryLog(event); 
				}
				if ((from_int == 0)&&(to_int > 0)){
						AlertMessageShow("Please Enter From Date Field.");
						return;
				}
				if ((from_int == 0)&&(to_int == 0)){
						AlertMessageShow("Please Enter From Date Field.");
						return;
				}
				
   		}
		
		public var popfdr:FilterDateRange;	     
            private function launchFilterDateRange(event:Event):void {
            	
               	popfdr = FilterDateRange(
                PopUpManager.createPopUp(this, FilterDateRange, true));
				popfdr.dateRange = DateValueArr;
                popfdr["btn_keep"].addEventListener("click",  FilterKeepSubmit); 
                popfdr["btn_keep"].addEventListener(KeyboardEvent.KEY_DOWN,  fdr_esckey); 
                popfdr["btn_discard"].addEventListener("click",  FilterDiscardSubmit); 
                popfdr["btn_discard"].addEventListener(KeyboardEvent.KEY_DOWN,  fdr_esckey); 
				popfdr["btn_add"].addEventListener("click",  FilterAddSubmit); 
                popfdr["btn_add"].addEventListener(KeyboardEvent.KEY_DOWN,  fdr_esckey); 
                popfdr["btn_slash"].addEventListener("click",  SlashSubmit); 
                popfdr["btn_slash"].addEventListener(KeyboardEvent.KEY_DOWN,  fdr_esckey); 
                popfdr["btn_dash"].addEventListener("click",  DashSubmit); 
                popfdr["btn_dash"].addEventListener(KeyboardEvent.KEY_DOWN,  fdr_esckey); 
                popfdr["from_dateField"].addEventListener(KeyboardEvent.KEY_DOWN,  fdr_esckey); 
                popfdr["to_dateField"].addEventListener(KeyboardEvent.KEY_DOWN,  fdr_esckey); 
				popfdr["btn_multifilter"].addEventListener("click",  help_datemultifilter); 
				popfdr["btn_multifilter"].addEventListener(KeyboardEvent.KEY_DOWN,  fdr_esckey); 
				// popfdr["btn_cancel"].addEventListener(KeyboardEvent.KEY_DOWN,  fdr_esckey); 
				 
				
				
				popfdr["lb_filteroperators"].addEventListener("click", launchFilterOperators);
				
				popfdr["lb_filteroperators"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				popfdr["lb_filteroperators"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
                
   		    }
		
		
		private function help_datemultifilter(event:Event):void {
			launchMultipleFilter(event);
			removeMe_fdr(event);    
		}



		private function addTotal(evt:Event):void{
		
        		hb_total.removeAllChildren();
       
				
        	if (dg.horizontalScrollPosition != 0){
				for (var a:int=0;a<dg.lockedColumnCount;a++){
									var newObject2:CustomTextInput2 = new CustomTextInput2();
									
 				newObject2.custom_id2 = _xlcColumn[a]["columnId"];
				newObject2.data_type2 = _xlcColumn[a]["datatype"];
				newObject2.data_field2 = _xlcColumn[a]["dataField"];
				newObject2.width = dg.columns[a].width;
				newObject2.editable=false;   
				var s_total:String = new String;
				var vtotal:Number;
   				var total_:Number = 0;
   				var str_tcv:String = _xlcColumn[a]["tcv"];
   				var str_tcv_array:Array = [];
   				var n_one:Number = 0;
				
				
				if ((_xlcColumn[a]["datatype"] == "N")&&(str_tcv == "-")){
		
    					for (var ib:int=0;ib<Array2.length;ib++)  {
    						vtotal = Array2[ib][newObject2.data_field2];
    						total_= total_+ vtotal;
 						}
				  	s_total = total_.toString();	 
							  	
				}     
				
				
				else if ((_xlcColumn[a]["datatype"] == "N")&&(str_tcv != "-")){
					str_tcv_array = str_tcv.split(";");	
					for (var x:int=0;x<str_tcv_array.length;x++)  {
						
						
						
						var someNumber:Number = x;
						var evenOrOdd:String;
						var ret_tot:Number;
						if (someNumber%2 != 0) {
							
							
							if ((str_tcv_array[x] == "*") || (str_tcv_array[x] == "/") || (str_tcv_array[x] == "+") || (str_tcv_array[x] == "-")){
								n_one = computeWithOperator(n_one, str_tcv_array[x], str_tcv_array[x+1]);
							} 
							
						} else {
				
								if (x == 0){
									ret_tot = addTotalNumeric(str_tcv_array[x]);
									if (ret_tot.toString() == 'NaN'){
										ret_tot = str_tcv_array[x];
									}								
									n_one = ret_tot;
								}
						}
					}
					n_one = Math.round((n_one)*100)/100;
					s_total = n_one.toString();
				}
				
				newObject2.text = numberFormatter.format(s_total);
				newObject2.setStyle("textAlign", "right");
			 	newObject2.setStyle('color','green');
				hb_total.addChild(newObject2);     
 				}
			
			}
			var dg_hp2:int = dg.horizontalScrollPosition;
			if (dg.horizontalScrollPosition != 0){
			
				
				dg_hp2 = dg_hp2 + dg.lockedColumnCount;
			}
			
        	
        	
        	
        	
			for (var i:int=dg_hp2;i<dg.columns.length;i++)  {
				var newObject3:CustomTextInput2 = new CustomTextInput2();
 				newObject3.custom_id2 = _xlcColumn[i]["columnId"];
				newObject3.data_type2 = _xlcColumn[i]["datatype"];
				newObject3.data_field2 = _xlcColumn[i]["dataField"];
				newObject3.width = dg.columns[i].width;
				newObject3.editable=false;
				var s_total1:String = new String;
				var vtotal1:Number;
   				var total_1:Number = 0;
   				var str_tcv:String = _xlcColumn[i]["tcv"];
   				var str_tcv_array:Array = [];
   				var n_one:Number = 0;
				
				if ((_xlcColumn[i]["datatype"] == "N")&&(str_tcv == "-")){
					
    					for (var ic:int=0;ic<Array2.length;ic++)  {
    						vtotal1 = Number(Array2[ic][newObject3.data_field2]);
    						total_1= total_1+ vtotal1;
						
 						}
						
				  	s_total1 = total_1.toString();
					
				  	     
				}
				
				
				else if ((_xlcColumn[i]["datatype"] == "N")&&(str_tcv != "-")){
					str_tcv_array = str_tcv.split(";");	
					for (var x:int=0;x<str_tcv_array.length;x++)  {
						// Check divisibility by 2;    
						
						
						var someNumber:Number = x;
						var evenOrOdd:String;
						var ret_tot:Number;
						if (someNumber%2 != 0) {
							
							
							if ((str_tcv_array[x] == "*") || (str_tcv_array[x] == "/") || (str_tcv_array[x] == "+") || (str_tcv_array[x] == "-")){
								n_one = computeWithOperator(n_one, str_tcv_array[x], str_tcv_array[x+1]);
							} 
							
						} else {
				
								if (x == 0){
									ret_tot = addTotalNumeric(str_tcv_array[x]);
									if (ret_tot.toString() == 'NaN'){
										ret_tot = str_tcv_array[x];
									}								
									n_one = ret_tot;
								}
						}
					}
					n_one = Math.round((n_one)*100)/100;
					
					s_total1 = n_one.toString();
				}
				
				newObject3.text = numberFormatter.format(s_total1);
				newObject3.setStyle("textAlign", "right");
				newObject3.setStyle('color','green');
				
			
					hb_total.addChild(newObject3);
				   
			}
			
		
			 
			for( var a:int = 0; a < aPanel.length; a++ ){
				if (aPanel[a]["extensible"] == "yes"){
					aPanel[a].setStyle("color","#CC3311");
					aPanel[a].setStyle("borderColor","");
					aPanel[a].setStyle("fontStyle","italic")
				}
			} 
			
			
        }
        private function panelPlacingExtensible(evt:Event):void{
			for( var a:int = 0; a < aPanel.length; a++ ){
				if (a != (evt.currentTarget.index)){
					aPanel[a]["selected"] = false;
					if (aPanel[a]["extensible"] == "yes"){
						
						aPanel[a].setStyle("color","#CC3311");
						aPanel[a].setStyle("borderColor","");
						aPanel[a].setStyle("fontStyle","italic")
					} else{
						
						
						aPanel[a].setStyle("color","black");    
						aPanel[a].setStyle("borderColor","");
					}
					    
				}
				
				if (a == (evt.currentTarget.index)){
					aPanel[a]["selected"] = true;
					
					
					
					if (aPanel[a]["extensible"] == "yes"){
						
						aPanel[a].setStyle("color","#CC3311");
						aPanel[a].setStyle("borderColor","");
						aPanel[a].setStyle("fontStyle","italic")
					} else{
						
						
						aPanel[a].setStyle("color","blue");       
						aPanel[a].setStyle("borderColor", "blue");
					}
					
				}
			} 
			
		}
        private function addTotalNumeric(field:String):Number{
        	var total_:Number = 0;
        	var vtotal:Number = 0;
        	
        		for (var ib:int=0;ib<Array2.length;ib++)  {
    						vtotal = Array2[ib][field];
    						total_= total_+ vtotal;
 						}
			return total_;
        }
        private function computeWithOperator(field1:Number, ops:String, field2:String):Number{
        	var ret_tot:Number = 0;
        	var total:Number = 0;
        	
        			ret_tot = addTotalNumeric(field2);
						if (ret_tot.toString() == 'NaN'){
							ret_tot = Number(field2);
						}
					
			if (ops == '*'){
				total = field1 * ret_tot;
			}
			if (ops == '/'){
				total = field1 / ret_tot;
			}			
        	if (ops == '-'){
				total = field1 - ret_tot;
			}
			if (ops == '+'){
				total = field1 + ret_tot;
			}
			return total;
        }
 		private function addObjectToArray(formField:DisplayObject):void{
        		this.aFormFields.push(formField);
        }
 		private var help_flag:Boolean = false;
 		private function event_list(event:KeyboardEvent):void{
			
		
 			launchMoreInfo(event);
 			    if (event.keyCode == 119){
            		action_command = "keep"
            		help_flag = true;
            	}
				
            	if (event.keyCode == 120){
            		action_command = "discard"
            		help_flag = true;
            	}
            	if (event.keyCode == 13){
            		
            		help_keep(event);
            		
            		
            	}
            	if (event.keyCode == Keyboard.UP){
            		
            		pop1.btn_discard.drawFocus(true);
            		pop1.btn_discard.setFocus();
            		help_discard(event);
            		
            		
            	}
            	if (event.keyCode == Keyboard.DOWN){
            		
            		pop1.btn_add.drawFocus(true);
            		pop1.btn_add.setFocus();
            		help_add(event);
            		
            		
            	}
            	
            	if (event.keyCode == Keyboard.ESCAPE){
            		removeMe(event);
            		
            	}
            	
            	
 			if (help_flag == true){
 				history_log(event);
    		}
 		}
		private function flagger(evt:Event):void{
		
			globalstringforrender = false;
			catchRenderer(evt);
		}

	  private function totalRowsRetrieved():void{
	   			 	total_rows.text = rownumberFormatter.format((Array2.length).toString());
  	  }  		
  	   private function sumRowsRetrieved():void{
	   			 	sumofall_rows.text = rownumberFormatter.format((tdObjectCollection.length).toString());
  	  }
  	  
  	  private function removeLastArrayRecord(evt:Event):void{

  	  	  	  		dg.horizontalScrollPosition = 0;
  	  			  	  		
  	  			  	  		Array1.sort = null;
  	  		var afi:int = ArrayFilterInsert.length
  	  		var test:String = new String;
  	  		//Maintain the adhoc sort
  	  		if (Array1.sort != null){
					CheckSortGeneral(evt);
  	  		}
  	  		if (ArrayFilterInsert.length == 1){
				lbl_persistent_view.text = "No Selection";
				lbl_transient_view.text = "No Selection";
				filterDescription_persistent = "";
				filterDescription_transient = "";
  	  			
  	  		}
 	  		if (ArrayFilterInsert.length >= 1){
  	  		if (pop2.dg_1.selectedIndex >= ArrayFilterInsert.length){
  	  			var i_afi:int = pop2.dg_1.selectedIndex -1;
  	  			ArrayFilterInsert.removeItemAt(i_afi);
  	  			
  	  		} else {
  	  			ArrayFilterInsert.removeItemAt(pop2.dg_1.selectedIndex);
  	  			}
  	  		}	 
  	  				ArrayFilterInsert.refresh();
  	  				pop2.myArray = ArrayFilterInsert.toArray();
 	  				refreshButton(evt);

  	  				CheckSortAH(evt);
  	  		
					correctWidth(evt);
					addTotal(evt);
					pop2.dg_1.selectedIndex = ArrayFilterInsert.length -1;
  	  }
  	  
  	  
  	        private function help_keep(event:Event):void {
            	action_command = "keep";
            	history_log(event);
            		
            }
			private function help_keep_number(event:Event):void {
			
				action_command = "keep_number";
				history_log(event);
				
			}
  	        private function help_discard(event:Event):void {
            	action_command = "discard";
            	history_log(event);
            }
  	        private function help_clear(event:Event):void {
  	        	PopUpManager.removePopUp(popActions);
  	        	 
  	        	
  	       		filterDescription_persistent=''; 
        	  	filterDescription_transient='';
        	  	
            	
				lbl_persistent_view.text = "No selection";
				lbl_transient_view.text = "No selection";
            	ArrayFilterInsert = new ArrayCollection();
  	        	
  	        	 Array1 = new ArrayCollection();
 				 Array2 = new ArrayCollection();
  		
				
      
            	action_command = "clear";
          
			        
            	history_log(event);
          
            }
            
            private function help_clearall(event:Event):void {
  	        	PopUpManager.removePopUp(popActions);
            	action_command = "clear";
            	
            	ArrayFilterInsert = new ArrayCollection;
						 	var obj:Object = new Object();
						 	obj.type = "";
							obj.value = "";
							obj.column = ""; 
							obj.action =  action_command;	
							obj.view = "AH";
							ArrayFilterInsert.addItem(obj);
							
						
					
            }
            
            
            private var main_action_command:String = new String;
            
			private function help_multifilter(event:Event):void {
				removeMe(event);
				launchMultipleFilter(event);
			}


            private function help_add(event:Event):void {
            	action_command = "add";
            	history_log(event);
            }
            
            public function CheckSortGeneral(event:Event):void{
            				ah_sort_flag = false;
						  	var tot_column_str:String = new String();
           					var tot_value_str:String = new String();
           					var value_str:String = new String();
							obj_sort_ah = new Object;
					
							for (var i:int=0;i < Array1.sort.fields.length; i++)  {
        	  				tot_column_str = tot_column_str + ";" + Array1.sort.fields[i].name.toString()
        	  				
        	   				if (Array1.sort.fields[i].descending.toString() == "true"){
        	  						value_str = "descending";
        	  				} else {
        	  						value_str = "ascending";
        	  				}
        	  					tot_value_str = tot_value_str + ";" + value_str;
        	  				}
        	  					tot_column_str = tot_column_str.substr(1, tot_column_str.length);
        	  					tot_value_str = tot_value_str.substr(1, tot_value_str.length);
       				   					obj_sort_ah.type = "S"; 
										obj_sort_ah.value = tot_value_str;
										obj_sort_ah.column = tot_column_str; 
										obj_sort_ah.action =  "sort";	
										
			
            }
            

private function checkFilterInsert():void{
	if (Array1.sort != null){
		
		//ArrayFilterInsert 
		/*  Remove all Sort and replace with a new one*/
		//	Alert.show(ArrayFilterInsert.length.toString());
		for (var x:int = ArrayFilterInsert.length -1; x> -1; x--)  {
			//Alert.show("has sort: " + ArrayFilterInsert[x]['column']);
			if (ArrayFilterInsert[x]['action'] == 'sort'){
				
				ArrayFilterInsert.removeItemAt(x);
			}
			    
		}
		
		ArrayFilterInsert.refresh();
		//	Alert.show(ArrayFilterInsert.length.toString());
		
		var tot_column_str:String = new String();
		var tot_value_str:String = new String();
		var value_str:String = new String();
		
		var tot_datatype_str:String = new String();
		
		
		var obj:Object = new Object();
		for (var i:int=0;i < Array1.sort.fields.length; i++)  {
			
			tot_column_str = tot_column_str + ";" + Array1.sort.fields[i].name.toString()
			
			if (Array1.sort.fields[i].descending.toString() == "true"){
				value_str = "descending";
			} else {
				value_str = "ascending";   
			}
			tot_value_str = tot_value_str + ";" + value_str;
			
			
			// Get the datatype for each name
			
			
			for (var x:int=0;x < _xlcColumn.length; x++){
				if (Array1.sort.fields[i].name.toString() == _xlcColumn[x].dataField){
					//Alert.show(Array1.sort.fields[i].name.toString() + ":" + _xlcColumn[x].datatype);
					//type = _xlcColumn[x].datatype
					
					tot_datatype_str = tot_datatype_str + ";" +_xlcColumn[x].datatype.toString();
					break;
				}
			}
			
		}
		
		
		tot_column_str = tot_column_str.substr(1, tot_column_str.length);
		tot_value_str = tot_value_str.substr(1, tot_value_str.length);
		tot_datatype_str = tot_datatype_str.substr(1, tot_datatype_str.length);
		
		obj.type = tot_datatype_str;
		obj.value = tot_value_str;
		obj.column = tot_column_str; 
		obj.action =  "sort";	 
		ArrayFilterInsert.addItem(obj);
	} 	  
	
}

			public var ah_sort_flag:Boolean = new Boolean;
			public var obj_sort_ah:Object = new Object;
           	 private function history_log(event:Event):void{	
           	
 			 	var i:int;
 		        var ctr:int = 0;
             
                for(i = 0; i < aFormFields.length; i++){
                	if (aFormFields[i]['text'] != ""){
                	
						ctr = ctr + 1;
							//  Remove the trailing ; (semi colon) 
						if ((aFormFields[i]['text']).substr(aFormFields[i]['text'].length - 1, aFormFields[i]['text'].length) == ';'){
							
							aFormFields[i]['text'] = (aFormFields[i]['text']).substr(0, aFormFields[i]['text'].length - 1);
						}
					
						  
                	}  
                }
                if (ctr > 1) {
						AlertMessageShow("Multiple Filtering is not allowed.");
					}
				// check for sort flag in the dg	
				ah_sort_flag = true;
				   
				if (Array1.sort != null){
					checkFilterInsert();
				}	
					 
				if ((ctr == 0) && (action_command == "clear")){
			
						 	var obj:Object = new Object();
						 	obj.type = "";
							obj.value = "";
							obj.column = ""; 
							obj.action =  action_command;	
							obj.view = "AH";
							ArrayFilterInsert.addItem(obj);
							
							refreshButton(event);
				}	
				
	  			
				
				
                if (ctr == 1){
                		
				///////////////////
					/*if (Array1.sort == null){
					Alert.show("null");
					}
					*/
					
					
					///////////////////////
					
					
					
                	for(i = 0; i < aFormFields.length; i++){
                	  	custom_id 		 = aFormFields[i]['custom_id'];
                		custom_datatype  = aFormFields[i]['data_type'];
                		custom_text 	 = aFormFields[i]['text'];
                		custom_datafield = aFormFields[i]['data_field'];
                		
                	
                		if (aFormFields[i]['text'] != ""){
                	
                		 
                					obj = new Object();
                					if (action_command == "clear"){
                					    obj.type = "";
										obj.value = "";
										obj.column = ""; 
  	  		           				    } 
									/*		
									else if (action_command == "keep_number"){
											
											obj.type = (aFormFields[i]['data_type'].toString());
											obj.value = (aFormFields[i]['text'].toString());
											obj.column = (aFormFields[i]['data_field'].toString()); 
										}	
									*/
										else {
                					    obj.type = (aFormFields[i]['data_type'].toString());
										obj.value = (aFormFields[i]['text'].toString());
										obj.column = (aFormFields[i]['data_field'].toString()); 
                					    }
										obj.action =  action_command;
										obj.view = "AH";
										ArrayFilterInsert.addItem(obj);
									  
										/*
										if (action_command == "keep_number"){
											
											obj.type = (aFormFields[i]['data_type'].toString());
											obj.value = (aFormFields[i]['text'].toString());
											obj.column = (aFormFields[i]['data_field'].toString()); 
										}
										obj.action =  action_command;
										obj.view = "AH";
										ArrayFilterInsert.addItem(obj);
										*/
										
										
										
										
									if (action_command!= "add"){
										
										ActionEvent(event); 
									}
									if (action_command == "add"){
										addFunction(event);
											
									}
										
                		}
                   		aFormFields[i]['text'] = "";
                	}
					
					//Alert.show("go here ");
                	CheckSortAH(event);
					
					//Alert.show("go here 2");
					
                	addTotal(event);
					//Alert.show("go here 3");
					
                }
              help_flag = false;
              removeMe(event); 
           	 }
  	   
  	  
  	  		public function CheckSortAH(event:Event):void{
				
			
				//////////////////////////
				/*if (Array1.sort == null){
					Alert.show("null");
				}
				*/
				if (Array1.sort != null){
					
					//ArrayFilterInsert
					/*  Remove all Sort and replace with a new one*/
				//	Alert.show(ArrayFilterInsert.length.toString());
					for (var x:int = ArrayFilterInsert.length -1; x> -1; x--)  {
						//Alert.show("has sort: " + ArrayFilterInsert[x]['column']);
						if (ArrayFilterInsert[x]['action'] == 'sort'){
							
							ArrayFilterInsert.removeItemAt(x);
						}
						
					}
					 
					ArrayFilterInsert.refresh();
				//	Alert.show(ArrayFilterInsert.length.toString());
					
					var tot_column_str:String = new String();
					var tot_value_str:String = new String();
					var value_str:String = new String();
					
					var tot_datatype_str:String = new String();
					
					
					var obj:Object = new Object();
					for (var i:int=0;i < Array1.sort.fields.length; i++)  {
						
						tot_column_str = tot_column_str + ";" + Array1.sort.fields[i].name.toString()
						
						if (Array1.sort.fields[i].descending.toString() == "true"){
							value_str = "descending";
						} else {
							value_str = "ascending";   
						}
						tot_value_str = tot_value_str + ";" + value_str;
						
						
						// Get the datatype for each name
						
						
						for (var x:int=0;x < _xlcColumn.length; x++){
							if (Array1.sort.fields[i].name.toString() == _xlcColumn[x].dataField){
								//Alert.show(Array1.sort.fields[i].name.toString() + ":" + _xlcColumn[x].datatype);
								//type = _xlcColumn[x].datatype
								
								tot_datatype_str = tot_datatype_str + ";" +_xlcColumn[x].datatype.toString();
								break;
							}
						}
						
					}
					
					
					tot_column_str = tot_column_str.substr(1, tot_column_str.length);
					tot_value_str = tot_value_str.substr(1, tot_value_str.length);
					tot_datatype_str = tot_datatype_str.substr(1, tot_datatype_str.length);
					
					obj.type = tot_datatype_str;
					obj.value = tot_value_str;
					obj.column = tot_column_str; 
					obj.action =  "sort";	 
					ArrayFilterInsert.addItem(obj);
				} 	  
				
				////////////////////////////////////////////////////////////////////////////////
				ArrayFilterInsert.refresh();
				for(var i:int = 0; i < ArrayFilterInsert.length; i++){
  	  				if (ArrayFilterInsert[i]['action'] == "sort"){
  	  					custom_datafield = (ArrayFilterInsert[i]["column"]);
						custom_text = (ArrayFilterInsert[i]["value"]);
						custom_datatype = (ArrayFilterInsert[i]["type"]);
						action_command = (ArrayFilterInsert[i]["action"]);
						//Alert.show(custom_datafield);
  	  					SortFunction(event);
  	  				}
  	  				
  	  			}
  	  			
  	  			if (ah_sort_flag == false){
  	  							custom_datafield = obj_sort_ah.column;
								custom_text = obj_sort_ah.value;
								custom_datatype = obj_sort_ah.type;
								action_command = obj_sort_ah.action;
  	  							//SortFunction(event);
  	  			}
  	  			ah_sort_flag = true;
  	  		}
  	  		
  	  		
  	  		public var pop9_old:Specials;
            [Bindable]
			public var cb_sorted:ArrayCollection = new ArrayCollection;	
            private function launchSpecials(event:Event):void {
          	
          		// check for sorted fields for SubTotal parameters;
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
          		
               	pop9_old = Specials(
                PopUpManager.createPopUp(this, Specials, true));
				pop9_old.cb_subtotalarray = cb_sorted;
				pop9_old["btn_flash"].addEventListener("click", flashFilter); 
				pop9_old["btn_flash"].addEventListener(KeyboardEvent.KEY_DOWN, enterHandlerFlash);
   		        
				pop9_old["btn_flash"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop9_old["btn_flash"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
   		        
   		        
   		        
				pop9_old["btn_gt"].addEventListener("click", ca_sort); 
				pop9_old["btn_gt"].addEventListener(KeyboardEvent.KEY_DOWN, enterHandlerGT);
   		       	
				pop9_old["btn_gt"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop9_old["btn_gt"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				pop9_old["btn_st"].addEventListener("click", crunch_subtotal); 
				pop9_old["btn_st"].addEventListener(KeyboardEvent.KEY_DOWN, enterHandlerST);
   		        
				pop9_old["btn_st"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop9_old["btn_st"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
   		      
				pop9_old["btn_e2e"].addEventListener("click", convertDGToHTMLTable);
				pop9_old["btn_e2e"].addEventListener(KeyboardEvent.KEY_DOWN, SpecialsWIP);

				pop9_old["btn_e2e"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop9_old["btn_e2e"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				pop9_old["btn_cd"].addEventListener("click", ChartHandler);
				pop9_old["btn_cd"].addEventListener(KeyboardEvent.KEY_DOWN, SpecialsWIP);

				pop9_old["btn_cd"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop9_old["btn_cd"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				
				
				  

 
            }
            
            private function closepassMouseHoverfromComponents(event:Event):void{
  	  			stopHoverTimer();
            }
  	  		private function passMouseHoverfromComponents(event:Event):void{
  	  			mousehovering(event,event.currentTarget.label,'BUTTON');
  	  		
  	  		}
  	  		private function SpecialsAlertWIP(event:Event):void{
  	  					AlertMessageShow("Work In Process.");
  	  		}
  	  		
  	  		private function SpecialsWIP(event :KeyboardEvent):void{
  	  				if (event.keyCode == Keyboard.ENTER)
					{
						SpecialsAlertWIP(event);
						
					}
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_9(event);  
					}
			
  	  		}
  	  		private function enterHandlerFlash(event :KeyboardEvent):void
				{
					if (event.keyCode == Keyboard.ENTER)
					{
						 
						flashFilter(event);
						
					}
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_9(event);
					}
					
					
				}
  	  		private function enterHandlerGT(event :KeyboardEvent):void
				{
					if (event.keyCode == Keyboard.ENTER)
					{
						ca_sort(event);
						
					}
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_9(event);
					}
					
					
				}
			private function enterHandlerST(event :KeyboardEvent):void
				{
					if (event.keyCode == Keyboard.ENTER)
					{
						crunch_subtotal(event);
					
					}
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_9(event);
					}
				}	
  	  		
  	  		public var pop1:ActionCommand;
  	  		import mx.managers.PopUpManager;
  	  		import mx.events.DragEvent;
  	  		import flash.external.ExternalInterface;
  	  		import flash.display.Loader;
  	  		import mx.containers.utilityClasses.PostScaleAdapter;
  	  		import mx.messaging.SubscriptionInfo;

            private function launchMoreInfo(event:Event):void {
          	  	if(!pop1 || !pop1.inUse)
         		{
         			pop1 = ActionCommand(
                	
                	PopUpManager.createPopUp(this, ActionCommand, false));
                	pop1.inUse = true;
                }
   		        pop1["btn_discard"].addEventListener("click", help_discard); 
   		        pop1["btn_discard"].addEventListener(KeyboardEvent.KEY_DOWN, enterHandlerDiscard);
   		        pop1["btn_discard"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop1["btn_discard"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
   		
   		        pop1["btn_keep"].addEventListener("click", help_keep); 
   		        pop1["btn_keep"].addEventListener(KeyboardEvent.KEY_DOWN, enterHandlerKeep);
   		        pop1["btn_keep"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop1["btn_keep"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
   		        
   		        pop1["btn_add"].addEventListener("click", help_add);
				pop1["btn_add"].addEventListener(KeyboardEvent.KEY_DOWN, enterHandlerAdd);
				pop1["btn_add"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop1["btn_add"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
 
				
				
				pop1["btn_multifilter"].addEventListener("click", help_multifilter);
				pop1["btn_multifilter"].addEventListener(KeyboardEvent.KEY_DOWN, enterHandlerAdd);
				pop1["btn_multifilter"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop1["btn_multifilter"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				pop1["lb_filteroperators"].addEventListener("click", launchFilterOperators);
				
				pop1["lb_filteroperators"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop1["lb_filteroperators"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				
				
				
            }
          

				private var popmywildcards:FilterWildcardInterface;
				private function launchFilterOperators(event:Event):void{
					
					
					
					popmywildcards = FilterWildcardInterface(
						PopUpManager.createPopUp(this, FilterWildcardInterface, true));
					
					
				}

         		private function enterHandlerKeep(event :KeyboardEvent):void
				{
					
					if (event.keyCode == Keyboard.ENTER)
					{   
						help_keep(event);  
					}
					if (event.keyCode == Keyboard.UP)
					{
						pop1.btn_discard.setFocus();
						pop1.btn_discard.drawFocus(true);
					}
					if (event.keyCode == Keyboard.DOWN)
					{
						pop1.btn_add.setFocus();
						pop1.btn_add.drawFocus(true);
					}
					if (event.keyCode == Keyboard.ESCAPE)
					{
						pop1.inUse = false;	
						removeMe(event);
					}
					
					
				}
         		private function enterHandlerDiscard(event :KeyboardEvent):void
				{
					if (event.keyCode == Keyboard.ENTER)
					{
						help_discard(event);
					}
					if (event.keyCode == Keyboard.UP)
					{
						pop1.btn_add.setFocus();
						pop1.btn_add.drawFocus(true);
					}
					if (event.keyCode == Keyboard.DOWN)
					{
						pop1.btn_keep.setFocus();
						pop1.btn_keep.drawFocus(true);
					}
					if (event.keyCode == Keyboard.ESCAPE)
					{
						pop1.inUse = false;
						removeMe(event);
					}
				}
				private function enterHandlerAdd(event :KeyboardEvent):void
				{
					if (event.keyCode == Keyboard.ENTER)
					{
						help_add(event);
					}
					if (event.keyCode == Keyboard.UP)
					{
						pop1.btn_keep.setFocus();
						pop1.btn_keep.drawFocus(true);
					}
					if (event.keyCode == Keyboard.DOWN)
					{
						pop1.btn_discard.setFocus();
						pop1.btn_discard.drawFocus(true);
					}
					if (event.keyCode == Keyboard.ESCAPE)
					{
						pop1.inUse = false;
						removeMe(event);
					}
				}         
            private function removeMe(event:Event):void {
            			pop1.inUse = false;
						PopUpManager.removePopUp(pop1);
            } 
            private function removeMe_2(event:Event):void {
						PopUpManager.removePopUp(pop2);
            }
            private function removeMe_3(event:Event):void {
						PopUpManager.removePopUp(pop3);
            }
            private function removeMe_4(event:Event):void {
						PopUpManager.removePopUp(pop4);
            }   
            private function removeMe_5(event:Event):void {
						PopUpManager.removePopUp(pop5);
            }   
            private function removeMe_6(event:Event):void {
						PopUpManager.removePopUp(pop6);
            }  
            private function removeMe_7(event:Event):void {
						PopUpManager.removePopUp(pop7);
            } 
            private function removeMe_9(event:Event):void {
						PopUpManager.removePopUp(pop9);
            }
			
            private function removeMe_totsel(event:Event):void {
						PopUpManager.removePopUp(poptotsel);
            }
             private function removeMe_hdr(event:Event):void {
						PopUpManager.removePopUp(pophdr);
            }
            private function removeMe_fdr(event:Event):void {
						PopUpManager.removePopUp(popfdr);
            }
            private function removeMe_ft(event:Event):void {
						PopUpManager.removePopUp(popft);
            }
            
            private function removeMe_popcompsys_access(event:Event):void {
						PopUpManager.removePopUp(popcompsys_access);
            }
            
            private function lose(event:Event):void {
				/*  Changing the 1st column unique key to last column unique.  */
				dg_vsb = dg.verticalScrollPosition;
				dg_hsb = dg.horizontalScrollPosition;
				var numItems:int = dg.selectedItems.length;
				var dg_key:String = new String;
				var final_dg_key:String = "";
				if (numItems == 1){
					final_dg_key =  dg.selectedItems[ 0 ][_xlcColumn[_xlcColumn.length -2]["dataField"]];
				} else if (numItems > 1){ 
					
					for( var i:int = 0; i < numItems; i++ )
					{
						dg_key =  dg.selectedItems[ i ][_xlcColumn[_xlcColumn.length -2]["dataField"]];
						c_utils.trim(dg_key);
						final_dg_key = final_dg_key + dg_key + ";" 
					}
					var final_length:int = final_dg_key.length
					final_dg_key = final_dg_key.substr(0,final_length - 1);
				}
				aFormFields[0]['text'] = final_dg_key;
				aFormFields[0]['data_field'] = _xlcColumn[_xlcColumn.length -2]["dataField"];
				aFormFields[0]['data_type'] = "S";
				help_discard(event);
				aFormFields[0]['text'] = "";
				aFormFields[0]['data_field'] = "";
				
				dg.verticalScrollPosition = dg_vsb;
				dg.horizontalScrollPosition = dg_hsb;
				PopUpManager.removePopUp(popActions);
				
            }

            private function choose(event:Event):void {
            	     
				/*  Changing the 1st column unique key to last column unique.  */
				
				var numItems:int = dg.selectedItems.length;
				var dg_key:String = new String;
				var final_dg_key:String = "";   
				if (numItems == 1){    
					final_dg_key =  dg.selectedItems[ 0 ][_xlcColumn[_xlcColumn.length -2]["dataField"]];
					//Alert.show(final_dg_key);
				} else if (numItems > 1){ 
					
					for( var i:int = 0; i < numItems; i++ )
					{
						dg_key =  dg.selectedItems[ i ][_xlcColumn[_xlcColumn.length -2]["dataField"]];
						c_utils.trim(dg_key);
						final_dg_key = final_dg_key + dg_key + ";" ;
					}
					var final_length:int = final_dg_key.length
					final_dg_key = final_dg_key.substr(0,final_length - 1);
				}
			
				aFormFields[0]['text'] = final_dg_key;
				aFormFields[0]['data_field'] = _xlcColumn[_xlcColumn.length -2]["dataField"];
				aFormFields[0]['data_type'] = "S";
				help_keep(event);
				aFormFields[0]['text'] = "";
				aFormFields[0]['data_field'] = "";
				
				PopUpManager.removePopUp(popActions);		
				 
				 
				
            }
private function choose_numberofrows(event:Event):void {
	
	/*  Changing the 1st column unique key to last column unique.  */
	
	var numItems:int = dg.selectedItems.length;
	var dg_key:String = new String;
	var final_dg_key:String = "";   
	if (numItems == 1){    
		final_dg_key =  dg.selectedItems[ 0 ][_xlcColumn[_xlcColumn.length -2]["dataField"]];
		//Alert.show(final_dg_key);
	} else if (numItems > 1){ 
		
		for( var i:int = 0; i < numItems; i++ )
		{
			dg_key =  dg.selectedItems[ i ][_xlcColumn[_xlcColumn.length -2]["dataField"]];
			c_utils.trim(dg_key);
			final_dg_key = final_dg_key + dg_key + ";" ;
		}
		var final_length:int = final_dg_key.length
		final_dg_key = final_dg_key.substr(0,final_length - 1);
	}
	
	aFormFields[0]['text'] = final_dg_key;
	aFormFields[0]['data_field'] = _xlcColumn[_xlcColumn.length -2]["dataField"];
	aFormFields[0]['data_type'] = "S";
	help_keep_number(event);
	aFormFields[0]['text'] = "";
	aFormFields[0]['data_field'] = "";
	
	PopUpManager.removePopUp(popActions);		
	
	
	
}


            public var pop2:HistoryLog;
            public var myArray:Array;





private function saveCurSort_button(event:Event):void{
	
	if (Array1.sort != null){
		
		//ArrayFilterInsert
		/*  Remove all Sort and replace with a new one*/
		
		for (var x:int = ArrayFilterInsert.length -1; x> -1; x--)  {
			if (ArrayFilterInsert[x]['action'] == 'sort'){
				
				ArrayFilterInsert.removeItemAt(x);
			}
			
		}
		
		ArrayFilterInsert.refresh();
		var tot_column_str:String = new String();
		var tot_value_str:String = new String();
		var value_str:String = new String();
		
		var tot_datatype_str:String = new String();
		
		
		var obj:Object = new Object();
		for (var i:int=0;i < Array1.sort.fields.length; i++)  {
			//Alert.show(Array1.sort.fields[i].name.toString());
			// check dataype from xlc_Column//
			
			
			/*
			for (var x:int=0;x < _xlcColumn.length; x++){
				if (Array1.sort.fields[i].name.toString() == _xlcColumn[x].dataField){
					//Alert.show(Array1.sort.fields[i].name.toString() + ":" + _xlcColumn[x].datatype);
					obj.type = _xlcColumn[x].datatype
				}
			}
			*/
			tot_column_str = tot_column_str + ";" + Array1.sort.fields[i].name.toString()
			
			if (Array1.sort.fields[i].descending.toString() == "true"){
				value_str = "descending";
			} else {
				value_str = "ascending";   
			}
			tot_value_str = tot_value_str + ";" + value_str;
			
			
			// Get the datatype for each name
			
			
			for (var x:int=0;x < _xlcColumn.length; x++){
				if (Array1.sort.fields[i].name.toString() == _xlcColumn[x].dataField){
					//Alert.show(Array1.sort.fields[i].name.toString() + ":" + _xlcColumn[x].datatype);
					//type = _xlcColumn[x].datatype
					
					tot_datatype_str = tot_datatype_str + ";" +_xlcColumn[x].datatype.toString();
					break;
				}
			}
			
		}
		/*
		if (Array1.sort.fields.length == 1){
			for (var x:int=0;x < _xlcColumn.length; x++){
				if (Array1.sort.fields[0].name.toString() == _xlcColumn[x].dataField){
					//Alert.show(Array1.sort.fields[i].name.toString() + ":" + _xlcColumn[x].datatype);
					obj.type = _xlcColumn[x].datatype
				}
			}
		}
		
		*/
		//  The first datatype will always be the datatype for multiple sort column
		/*
		var type:String = new String;
		for (var x:int=0;x < _xlcColumn.length; x++){
			if (Array1.sort.fields[0].name.toString() == _xlcColumn[x].dataField){
				//Alert.show(Array1.sort.fields[i].name.toString() + ":" + _xlcColumn[x].datatype);
				type = _xlcColumn[x].datatype
					break;
			}
		}
		obj.type = type;
		*/
		
		
		
		tot_column_str = tot_column_str.substr(1, tot_column_str.length);
		tot_value_str = tot_value_str.substr(1, tot_value_str.length);
		tot_datatype_str = tot_datatype_str.substr(1, tot_datatype_str.length);
		//obj.type = "N"; 
		obj.type = tot_datatype_str;
		obj.value = tot_value_str;
		obj.column = tot_column_str; 
		obj.action =  "sort";	
		ArrayFilterInsert.addItem(obj);
	} 	  
//	saveMyViewPartsFiltersFinal(event); 	
}



            private function launchHistoryLog(event:Event):void {
			
				
				saveCurSort_button(event);
				
               	pop2 = HistoryLog(
                PopUpManager.createPopUp(this, HistoryLog, true));
                pop2.myArray = ArrayFilterInsert.toArray();
				pop2.currentrendtion = _xlcRenditionCode; 
				pop2.persistentview = lbl_persistent_view.text;
				pop2.transientview = lbl_transient_view.text;
				pop2._xlcColumnlocal = _xlcColumn;
				pop2._title = _xlcTitle;
				
				if (Application.application.parameters.av == 'N'){
	//  Remove this for now for the One Click Dashboard Functionality
	//				pop2.btn_save_persistent.enabled = false;
	//				pop2.btn_save_transient.enabled = false;
				}  
				
			
                pop2["dg_1"].addEventListener(KeyboardEvent.KEY_DOWN, enterHistoryValue);
   		        pop2["btn_undo"].addEventListener("click", removeLastArrayRecord);  
   		        pop2["btn_undo"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop2["btn_undo"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
   		        pop2["btn_undoall"].addEventListener("click", erase);
   		        pop2["btn_undoall"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop2["btn_undoall"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				pop2["btn_reset"].addEventListener("click", action_reset);
				pop2["btn_reset"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop2["btn_reset"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				   
				pop2["btn_base"].addEventListener("click", return_to_base);
				pop2["btn_base"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop2["btn_base"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				/*
				<local:ActionGridImageButton
				id="img_reset"  
				doc_id="1005"
				click="{action_reset(event), stopHoverTimer() }"
				source="@Embed(source='image/ico_reset.png')"
				mouseOver="{mousehovering(event,'Reset','BUTTON')}"
				mouseOut="{stopHoverTimer()}"
					/> 
				*/
				//  Remove this for now for the One Click Dashboard Functionality
				/*
   		        pop2["btn_save_persistent"].addEventListener("click", SaveAsPersistent);
   		        pop2["btn_save_persistent"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop2["btn_save_persistent"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
   		        pop2["btn_save_transient"].addEventListener("click", SaveAsTransient);
   		        pop2["btn_save_transient"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop2["btn_save_transient"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				*/
				pop2["btn_close"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop2["btn_close"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				if  (event.currentTarget.id == "btn_viewSettings"){
					pop2.btn_undo.enabled = false;
					pop2.btn_undoall.enabled = false;
				//  Remove this for now for the One Click Dashboard Functionality
				//	pop2.btn_save_persistent.enabled = false;
				//	pop2.btn_save_transient.enabled = false;
				}
				if  (crunch == true){
					pop2.btn_undo.enabled = true;
					pop2.btn_undoall.enabled = true;
				//  Remove this for now for the One Click Dashboard Functionality
				//	pop2.btn_save_persistent.enabled = false;
				//	pop2.btn_save_transient.enabled = false;
				}
				PopUpManager.centerPopUp(pop2);
            }

            private function SaveAsPersistent(event:Event):void {
            	var filterdescription:String = new String;
				var filtercode:String = new String;
            	if (ArrayFilterInsert.length == 0){
            		AlertMessageShow("Please Enter Settings.");
            		return;
            	}
            	saveas = "Persistent";
            	saveviews = "P";
         
				viewcombo = lbl_persistent_view.text
            	
				for (var i:int=0;i < fhp.length; i++)  {
            		if (viewcombo == fhp[i].filtercode){
						filtercode = fhp[i].filtercode
            			filterdescription = fhp[i].filterdescription
            		}
            	}
            	
            	
            	launchFilterMacro(event, filterdescription, filtercode);
            }
          
            private function SaveAsTransient(event:Event):void {
            	var filterdescription:String = new String;
				var filtercode:String = new String;
            	if (ArrayFilterInsert.length == 0){
            		AlertMessageShow("Please Enter Settings.");
            		return;
            	}
            	
            	if (ArrayFilterInsert[0].action == 'clear'){
            		AlertMessageShow("Transient View cannot begin with a CLEAR action.");
            		return;
            	}
            	saveas = "Transient";
            	saveviews = "T";
            	
				viewcombo = lbl_transient_view.text
            	for (var i:int=0;i < fh.length; i++)  {
            		if (viewcombo == fh[i].filtercode){
						filtercode = fhp[i].filtercode
            			filterdescription = fh[i].filterdescription
            		}
            	}
            	launchFilterMacro(event,filterdescription, filtercode);
            }
            
            public var pop4:SaveMacro;


				private function getChosenPanel():String{
						var panelname:String = new String();
						for( var a:int = 0; a < aPanel.length; a++ ){
							
							if (aPanel[a]["selected"] == true){
								panelname =  aPanel[a].label;
								
							}
						}	
						return panelname;
				}  
	
		private function launchFilterMacro(event:Event, filterdesc:String, filtercode:String):void {
            	var ssort_lc:String = ""
            
            	  	if (Array1.sort != null){
               			ssort_lc = "justsort";
                	}else{
                		ssort_lc = "nosort";
                	}
              	
            	
            	pop4 = SaveMacro(
                PopUpManager.createPopUp(this, SaveMacro, true));
                pop4.save_as = saveas;
                pop4.view_combo = viewcombo;
                pop4.usercode = myName_main;
               
				pop4.paneltitle = getChosenPanel();
              	pop4.ssort = ssort_lc;
				pop4.filter_code = filtercode;
              	pop4.filter_description = filterdesc;
                
                
   		        pop4["btn_save_current"].addEventListener("click", saveMac); 
   		        pop4["btn_save_current"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop4["btn_save_current"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				pop4["btn_cancel"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop4["btn_cancel"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
   		        pop4["btn_maintain_macro"].addEventListener("click", launchMaintainMacro);
            }
           
			
			            
            
            public var pop6:SaveCurrentSort;
			private function launchSaveCurrentSort(event:Event):void {
            	pop6 = SaveCurrentSort(
                PopUpManager.createPopUp(this, SaveCurrentSort, true));
   		        pop6["btn_save_currentsort_yes"].addEventListener("click", saveCurSort); 
   		        pop6["btn_save_currentsort_no"].addEventListener("click", nosaveCurSort);
            }
			
			
		   private function nosaveCurSort(event:Event):void{
		   	savecurrent(event);
		   	removeMe_6(event);
           	removeMe_2(event);
		   }
           private function saveCurSort(event:Event):void{
			
       			 if (Array1.sort != null){
					 
					//ArrayFilterInsert
					 /*  Remove all Sort and replace with a new one*/
					 
					 for (var x:int = ArrayFilterInsert.length -1; x> -1; x--)  {
						 if (ArrayFilterInsert[x]['action'] == 'sort'){
							 
							  ArrayFilterInsert.removeItemAt(x);
						 }
						 
					 }
					
					 ArrayFilterInsert.refresh();
       			    var tot_column_str:String = new String();
           			var tot_value_str:String = new String();
           			var value_str:String = new String();
					var tot_datatype_str:String = new String();
       				var obj:Object = new Object();
        	  			for (var i:int=0;i < Array1.sort.fields.length; i++)  {
							
							//Alert.show("go here");
							//Alert.show(Array1.sort.fields[i].datatype);
							
							
							// Save the last datatype per field //
							/*
							for (var x:int=0;x < _xlcColumn.length; x++){
								if (Array1.sort.fields[i].name.toString() == _xlcColumn[x].dataField){
									//Alert.show(Array1.sort.fields[i].name.toString() + ":" + _xlcColumn[x].datatype);
									obj.type = _xlcColumn[x].datatype;
								}
							}
							*/
							
							
        	  				tot_column_str = tot_column_str + ";" + Array1.sort.fields[i].name.toString()
        	  				
        	   				if (Array1.sort.fields[i].descending.toString() == "true"){
        	  						value_str = "descending";
        	  				} else {
        	  						value_str = "ascending";   
        	  				}
        	  				tot_value_str = tot_value_str + ";" + value_str;
							
							
							
							for (var x:int=0;x < _xlcColumn.length; x++){
								if (Array1.sort.fields[i].name.toString() == _xlcColumn[x].dataField){
									//Alert.show(Array1.sort.fields[i].name.toString() + ":" + _xlcColumn[x].datatype);
									//type = _xlcColumn[x].datatype
									
									tot_datatype_str = tot_datatype_str + ";" +_xlcColumn[x].datatype.toString();
									break;
								}
							}
							
							
        	  			}
						
						/*
						var type:String = new String;
						for (var x:int=0;x < _xlcColumn.length; x++){
							if (Array1.sort.fields[0].name.toString() == _xlcColumn[x].dataField){
								//Alert.show(Array1.sort.fields[i].name.toString() + ":" + _xlcColumn[x].datatype);
								type = _xlcColumn[x].datatype
								break;
							}
						}
						obj.type = type;
						*/
						
        	  					tot_column_str = tot_column_str.substr(1, tot_column_str.length);
        	  					tot_value_str = tot_value_str.substr(1, tot_value_str.length);
								tot_datatype_str = tot_datatype_str.substr(1, tot_datatype_str.length);
       				   					//obj.type = "S";
								//obj.type = "N";   
								obj.type =tot_datatype_str;
										obj.value = tot_value_str;
										obj.column = tot_column_str; 
										obj.action =  "sort";	
										ArrayFilterInsert.addItem(obj);
       			} 	  
				
				 saveMyViewPartsFiltersFinal(event); 	
           } 



           private function savePanel(event:Event):void{
       				var obj:Object = new Object();
			   			obj.type = "P"; 
						obj.value = dg.horizontalScrollPosition;
					
						obj.column =  getChosenPanel(); 
						obj.action =  "panel";	
					ArrayFilterInsert.addItem(obj);
           
		   }

            
           private function saveMac_old(event:Event):void{
           	
           	if (Array1.sort != null){
           		removeMe_4(event);
        		launchSaveCurrentSort(event);
         	}
           		
           	else{	
           			
           		savecurrent(event);
           		removeMe_4(event);
           		removeMe_2(event);
           	}	
           }
           
         

           private function saveMac(event:Event):void{
			   
			   // Check operator access.
			   // O - Operator Code
			   // N - Not Allowed
			   // G - Generic
			   
			   if ( Application.application.parameters.av == 'O'){
				   if (pop4.gen.selected == true){
					   AlertMessageShow('You are not allowed to create/modify a Generic View.')
					   return;
				   }
			   }
			   
           		//  This is for New View
           		if (pop4.nv.selected == true){
           		 		if (pop4.inputcode.text == ""){
								AlertMessageShow("Please Enter Code.");
								pop4.inputcode.setFocus();
								pop4.inputcode.setStyle("backgroundColor", "#C7CECC");
								pop4.inputdescription.setStyle("backgroundColor", "#ffffff");
								return;
								
						}
						
						 
						if (myName_main.toUpperCase() != 'MAVES'){
							if(((pop4.inputcode.text).toUpperCase()).substr(0,4) == 'BASE'){
								AlertMessageShow("'BASE' Code is not allowed");
								pop4.inputcode.setFocus();
								pop4.inputcode.setStyle("backgroundColor", "#C7CECC");
								pop4.inputdescription.setStyle("backgroundColor", "#ffffff");
								return;
							}	
						}
						
						if (pop4.inputdescription.text == ""){
								AlertMessageShow("Please Enter Description.");
								pop4.inputdescription.setFocus();
								pop4.inputcode.setStyle("backgroundColor", "#ffffff"); 	
								pop4.inputdescription.setStyle("backgroundColor", "#C7CECC");
								return;
						}
           		}
           		
           		// This is for Sort = Yes
           		if (pop4.sy.selected == true){
           			saveCurSort(event);
           		}
           		//  This is for the Panel
           		if (pop4.spy.selected == true){
           			savePanel(event); 
           		}
           	
           		if (pop4.gen.selected == true){
					userfh = "gen"; 
				}
				
				if (pop4.uoc.selected == true){
					userfh = myName_main; 
				}
				
           		if (pop4.nv.selected == true){
           			var str_inputcode:String = new String;
           			if (pop4.gen.selected == true){
						str_inputcode =  pop4.inputcode.text;
					}
           			if (pop4.uoc.selected == true){
           				str_inputcode = "*" + pop4.inputcode.text;
           			}	
           			 MaintainMacroHeader(event, str_inputcode, pop4.inputdescription.text,userfh); 
           			
           		}
           		if (pop4.ev.selected == true){
					
					if (myName_main.toUpperCase() != 'MAVES'){
						
						if(((pop4.view_combo).toUpperCase()).substr(0,4) == 'BASE'){
							AlertMessageShow("You are not allowed to Modify a 'BASE' Code");
							return;
						}	
					}
					
           			toxml_filterdescription = pop4.inputdescription.text
           			savecurrent(event);
           		}
           		
           	}
           
             public var pop3:MultipleFilter ; 
            
             public var mfArray:Array;
            private function launchMultipleFilter(event:Event):void {
            	PopUpManager.removePopUp(popActions);
               	pop3 = MultipleFilter(
                PopUpManager.createPopUp(this, MultipleFilter, true));
                pop3.mfArray = _xlcColumn.toArray();
				pop3.DateValueArr = DateValueArr;
				pop3.daterange_fromdate = "";
				pop3.daterange_todate = ""; 
				pop3.user_sq = myName_main;   
				pop3.cc_sq = my_c_code1;
				pop3.sid_sq = my_sid;
				
				
				
                pop3["dg_2"].addEventListener(KeyboardEvent.KEY_DOWN, enterMultipleFilterValue);
   		        pop3["mf_btn_keep"].addEventListener("click", keepMultipleFilterValue); 
   		        pop3["mf_btn_keep"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop3["mf_btn_keep"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
   		        pop3["mf_btn_discard"].addEventListener("click", discardMultipleFilterValue); 
   		        pop3["mf_btn_discard"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop3["mf_btn_discard"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
   		        pop3["mf_add"].addEventListener("click", addMultipleFilterValue);
   		        pop3["mf_add"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop3["mf_add"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				pop3["btn_close"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop3["btn_close"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
            }
			private var popcopytoclipboard:CopyToClipBoard ; 
			private function launchCopytoClipboard(event:Event):void {
				copytoClipboard(event);
			}


			private function copyToClipBoard(event:Event):void {
				
			}

			
              public var pop5:MaintainMacro;
            private function launchMaintainMacro(event:Event):void {
            	removeMe_4(event);
               	pop5 = MaintainMacro(
                PopUpManager.createPopUp(this, MaintainMacro, true));
                pop5["btn_save_mc"].addEventListener("click", saveMacMain);
   		        pop5["btn_cancel_mc"].addEventListener("click", removeMe_5); 
   		    }


           private function saveMacMain(event:Event):void{
           	if (pop5.txt_macro_code.text == ""){
						Alert.show("Pls. Enter Macro Code");
						return;
					}
				if (pop5.txt_macro_description.text == ""){
						Alert.show("Pls. Enter Macro Description");
						return;
				}	
           	if (Array1.sort != null){
           		removeMe_5(event);
        		launchSaveMaintainSort(event);
         	}
           		
           	else{	
           			
           		saveMaintainMacro(event);
      
           	}	
           }


            public var pop7:SaveMaintainSort;
			private function launchSaveMaintainSort(event:Event):void {
            	pop7 = SaveMaintainSort(
                PopUpManager.createPopUp(this, SaveMaintainSort, true));
   		        pop7["btn_save_maintainsort_yes"].addEventListener("click", saveMainSort); 
   		        pop7["btn_save_maintainsort_no"].addEventListener("click", nosaveMainSort);
            }
           private function nosaveMainSort(event:Event):void{
		   		saveMaintainMacro(event);
           		removeMe_7(event);
           		removeMe_5(event); 	 
		   }

			 private function saveMainSort(event:Event):void{
       			if (Array1.sort.toString() != null){
       			    var tot_column_str:String = new String();
           			var tot_value_str:String = new String();
           			var value_str:String = new String();
       				var obj:Object = new Object();
        	  			for (var i:int=0;i < Array1.sort.fields.length; i++)  {
        	  				tot_column_str = tot_column_str + ";" + Array1.sort.fields[i].name.toString()
        	  				
        	   				if (Array1.sort.fields[i].descending.toString() == "true"){
        	  						value_str = "descending"
        	  				} else {
        	  						value_str = "ascending"
        	  				}
        	  				tot_value_str = tot_value_str + ";" + value_str;
        	  			}
        	  					tot_column_str = tot_column_str.substr(1, tot_column_str.length);
        	  					tot_value_str = tot_value_str.substr(1, tot_value_str.length);
       				   					obj.type = "S"; 
										obj.value = tot_value_str;
										obj.column = tot_column_str; 
										obj.action =  "sort";	
										ArrayFilterInsert.addItem(obj);
       			
       			}
       			

          		saveMaintainMacro(event);
           		removeMe_7(event);
           		removeMe_5(event); 	  	 
			 }




			private function saveMaintainMacro(event :Event):void{
			}

            private function enterHistoryValue(event :KeyboardEvent):void
				{
					if (event.keyCode == Keyboard.ENTER)
					{
						refreshButton(event);
						removeMe_2(event);
					}
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_2(event);
					}
			}
			private function enterMultipleFilterValue(event:KeyboardEvent):void
				{
					if ((event.keyCode == Keyboard.ENTER))
					{
						insertMultipleFilterValuetoArrayFilterInsert(event, 'keep');
					}
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_3(event);
					}
			}
			private function keepMultipleFilterValue(event :Event):void
			{
						insertMultipleFilterValuetoArrayFilterInsert(event, 'keep');
			}
             private function discardMultipleFilterValue(event:Event):void
			{
						insertMultipleFilterValuetoArrayFilterInsert(event, 'discard');
			}
			private function addMultipleFilterValue(event:Event):void
			{
						insertMultipleFilterValuetoArrayFilterInsert(event, 'add');
			}
			private function insertMultipleFilterValuetoArrayFilterInsert(event:Event, obj_action:String):void
				{
					;
					var obj:Object = new Object();
						                for (var i:int=0;i<pop3.mfArray.length;i++){
						            			var s2:String = pop3.mfArray[i].datatype;
						            			var s1:String = pop3.mfArray[i].dataField;
						            			var s:String = pop3.mfArray[i].value;
						            			
						            			if ((s != " ")&&(s != null)&&(s != "")){
						            			obj = new Object();
                					    				obj.type = s2;
														obj.value = s;
														obj.column = s1;
                					    				obj.action = obj_action;
                					    				obj.view = "AH";
                					    				ArrayFilterInsert.addItem(obj);
						            			}
                						}
                		if (obj_action == "add"){
                						addFunction(event);
                		}				
                		for (var a1:int=0;a1<pop3.mfArray.length;a1++){
                							pop3.mfArray[a1].value = " ";
                		}
						removeMe_3(event);
						refreshButton(event);
			}
           private function selectAll(event:Event):void {
           			dg.selectedIndices = Array1.toArray();
           			dg.selectedItems = Array1.toArray();
           			
           			
           			PopUpManager.removePopUp(popActions);
            }
           private function nextColumn(event:Event):void {
      
           dg.horizontalScrollPosition = dg.horizontalScrollPosition + dg.lockedColumnCount; 
           
           
           	var flag:Boolean = false;
           	for (var i:int=0;i<ArrayColumnGroup.length;i++)  {
					if (i != ArrayColumnGroup.length - 1){
							if ((dg.horizontalScrollPosition >= ArrayColumnGroup[i]['columnstart'])  && (dg.horizontalScrollPosition < ArrayColumnGroup[i + 1]['columnstart'])){
														dg.horizontalScrollPosition = ArrayColumnGroup[i + 1]['columnstart'] - dg.lockedColumnCount;
								flag = true;
								break;
							} 
					}
					if (i == ArrayColumnGroup.length - 1){
									flag = false;
					}
							
           	}
            	if (flag == false){
           		dg.horizontalScrollPosition = dg.horizontalScrollPosition - dg.lockedColumnCount;
           	}
          	correctWidth(event);
			addTotal(event);
           
            }
           private function previousColumn(event:Event):void {
           	      dg.horizontalScrollPosition = dg.horizontalScrollPosition + dg.lockedColumnCount; 
          
           	var flag:Boolean = false;
           	for (var i:int=0;i<ArrayColumnGroup.length;i++)  {
			
					
				if (i == 0){
			
							
							if (dg.horizontalScrollPosition == ArrayColumnGroup[i]['columnstart']){
								dg.horizontalScrollPosition = _xlcLockColumn;
								break;
								
							}
							
					}
				
					if (i != 0){
								if ((dg.horizontalScrollPosition > ArrayColumnGroup[i - 1 ]['columnstart'])  && (dg.horizontalScrollPosition <= ArrayColumnGroup[i]['columnstart'])){
								dg.horizontalScrollPosition = ArrayColumnGroup[i - 1]['columnstart'] - dg.lockedColumnCount;
								
								if (i == 1){
									dg.horizontalScrollPosition = 0;
								}
								flag = true;
								break;
							} 
					}
					
							
           	}
           	if (flag == false){
           		dg.horizontalScrollPosition = dg.horizontalScrollPosition - dg.lockedColumnCount;
           	}
           	correctWidth(event);
			addTotal(event);
           	
           
            }
            public function refreshSort(evt:Event):Boolean {
            	PopUpManager.removePopUp(popActions);
            	dg_vsb = dg.verticalScrollPosition;
				dg_hsb = dg.horizontalScrollPosition;
            	var index_location:int = dg.horizontalScrollPosition;
            	ArraySwap(evt);
                Array1.sort = null;
                Array1.refresh();
                dg.verticalScrollPosition = dg_vsb;
	   			dg.horizontalScrollPosition = dg_hsb;
                return dg.horizontalScrollPosition = index_location;
                
            }
            
            private function dragStartHandler(event):void{
            	if (event.ctrlKey == true){
            		dg.dragEnabled=false;
            		dg.dropEnabled=false;
            		dg.dragMoveEnabled=false;
            		AlertMessageShow("Copy move is not allowed.  Please release the Ctrl key when moving rows.");
            	}
            	if (event.ctrlKey == false){
            		dg.dragEnabled=true;
            		dg.dropEnabled=true;
            		dg.dragMoveEnabled=true;
            	}
            	dg.dragEnabled=true;
            	dg.dropEnabled=true;
            	dg.dragMoveEnabled=true;
            }
            
            
            private function change_filtermacro(evt:Event):void {
              
				var obj:Object = new Object();
				
					for(var i:int = 0; i < fd.length; i++){
			    		
						if (lbl_transient_view.text ==  fd[i]['filtercode']){	
							action_command   = fd[i]['action'];
									obj = new Object();
                					    	if (action_command == "clear"){
                					    	obj.type = "";
											obj.value = "";
											obj.column = ""; 
  	  		           				    	}	else {
                					    	obj.type = (fd[i]['datatype'].toString());
											obj.value = (fd[i]['value'].toString());
											obj.column = (fd[i]['datafield'].toString()); 
									    	}
											obj.action =  action_command;
											obj.view = "TV";
											ArrayFilterInsert.addItem(obj);
						}
					}
				 		if (sort_flag == false){  
	   			 				custom_datafield = sort_custom_datafield; 
	   							custom_text = sort_custom_text;
	   							custom_datatype = sort_custom_datatype;
	   							action_command = sort_action_command;
	   							SortFunction(evt);
	   			 		}
	   			 		sort_flag = true;
				
				addTotal(evt);	
				refreshButton(evt);
	    }
	    
	    
	    
	    private function removeItemsAH():void{
	    		for(var ia:int = 0; ia < ArrayFilterInsert.length; ia++){
							if (ArrayFilterInsert[ia].view == "AH"){
								ArrayFilterInsert.removeItemAt(ia);
							}
						
				}
	    }
	    



public function change_filtermacro_persistent_crunch(evt:Event):void {
	
	
	var obj:Object = new Object();
//	Alert.show("Act 12");
	ActionEventfromMain(evt);
//	Alert.show("Act 13");
	// Remove this for now.
	//removeItemsAH();
	ArrayFilterInsert.removeAll();
//	Alert.show("Act 13.5");
	//Alert.show("lbl_persistent_view.text: " + lbl_persistent_view.text.toString());
	for(var i:int = 0; i < fdp.length; i++){
//		Alert.show("Act 14");
		//if (lbl_persistent_view.text ==  fdp[i]['filtercode']){	 
			action_command   = fdp[i]['action'];
			
			obj = new Object();
			if (action_command == "clear"){
				obj.type = "";
				obj.value = "";      
				obj.column = ""; 
			}	else {
				
				
				
				var str:String = fdp[i]['value'].toString();
				
				str = str_replace("&gt;",">",str);
				str = str_replace("&lt;","<",str);
				
				
				
				obj.type = (fdp[i]['datatype'].toString()); 
				//obj.value = (fdp[i]['value'].toString());
				obj.value = str;
				obj.column = (fdp[i]['datafield'].toString()); 
			}
			
			obj.action =  action_command;
			obj.view = "PV";
			ArrayFilterInsert.addItem(obj);
			
		//}
	}
	
	
	
	if (sort_flag == false){
		custom_datafield = sort_custom_datafield; 
		custom_text = sort_custom_text;
		custom_datatype = sort_custom_datatype;
		action_command = sort_action_command;
		
		
		SortFunction(evt);
	}
	//Alert.show(ArrayFilterInsert.length.toString());
	//launchHistoryLog(evt);
}


	    public function change_filtermacro_persistent(evt:Event):void {
            	
            
				var obj:Object = new Object();
				//Alert.show("Act 12");
					ActionEventfromMain(evt);
				//	Alert.show("Act 13");
					// Remove this for now.
					//removeItemsAH();
					ArrayFilterInsert.removeAll();
				//	Alert.show("Act 13.5");
				//	Alert.show("lbl_persistent_view.text: " + lbl_persistent_view.text.toString());
					for(var i:int = 0; i < fdp.length; i++){
				//		Alert.show("Act 14");
							if (lbl_persistent_view.text ==  fdp[i]['filtercode']){	 
							action_command   = fdp[i]['action'];
							 
                						obj = new Object();
                					    	if (action_command == "clear"){
                					    	obj.type = "";
											obj.value = "";
											obj.column = ""; 
  	  		           				    	}	else {
												
												
												
												var str:String = fdp[i]['value'].toString();
												
												str = str_replace("&gt;",">",str);
												str = str_replace("&lt;","<",str);
													
												 
												 
                					    	obj.type = (fdp[i]['datatype'].toString());
											//obj.value = (fdp[i]['value'].toString());
											obj.value = str;
											obj.column = (fdp[i]['datafield'].toString()); 
                					    	}
											
											obj.action =  action_command;
											obj.view = "PV";
											ArrayFilterInsert.addItem(obj);
										
								
						}
					}
					
					//Alert.show(sort_flag.toString()); 
			
				 		if (sort_flag == false){
	   			 				custom_datafield = sort_custom_datafield; 
	   							custom_text = sort_custom_text;
	   							custom_datatype = sort_custom_datatype;
	   							action_command = sort_action_command;
								
									
	   							SortFunction(evt);
	   			 		}
						
	    }
	     private function change_columngroup(evt:Event):void {
	     	
	     	flagger(evt);
	    }
		private function change_columngroup_for_panels(evt:Event):void {
				
			panelPlacingExtensible(evt);
					set_columngroup_for_panels(evt, evt.currentTarget.columnstart);
					flagger(evt);
		}     

		private function set_columngroup_for_panels(evt:Event, columnstart_no:Number):void {
			
				if (columnstart_no == 0){
					dg.horizontalScrollPosition = 0;
				} else {
					dg.horizontalScrollPosition = columnstart_no - dg.lockedColumnCount;
				}	
		}
		

	    private function set_columngroup(evt:Event, idx_no:Number):void {
	   
	    }
	    
	    public var clickedColumn:String;
	    private function headRelEvt(event:AdvancedDataGridEvent):void {
	    	
			var loc_datatype:String = new String;
	    		for (var i:int=0;i<_xlcColumn.length;i++)  { 
			 			if (_xlcColumn[i]["dataField"] == event.dataField){
			 				loc_datatype = _xlcColumn[i]["datatype"]
							break;
			 			}
				}
			if (loc_datatype == "N"){
				clickedColumn = event.dataField;
			}	
	    }


	    
	 		private var obj_1:Object = new Object;
	 		private var obj_totalArray1:Object = new Object;
	 	 private function ca_sort(event:Event):void { 
	 		var ca_fieldname:String = new String;
	 		var ca_datatype:String = new String;
	 		cs_SortByArray = new ArrayCollection;
	 		cs_CAArray = new ArrayCollection;
			
			
			
	 		if (Array1.sort == null){   
	 			AlertMessageShow("Please select column(s) to Sort.");
	 			return;
	 		}
	 		
	 		
	 			if (Array1.sort.toString() != null){
				//	Alert.show("go here");
       			    var tot_column_str:String = new String();
           			var tot_value_str:String = new String();
           			var value_str:String = new String();
        	  			for (var i:int=0;i < Array1.sort.fields.length; i++)  {
							
        	  				var obj:Object = new Object();
        	  				ca_fieldname = new String;
	 						ca_datatype = new String;
        	  						ca_fieldname = Array1.sort.fields[i].name.toString();
									
										for (var c:int=0;c<_xlcColumn.length;c++)  { 
			 								var datafield:String = (_xlcColumn[c]["dataField"]).toString();
			 								var datatype:String = (_xlcColumn[c]["datatype"]).toString();
												if (ca_fieldname == datafield){
												  ca_datatype = (_xlcColumn[c]["datatype"]).toString();
												}
											}
        	  							obj.cs_field = ca_fieldname; 
										obj.cs_datatype = ca_datatype;
										cs_SortByArray.addItem(obj);
        	  			}
        	 			var obj_array1:Object = new Object();
        	 			var flag_ca:Boolean = new Boolean;
        	 			var final_flag_ca:Boolean= new Boolean;
        	 			cs_CAArray = new ArrayCollection;
        	 			 var cs_CAArray_ctr:int = 0; 
						 obj_totalArray1 = new Object;
						 for (var c_sortby:int=0;c_sortby<cs_SortByArray.length;c_sortby++){
											
												if (cs_SortByArray[c_sortby].cs_datatype == 'N'){
														var ctr_i_ca:Number= new Number;
														for (var ctr_i:int=0;ctr_i<Array1.length;ctr_i++){
															
															ctr_i_ca = ctr_i_ca + Number(Array1[ctr_i][cs_SortByArray[c_sortby].cs_field]);
															
														}
														
													obj_totalArray1[cs_SortByArray[c_sortby].cs_field] = ctr_i_ca;
        	 									}
												
       					}						
						 
						    
						 
        	 						for (var ctr_a1:int=0;ctr_a1<Array1.length;ctr_a1++){    // This for Array1 Array. 
										obj_1 = new Object();
										var str_unique:String = new String();
										for (var c_sortby:int=0;c_sortby<cs_SortByArray.length;c_sortby++){
											if (cs_SortByArray[c_sortby].cs_datatype != 'N'){
														obj_1[cs_SortByArray[c_sortby].cs_field] =  Array1[ctr_a1][cs_SortByArray[c_sortby].cs_field]; 
        	 										str_unique = str_unique + Array1[ctr_a1][cs_SortByArray[c_sortby].cs_field]
											}
										}    
											obj_1.upd_unique = str_unique + ctr_a1.toString();
        	 								obj_1.pct_instance = 0;
										if (ctr_a1 == 0){  // this record is a new one
        	 								obj_1.instance = 1; 
        	 								obj_1.pct_instance = (1 / Array2.length) * 100
        	 								obj_1.pct_instance = Math.round(obj_1.pct_instance * 100)/100 ;
      
      										for (var c_sortby:int=0;c_sortby<cs_SortByArray.length;c_sortby++){
												
												if (cs_SortByArray[c_sortby].cs_datatype == 'N'){
														obj_1[cs_SortByArray[c_sortby].cs_field] =  Number(Array1[ctr_a1][cs_SortByArray[c_sortby].cs_field]); 
														obj_1[cs_SortByArray[c_sortby].cs_field] = Math.round(obj_1[cs_SortByArray[c_sortby].cs_field] * 100)/100 ;
        	 											obj_1["pct_" + cs_SortByArray[c_sortby].cs_field] = (obj_1[cs_SortByArray[c_sortby].cs_field] / obj_totalArray1[cs_SortByArray[c_sortby].cs_field]) * 100;
        	 											obj_1["pct_" + cs_SortByArray[c_sortby].cs_field] = Math.round(obj_1["pct_" + cs_SortByArray[c_sortby].cs_field] * 100)/100 ;
														//Alert.show(obj_1[cs_SortByArray[c_sortby].cs_field].toString());
														/*
														var str_segment_array:Array = [];
														
														str_segment_array = obj_1[cs_SortByArray[c_sortby].cs_field].split(".");	
														if (str_segment_array[1].length > 1){
															str_segment_array[1] = str_segment_array[1].substr(0,2);
														}
														
														obj_1[cs_SortByArray[c_sortby].cs_field] = str_segment_array[0] + "." + str_segment_array[1]; 
												*/
												   
												}
        	 								}
											obj_1.upd_unique = str_unique + ctr_a1.toString();
        	 								cs_CAArray.addItem(obj_1);
        	 							} 
        	 							if (ctr_a1 > 0){  // this record is a new one
        	 								
        	 								var ret:Boolean = ca_find(obj_1,cs_CAArray);	
        	 								if (ret == false){
        	 									obj_1.instance = 1;
        	 									obj_1.pct_instance = (1 / Array2.length) * 100;
        	 									obj_1.pct_instance = Math.round(obj_1.pct_instance * 100)/100;
        	 									for (var c_sortby:int=0;c_sortby<cs_SortByArray.length;c_sortby++){
												
													if (cs_SortByArray[c_sortby].cs_datatype == 'N'){
														obj_1[cs_SortByArray[c_sortby].cs_field] =  Number(Array1[ctr_a1][cs_SortByArray[c_sortby].cs_field]); 
														obj_1[cs_SortByArray[c_sortby].cs_field] = Math.round(obj_1[cs_SortByArray[c_sortby].cs_field] * 100)/100 ;
														obj_1["pct_" + cs_SortByArray[c_sortby].cs_field] = (obj_1[cs_SortByArray[c_sortby].cs_field] / obj_totalArray1[cs_SortByArray[c_sortby].cs_field]) * 100;
        	 											obj_1["pct_" + cs_SortByArray[c_sortby].cs_field] = Math.round(obj_1["pct_" + cs_SortByArray[c_sortby].cs_field] * 100)/100 ; 
													
														
														
													//	Alert.show(obj_1[cs_SortByArray[c_sortby].cs_field].toString());
														/*
														var str_segment_array:Array = [];
														Alert.show(obj_1[cs_SortByArray[c_sortby].cs_field].toString());
														str_segment_array = obj_1[cs_SortByArray[c_sortby].cs_field].split(".");	
														if (str_segment_array[1].length > 1){
															str_segment_array[1] = str_segment_array[1].substr(0,2);
														}
														
														obj_1[cs_SortByArray[c_sortby].cs_field] = str_segment_array[0] + "." + str_segment_array[1]; 
														*/
													
													}
        	 									
        	 									}
												obj_1.upd_unique = str_unique + ctr_a1.toString();
         	 									cs_CAArray.addItem(obj_1); 
        	 								}
        	 								if (ret == true){
        	 									obj_1.instance = idx_CAArray;
        	 									var i_pct:Number = (idx_CAArray / Array2.length) * 100;
        	 									obj_1.pct_instance = i_pct;
        	 									obj_1.pct_instance = (Math.round(obj_1.pct_instance * 100)/100);
        	 									for (var c_sortby:int=0;c_sortby<cs_SortByArray.length;c_sortby++){
													if (cs_SortByArray[c_sortby].cs_datatype == 'N'){
														obj_1[cs_SortByArray[c_sortby].cs_field] = Number(obj_num[cs_SortByArray[c_sortby].cs_field]) + Number( Array1[ctr_a1][cs_SortByArray[c_sortby].cs_field]);
														obj_1[cs_SortByArray[c_sortby].cs_field] = Math.round(obj_1[cs_SortByArray[c_sortby].cs_field] * 100)/100 ;
														obj_1["pct_" + cs_SortByArray[c_sortby].cs_field] = (obj_1[cs_SortByArray[c_sortby].cs_field] / obj_totalArray1[cs_SortByArray[c_sortby].cs_field]) * 100;
        	 											obj_1["pct_" + cs_SortByArray[c_sortby].cs_field] = Math.round(obj_1["pct_" + cs_SortByArray[c_sortby].cs_field]);
        	 										
														//Alert.show(obj_1[cs_SortByArray[c_sortby].cs_field].toString());
														/*
														var str_segment_array:Array = [];
														
														str_segment_array = obj_1[cs_SortByArray[c_sortby].cs_field].split(".");	
														if (str_segment_array[1].length > 1){
															str_segment_array[1] = str_segment_array[1].substr(0,2);
														}
														
														obj_1[cs_SortByArray[c_sortby].cs_field] = str_segment_array[0] + "." + str_segment_array[1]; 
															
													*/
													}
        	 									}
        	 									cs_CAArray.removeItemAt(ctr_CAArray);
												obj_1.upd_unique = str_unique + ctr_a1.toString();
        	 									cs_CAArray.addItem(obj_1);
        	 								}
        	 							}
        	 						} 
        	 						
       			
       			} 
				
				 
				// Lets leave this for now.
       			launchCrunchAnalysis(event, 'Grand Total'); 
	    }

			private function ca_find(obj_pass:Object, cs_i_CAArray:ArrayCollection):Boolean{
				
					var main_flag:Boolean = false;
					var main_final_flag:Boolean = false;
			
				for (var ctr:int=0;ctr<cs_i_CAArray.length;ctr++){
					var a_flag:Boolean = true;
					var a_final_flag:Boolean = true;
						for (var c_sortby:int=0;c_sortby<cs_SortByArray.length;c_sortby++){
							if (cs_SortByArray[c_sortby].cs_datatype != 'N'){
									a_flag = true;
								if (obj_pass[cs_SortByArray[c_sortby].cs_field] == cs_i_CAArray[ctr][cs_SortByArray[c_sortby].cs_field]){
									a_flag = true;
								
								}else{
									a_flag = false;
								}
									a_final_flag = a_final_flag && a_flag;
							}
						}
						
						main_flag = a_final_flag;		
						main_final_flag = main_final_flag || main_flag;
						if (main_final_flag == true){
							idx_CAArray = cs_CAArray[ctr].instance + 1;
							ctr_CAArray = ctr;
							obj_num = new Object;							
						 	for (var c_sortby:int=0;c_sortby<cs_SortByArray.length;c_sortby++){
								if (cs_SortByArray[c_sortby].cs_datatype == 'N'){
									obj_num[cs_SortByArray[c_sortby].cs_field] = Number(cs_i_CAArray[ctr][cs_SortByArray[c_sortby].cs_field]);
									
								}
							}
						 
						}
				}
				return main_final_flag;
			}
			public var pop404:CrunchAnalysis; 

            private function launchCrunchAnalysis(event:Event, str_title:String):void {
				 
				//parentApplication.drillDownCrunch(event,cs_SortByArray,_xlcColumn,cs_CAArray,str_title,my_sid,my_c_code1);    
			//	Alert.show("go to crunch");
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
		
			
				
				 
				
				
				//Alert.show(myview_flag.toString());
				//pop404.local_fd = fd_crunch;  
				//Alert.show("Check check 1");
				pop404.local_fdp = fdp_crunch;   
				//Alert.show("Check check 2");
				//Alert.show("pop404.newObject1.fdp: " + pop404.newObject1.fdp.length.toString());
				//Alert.show("lbl_persistent_view.text: " + lbl_persistent_view.text);
				//pop404.newObject1.lbl_persistent_view.text = lbl_persistent_view.text;
				//Alert.show("Doesn't sound the same"); 
				//pop404.newObject1.change_filtermacro_persistent_crunch(event);
				//Alert.show("Check check 3");
				//Alert.show("Array Filter Insert: " + pop404.newObject1.ArrayFilterInsert.length.toString());
				//pop404.newObject1.ArrayFilterInsert = pop404.newObject1.ArrayFilterInsert;
				//pop404.newObject1.refreshButton(event);   
				 
				/*
				
				
				Alert.show("Array Filter Insert: " + pop404.newObject1.ArrayFilterInsert.length.toString());
				//	pop404.newObject1.lbl_transient_view.text = 'No selection';
				Alert.show("Check check 4");
				pop404.newObject1.refreshButton(event);     
				Alert.show("Check check 5"); 
				*/
				
				
				//  Retrieve Chart 
				if   (myview_flag == 1){ 
						ntchart = new Timer(TIMER_INTERVAL_CHART);
						ntchart.addEventListener(TimerEvent.TIMER, nt_updatechart); 
						ntchart.start();
						
				}		
						   
						/*
				pop404["btn_keepnumberofrow"].addEventListener( MouseEvent.CLICK,keepNoOfRows);  
				pop404["btn_keepnumberofrow"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop404["btn_keepnumberofrow"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				*/
				
				
						pop404["btn_showChart"].addEventListener( MouseEvent.CLICK,showChart_crunch);  
						pop404["btn_showChart"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
						pop404["btn_showChart"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
						
						
						
						pop404["btn_cancel_mc"].addEventListener( MouseEvent.CLICK,update_mylevel);     
						pop404["btn_cancel_mc"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
						pop404["btn_cancel_mc"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
						
						
						pop404["btn_cancel_mc_back"].addEventListener( MouseEvent.CLICK,update_mylevel);     
						pop404["btn_cancel_mc_back"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
						pop404["btn_cancel_mc_back"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
						
						
						
							
						
						pop404["btn_saveCrunch"].addEventListener( MouseEvent.CLICK,saveCrunch);
						pop404["btn_saveCrunch"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
						pop404["btn_saveCrunch"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
					
						
						
						
						pop404["btn_viewSettings"].addEventListener( MouseEvent.CLICK,launchHistoryLog);
						pop404["btn_viewSettings"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
						pop404["btn_viewSettings"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				    
						
    		}

public var popkeepNumberofRows:MaximumNumberOfRows; 
public function keepNoOfRows(event:Event):void{
	//	Alert.show("go here");
	/*
	var arr:Array = new Array;
	
	arr[0] = 8;
	arr[1] = 9;
	arr[2] = 10;
	dg.selectedIndices = arr;
	*/
	
	if (crunch == false){
		AlertMessageShow("This function only works on the Crunch Actiongrid");
		return;
	}
	
	popkeepNumberofRows = MaximumNumberOfRows(
		PopUpManager.createPopUp(this, MaximumNumberOfRows, true));
	PopUpManager.centerPopUp(popkeepNumberofRows); 
	
	
	
	popkeepNumberofRows["ti_mnr"].addEventListener(Keyboard.ENTER,submitNumberofRows);
	popkeepNumberofRows["btn_nr_submit"].addEventListener(MouseEvent.CLICK,submitNumberofRows);
	
	
} 

private function submitNumberofRows(event:Event){ 
	/*
	if (popkeepNumberofRows.rb_all.selected == true){
		Alert.show("All");
	} else {
		Alert.show(popkeepNumberofRows.ti_mnr.text);
	}
	*/
	if (popkeepNumberofRows.ti_mnr.text.length <1){
		AlertMessageShow("Please enter the maximum number of row(s)");
		return;
	} 
	
	var ArrNumOfRows:Array = new Array;
	var max_numberofrow:int = int(popkeepNumberofRows.ti_mnr.text); 
	/*
	for (var ctr:int=0;ctr<max_numberofrow;ctr++){
		ArrNumOfRows[ctr] = ctr;
	}
	
	dg.selectedIndices = ArrNumOfRows;
	choose_numberofrows(event);
	
	*/ 
	PopUpManager.removePopUp(popkeepNumberofRows);
	
	aFormFields[0]['text'] = max_numberofrow;
	aFormFields[0]['data_field'] = "Maximum Row";
	aFormFields[0]['data_type'] = "S";
	help_keep_number(event);
	aFormFields[0]['text'] = "";
	aFormFields[0]['data_field'] = "";
}


/*
pop9 = SubCrunchEntry(
	PopUpManager.createPopUp(this, SubCrunchEntry, true));
pop9.arr_colsorted = cb_sorted;
PopUpManager.centerPopUp(pop9); 
pop9["btn_sc_submit"].addEventListener("click", crunch_subtotal); 
pop9["btn_sc_submit"].addEventListener(KeyboardEvent.KEY_DOWN, enterHandlerST);


pop9["btn_sc_submit"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
pop9["btn_sc_submit"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
*/






private const TIMER_INTERVAL_CHART:int = 2000;
private var ntchart:Timer;   

private function nt_updatechart(evt:TimerEvent):void {
	ntchart.stop();
	//showChart_crunch(evt); 
	checkMVChart(evt);
}



private function checkMVChart(event:Event):void{
	reqSJ = "";
	//reqParmsMyViewParameters = "REFRESH,UPD_MV_QUERY," + myName_main + "," + mainBoard + ","+ popcmmyviews.inputcode.text + "," +  popcmmyviews.inputdescription.text + "," +  history_reqParms_str;
	reqParmsmvquery = "REFRESH,RETRIEVE|MV_CHART|" + myName_main + "|" + mainBoard + "|"+_xlcRenditionCode+ "|";
	
	retrievemvchart.send();
	
	
}   



			public var popshowChart_crunch:ShowChart; 
			public function showChart_crunch(event:Event):void{
			//	Alert.show("go here");
					popshowChart_crunch = ShowChart(
								PopUpManager.createPopUp(this, ShowChart, true));
					popshowChart_crunch.ObjectCollection_mfArray = pop404.newObject1.Array1; 
					popshowChart_crunch.mfArray = pop404.newObject1.Array1; 
					popshowChart_crunch.ca_xlcColumn = pop404.newObject1._xlcColumn; 
					popshowChart_crunch.adv_mfArray = pop404.newObject1.dg;
					popshowChart_crunch.cap_title = pop404.crunchtitle.text;
					popshowChart_crunch.showlocal_crunch = pop404.local_crunch;
					popshowChart_crunch.par_select = 0; 
					popshowChart_crunch.par_type = 0; 
					popshowChart_crunch.par_maxnum = pop404.newObject1.Array1.length;
					//popshowChart_crunch.percentWidth = 100;
					//popshowChart_crunch.percentHeight = 100;
					
					  
					   
					
					popshowChart_crunch["btn_savechart"].addEventListener(MouseEvent.CLICK,saveChart_Grandtotal);
					popshowChart_crunch["btn_close"].addEventListener(MouseEvent.CLICK,closeChart);
					popshowChart_crunch["btn_close_back"].addEventListener(MouseEvent.CLICK,closeChart);
			}



			private function closeChart(event:Event):void{
				myview_level = 1;
				
				PopUpManager.removePopUp(popshowChart_crunch);
			}


			private function showChart_crunch_parameter(event:Event, select:int, type:int, maxnum:int):void{    
				 
				popshowChart_crunch = ShowChart(
					PopUpManager.createPopUp(this, ShowChart, true));
				popshowChart_crunch.ObjectCollection_mfArray = pop404.newObject1.Array1; 
				popshowChart_crunch.mfArray = pop404.newObject1.Array1; 
				popshowChart_crunch.ca_xlcColumn = pop404.newObject1._xlcColumn; 
				popshowChart_crunch.adv_mfArray = pop404.newObject1.dg;
				popshowChart_crunch.cap_title = pop404.crunchtitle.text;
				popshowChart_crunch.showlocal_crunch = pop404.local_crunch;
				popshowChart_crunch.par_select = select;
				popshowChart_crunch.par_type = type;
				popshowChart_crunch.par_maxnum = maxnum;
					
				/*
				popshowChart_crunch.par_select = select;
				popshowChart_crunch.par_type = type
				 */
				
				    
				
				popshowChart_crunch["btn_savechart"].addEventListener(MouseEvent.CLICK,saveChart_Grandtotal);
				popshowChart_crunch["btn_close"].addEventListener(MouseEvent.CLICK,closeChart);
				popshowChart_crunch["btn_close_back"].addEventListener(MouseEvent.CLICK,closeChart);
				
			}



			private function saveChartGrandtotal(event:Event):void{
				Alert.show("go here");
			}


			

           private function update_mylevel(event:Event):void{
			   myview_flag = 0;
		   	myview_level = 0;
			
			PopUpManager.removePopUp(pop404);
			//closeMyView(event);
			updateMyViewSequence(event);
		   }
           // public var popshowChart:ShowChart; 
    		private function showChart_old(event:Event):void {
    		/*
    			popshowChart = ShowChart(
                PopUpManager.createPopUp(this, ShowChart, true));
                popshowChart.mfArray = cs_CAArray; 
                popshowChart.ca_xlcColumn = _xlcColumn; 
      //          popshowChart.adv_mfArray = pop404.adg1;
                popshowChart.cap_title = pop404.crunchtitle.text;
               	
               	popshowChart["btn_viewSettings"].addEventListener( MouseEvent.CLICK,launchHistoryLog);
				popshowChart["btn_viewSettings"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				popshowChart["btn_viewSettings"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
               	popshowChart["btn_close"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				popshowChart["btn_close"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
			  */
			   	}
		
			
			
            private var pre_ts_check:ArrayCollection = new ArrayCollection;
            private function TotalSelected(event:Event):void{
            
            	PopUpManager.removePopUp(popActions);
            	// Create an Array to check for multiple and repeating Numeric columns.
            	// It may be possible that Numeric columns may repeat based on the XML Header Doc.
            	if (dg.selectedItems.length < 1){ 
            		AlertMessageShow("Please select row(s).");
            		return;
            	}
            	
            	pre_ts_check  = new ArrayCollection;
            	var pre_flag:Boolean = new Boolean;
            	 	for (var i:int=0;i<_xlcColumn.length;i++)  { 
			 			pre_flag = false;
			 				var columnId:String = (_xlcColumn[i]["columnId"]);
			 				var title_header:String = (_xlcColumn[i]["title_header"]);
			 				var width:String = (_xlcColumn[i]["width"]);
			 				var datafield:String = (_xlcColumn[i]["dataField"]).toString();
			 				var datatype:String = (_xlcColumn[i]["datatype"]).toString();
            	 	
            	 			if (_xlcColumn[i]["datatype"] == "N"){
            					for (var ia:int=0;ia<pre_ts_check.length;ia++)  { 
            						if (pre_ts_check[ia] == _xlcColumn[i]["dataField"]){
            							pre_flag = true;
            							break; 
            						}
            					}
            					if (pre_flag == false){
            	 					pre_ts_check.addItem(_xlcColumn[i]["dataField"]);
            	 				}
            	 			}
            	 	}
            		
            	var obj:Object = new Object;
            	obj = new Object;
            	ArrayTotalSelected = new ArrayCollection;	
            	var int_total:int = new int;
            	obj.column = "Instance";
            	obj.total = numberFormatter.format(dg.selectedItems.length);
            		ArrayTotalSelected.addItem(obj);
            		for (var ib:int=0;ib<pre_ts_check.length;ib++){
            				int_total = 0;
            				obj = new Object;
            				for (var ic:int=0;ic<dg.selectedItems.length;ic++){
            							int_total = int_total + Number(dg.selectedItems[ic][pre_ts_check[ib]]);
            				}
            				
            				var forcol:String = new String();
							for (var ix:int=0;ix<_xlcColumn.length;ix++)  {
								if (pre_ts_check[ib] == _xlcColumn[ix]["dataField"]){
									forcol = _xlcColumn[ix]["title_header"];
								}
							}
							obj.column = forcol;     
							//obj.column = [pre_ts_check[ib]];
            				obj.total = numberFormatter.format(int_total);
            				ArrayTotalSelected.addItem(obj);
            		}	 	
            			
            		launchTotalSelectedRow(event);
            }
			
			
		     public var poptotsel:TotalSelectedRow;
		     
            private function launchTotalSelectedRow(event:Event):void {
            	
               	poptotsel = TotalSelectedRow(
                PopUpManager.createPopUp(this, TotalSelectedRow, true));
                poptotsel.mfArray_TotalSelected = ArrayTotalSelected;
   		        poptotsel["dg_2"].addEventListener(KeyboardEvent.KEY_DOWN,  enterTotalSelected_dg);
   		    }
   		    
   		    private function enterTotalSelected(event :KeyboardEvent):void{
					if (event.keyCode == Keyboard.ENTER)
					{
						removeMe_totsel(event);
					}
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_totsel(event);
					}
   			}
		   
   			private function enterTotalSelected_dg(event :KeyboardEvent):void{
   				
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_totsel(event);
					}
   			}
   			
   			
   			
   			public var pophdr:HistoryDateRange;
		     
            private function launchHistoryDateRange(event:Event):void {
            	
               	pophdr = HistoryDateRange(
                PopUpManager.createPopUp(this, HistoryDateRange, true));
                pophdr.daterange_fromdate = history_daterange_from;
                pophdr.daterange_todate = history_daterange_to; 
                
                pophdr["btn_submit"].addEventListener("click",  HistoryDateRangeSubmit); 
                pophdr["btn_submit"].addEventListener(KeyboardEvent.KEY_DOWN,  hdr_esckey);
                pophdr["btn_cancel"].addEventListener(KeyboardEvent.KEY_DOWN,  hdr_esckey);
                pophdr["from_dateField"].addEventListener(KeyboardEvent.KEY_DOWN,  hdr_esckey);
                pophdr["to_dateField"].addEventListener(KeyboardEvent.KEY_DOWN,  hdr_esckey);
   		    }
 		    
   		    public var pophrmp:HistoryRetrievalMultipleParameters;
			public var poptotsel1:TotalSelectedRow;

		    public function launchHistoryRetrievalMultipleParameters(event:Event, f_di:String):void {
               	
				   
              	pophrmp = HistoryRetrievalMultipleParameters(
                PopUpManager.createPopUp(this, HistoryRetrievalMultipleParameters, true));   
	
			    
				pophrmp.mfArray = _xlcColumnQuery.toArray()
					
				
				pophrmp.pageType = 'regular';
				pophrmp.mb_sq = mainBoard;
				pophrmp.cc_sq = my_c_code1;
				pophrmp.sid_sq = my_sid;
				
				pophrmp.user_sq = myName_main;	
					
					//Alert.show(historyParametersQuery.length.toString());
				pophrmp.mb_title = _xlcTitle   
				pophrmp.filluphistoryParameters = historyParametersQuery; 
				pophrmp.dynamicindicator = f_di;     
                
				pophrmp["btn_nr"].addEventListener("click", historyNewRetrieval); 
   		        pophrmp["btn_nr"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmp["btn_nr"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
   		        pophrmp["btn_atc"].addEventListener("click", historyCurrentRetrieval);
   		        pophrmp["btn_atc"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmp["btn_atc"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				
				pophrmp["btn_cmv1"].addEventListener("click", callMyView);
				pophrmp["btn_cmv1"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmp["btn_cmv1"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				
				
				pophrmp["btn_close"].addEventListener("click", closehistoryNewRetrieval);    
				pophrmp["btn_close"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmp["btn_close"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
			
				
				pophrmp["btn_dmc"].addEventListener("click", displayLotComp); 
				pophrmp["btn_dmc"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmp["btn_dmc"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				pophrmp["btn_dls"].addEventListener("click", displayLotSet); 
				pophrmp["btn_dls"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmp["btn_dls"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				pophrmp["btn_ecs"].addEventListener("click", enterComponentSearch); 
				pophrmp["btn_ecs"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmp["btn_ecs"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				
				pophrmp["btn_cmv2"].addEventListener("click", callMyView);  
				pophrmp["btn_cmv2"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmp["btn_cmv2"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				pophrmp["btn_close2"].addEventListener("click", closehistoryNewRetrieval); 
				pophrmp["btn_close2"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmp["btn_close2"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				PopUpManager.centerPopUp(pophrmp);
				
				}
private var req_sq = new String;
			public function enterComponentSearch(event:Event):void{
				
				req_sq = new String();
				var final_sq:String = new String;
				for(var i:int = 0; i < pophrmp.dg_2.dataProvider.length; i++){
					var det_sq:String = new String;
					var dg_type:String = pophrmp.dg_2.dataProvider[i].datatype;
					var dg_cn:String = pophrmp.dg_2.dataProvider[i].dataField;
					var dg_ht:String = pophrmp.dg_2.dataProvider[i].value;
					dg_ht = c_utils.trim(dg_ht);
					if (dg_ht.length >1 ){
						det_sq = "type:" + dg_type +"," +
							"col:" + dg_cn +"," +
							"val:" + dg_ht +";";
					}
					final_sq = final_sq + det_sq;
				}
				final_sq = final_sq.substr(0, final_sq.length - 1);
				// req_sq = req_sq + query_sg_header + final_sq + query_sg_footer + "|";
				req_sq = req_sq + final_sq  + "|";
				
				
				
				var loc_client:String = "";
				var loc_product:String = "";
				
			
				for(var i:int=0;i<pophrmp.myDPColl.length;i++){
					if (pophrmp.myDPColl[i]["dataField"] == 'client'){
						loc_client = pophrmp.myDPColl[i]["value"]
					}
					if (pophrmp.myDPColl[i]["dataField"] == 'product'){
						loc_product = pophrmp.myDPColl[i]["value"]
					}
				}
				displayLot = xmlLineUpforLot(event, pophrmp.myDPColl);
				reqParms = "REFRESH,RETRIEVE|LOTCOMP|" + loc_client + "|" + loc_product + "|";
				
				retrieve_componentsearch.send();
			
			}
			private function displayLotSet(event:Event):void{
				
				var retval:String = new String;
				launchErgo();
				retval= xmlLineUpforLot(event, pophrmp.myDPColl);
				retval = retval + "<lotdisp>LOTSET</lotdisp>"
				rettype = "new"; 
				reqParms = retval;
				
				
				RetainQuery(event);
				
				
				historyParameterInput();
				dataList_history.send();   
			}


			private function RetainQuery(event:Event):void{
				
				///////////////////////
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
				
				//////////////////////////
				
			
			}



			private function displayLotComp(event:Event):void{ 
				launchErgo();
				var retval:String = new String;    
				retval= xmlLineUpforLot(event, pophrmp.myDPColl);
				retval = retval + "<lotdisp>LOTCOMP</lotdisp>"
				rettype = "new"; 
				reqParms = retval;
				RetainQuery(event);
				historyParameterInput();
				dataList_history.send();   
			}
   		    public function searchReplace(block:String, find:String, replace:String):String 
			{ 
    				return block.split(find).join(replace); 
			} 
   			
   			private function HistoryDateRangeSubmit(event :Event):void{
   				
					if (pophdr.from_dateField.text > pophdr.to_dateField.text){
						AlertMessageShow("From Date should not be greater than To Date.");
						return;
					}
					reqParms = "REFRESH," + mainBoard + ",FROM," + searchReplace(pophdr.from_dateField.text, "-", "") + ",TO," + searchReplace(pophdr.to_dateField.text, "-", "") + "," + myName_main; 
				
				history_daterange_from = pophdr.from_dateField.text;
 				history_daterange_to = pophdr.to_dateField.text;
				
				
					removeMe_hdr(event);    
					launchErgo();
					dataList_history.send();
					
			}
   			
   			 private function hdr_esckey(event :KeyboardEvent):void{
					
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_hdr(event);
					}
   			}
   		
   		
   			private function doubleclickHandler_old(event: ListEvent):void{
   				
 
					// Get the target of this event (Datagrid) 
						var dataGrid:AdvancedDataGrid = event.target as AdvancedDataGrid; 
					// Get selected column index 
						var columname:String = new String;
						var dsColumnIndex:Number = event.columnIndex; 
				
							var col:DataGridColumn = dataGrid.columns[dsColumnIndex]; 
   				return;
   			}
   			
   			/////////////  Export Datagrid to EXCEL function //////
   			
   			function doCopy(dg)
{
	var font = dg.getStyle('fontFamily');
	var size = dg.getStyle('fontSize');
	var hcolor ;
	if(dg.getStyle("headerColor") != undefined) hcolor = [dg.getStyle("headerColor")];
	else hcolor = dg.getStyle("headerColors");
	var str:String = '<html><body><table width="'+dg.width+'"><thead><tr width="'+         dg.width+'" style="background-color:#' +Number((hcolor[0])).toString(16)+'">';
	for(var i:int=0;i<dg.__columns.length;i++)
	{
	var colors = dg.getStyle("themeColor");
	var style = 'style="font-family:'+font+';font-size:'+size+'pt;"';
			
		if(dg.__columns[i].headerText != undefined)
		{
			str+="<th "+style+">"+dg.__columns[i].headerText+"</th>";
		}
		else
		{
			str+= "<th "+style+">"+dg.__columns[i].columnName+"</th>";
		}
	}
		str += "</tr></thead><tbody>";
	var colors = dg.getStyle("alternatingRowColors");
	for(var j:int=0;j<dg.length;j++)
	{
		str+="<tr width=\""+Math.ceil(dg.width)+"\" style='background-color:#" +Number((colors[j%colors.length])).toString(16)+"'>";
		var style = 'style="font-family:'+font+';font-size:'+size+'pt;"';
			
		for(i=0;i<dg.__columns.length;i++)
		{
			if(dg.getItemAt(j) != undefined && dg.getItemAt(j) != null)
				if(dg.__columns[i].labelFunction != undefined)
					str += "<td width=\""+Math.ceil(dg.__columns[i].width)+"\" "+style+">"+dg.__columns[i].labelFunction(dg.getItemAt(j),dg.__columns[i].columnName)+"</td>";
				else
					str += "<td width=\""+Math.ceil(dg.__columns[i].width)+"\" "+style+">"+dg.getItemAt(j)[dg.__columns[i].columnName]+"</td>";
			
		}
		str += "</tr>";
	}
	str+="</tbody></table></body></html>";
	System.setClipboard(str);
}

		private function doubleclickHandler(event:ListEvent):void {
			// Get the target of this event (Datagrid)
			 
			var dataGrid:AdvancedDataGrid = event.target as AdvancedDataGrid;
			// Get selected column index
			var dsColumnIndex:Number = event.columnIndex;
			// based on the selected column index
			// Get the DataGridColumn object to get the selected column name
			var col:AdvancedDataGridColumn = dataGrid.columns[dsColumnIndex];
			// Get selected cell value from the selected row and column name   
			var newValue:String = dataGrid.selectedItem[col.dataField];   
				if (_xlcColumn[dsColumnIndex]["drilldown"] == 'yes'){	
					var xml_str_par:String = new String;
					for(var i:int=0;i<_xlcColumn.length - 1;i++){
						xml_str_par = xml_str_par + '<' + _xlcColumn[i]['dataField'] + '>' + dataGrid.selectedItem[_xlcColumn[i]['dataField']] + '</' +  _xlcColumn[i]['dataField'] + '>'
					}       
			
					
					/* Now on to mulitple actiongrid drill down.  */
					if (_xlcColumn[dsColumnIndex]["drilldown_multiple"] !== 'yes'){
							xml_str_par = "<hyperlink><linkvars>" + _xlcColumn[dsColumnIndex]["drilldownvariables"] + "</linkvars>" 
								+ "<linkkeynum>" + _xlcColumn[dsColumnIndex]["drilldownkeynum"] + "</linkkeynum>"
								+ xml_str_par + "</hyperlink>" ;
							parentApplication.drillDownActionGrid(event,xml_str_par,_xlcColumn[dsColumnIndex]['drilldowntoactiongrid'],_xlcTitle);
					} else {
						var obj_param:Object = new Object;
						obj_param = checkActionGridfromDrilldownMultiple(dataGrid.selectedItem[_xlcColumn[dsColumnIndex]["drilldown_multiple_from_column"]], _xlcColumn[dsColumnIndex]["drilldown_multiple_to_actiongrid"])
						
						if (obj_param.ret_data == "no_link"){
							AlertMessageShow("Unknown Data Type: " + dataGrid.selectedItem[_xlcColumn[dsColumnIndex]["drilldown_multiple_from_column"]]); 
							return;
						}
						xml_str_par = "<hyperlink><linkvars>" + obj_param.ret_linkvar + "</linkvars>" 
							+ "<linkkeynum>" + obj_param.ret_linkkeynum + "</linkkeynum>"
							+ xml_str_par + "</hyperlink>" ;
						parentApplication.drillDownActionGrid(event,xml_str_par,obj_param.ret_actiongrid,_xlcTitle);

					}	
				}	    
				if (_xlcColumn[dsColumnIndex]["edocs"] == 'yes'){
					
					if (newValue.length > 0){
						var edoc_str:String = "e-doc/" + newValue ;
						
						var urlpass:String = edoc_str;
						var url:URLRequest = new URLRequest(urlpass);      
						
						
						navigateToURL(url, "_blank");
		
						
					}   
				}
				if (_xlcColumn[dsColumnIndex]["externallink"] == 'yes'){
			
					for(var x:int=0;x<tdObjectCollection.length;x++){
						if (tdObjectCollection[x]['upd_unique'] == Array1[dataGrid.selectedIndex]['upd_unique']){
								var urlpass:String = tdObjectCollection[x][_xlcColumn[dsColumnIndex]["externalurl"]];
							
							
							var url:URLRequest = new URLRequest(urlpass);      
							navigateToURL(url, "_blank");	
								
								
								
						}
					}
					
				}
			   
		}


			private function checkActionGridfromDrilldownMultiple(str_ddfc:String, str_ddta:String):Object{
				
				var arrcoll_level1:Array = [];
				var arrcoll_level3:ArrayCollection = new ArrayCollection;
				var obj:Object = new Object;
				var retobj:Object = new Object;
				arrcoll_level1 = str_ddta.split(";");	
				
				if (arrcoll_level1.length < 1){
					AlertMessageShow("Unknown value to a Hyperlinked Actiongrid"); 
					retobj = new Object;
					retobj.ret_data = "no_link";
					return retobj;
				}
				/*  This is gonna be complicated, I would like to make it simple but it seems impossible. Stay with me on this. */
				for(var i:int=0;i<arrcoll_level1.length ;i++){
					
					
					var arrcoll_level2:Array = [];
					arrcoll_level2 = arrcoll_level1[i].split(":");
					obj = new Object;
					obj.str_data = arrcoll_level2[0];
					obj.str_actiongrid = arrcoll_level2[1];
					obj.str_linkvar = arrcoll_level2[2];
					obj.str_linkkeynum = arrcoll_level2[3];
					arrcoll_level3.addItem(obj);   
					
				}      
				   
			
				var flag:Boolean = false;
				for(var y:int=0;y<arrcoll_level3.length ;y++){
					if (str_ddfc == arrcoll_level3[y]["str_data"]){
						retobj = new Object;
						retobj.ret_data = arrcoll_level3[y]["str_data"];
						retobj.ret_actiongrid = arrcoll_level3[y]["str_actiongrid"];
						retobj.ret_linkvar = arrcoll_level3[y]["str_linkvar"];
						retobj.ret_linkkeynum = arrcoll_level3[y]["str_linkkeynum"];
						flag = true;
						break;
					} 
					
				}
					
				
				if (flag == true){
				return retobj;
				}
				else {
					retobj = new Object;
					retobj.ret_data = "no_link";
					return retobj;
				}
				
			}

			private function checkso(event:Event):void{
				var ag_speed_options:String = parentApplication.speed_options;
				if (parentApplication.speed_options =='standard'){
					img_query.source="image/ico_query.png";
					img_flash_filter.source='image/ico_flash_filter.png'
				}
			}


			


			private function determineRefreshQuery():void{   
				if (_xlcHistory != "Yes"){
				lbl_query.text = "Refresh"; //dbrefresh.toolTip = "Retrieves and displays any new/changed data from the database. IF this data MATCHES the current column filters.  A 'History database refresh involves collecting information that rarely or does NOT change (i.e. 'Shipped Orders' action gird in the WMS History HighView)";
				}else {
				lbl_query.text = "Query";
				}
				
			}





		private function httpRequestUrlDatagrid(str_app:String):void{
			/*  I will just leave this for vl and ml for now.  I believe there will be another one coming for the mobileweb */
			if (str_app == 'ml'){
		
				 httpAYT.url = 'ae_tlch_ml_req.php'; 
				 dataList_2.url = 'ae_tlch_ml_req.php'; 
				 retrieve_componentsearch.url = 'ae_tlch_ml_req.php'; 
				 dataList_history.url = 'ae_tlch_ml_req.php'; 
				 dateRange_history.url = 'ae_tlch_ml_req.php'; 
				 propertiesList.url = 'ae_tlch_ml_req.php';  
				 dataList.url = 'ae_tlch_ml_req.php';  
				 mbdmodule_getpropertylist.url = 'ae_tlch_ml_req.php'; 
				 filterheaderlist.url = 'ae_tlch_ml_req.php';   
				 filterdetaillist.url = 'ae_tlch_ml_req.php';   
				 deletelist.url = 'ae_tlch_ml_req.php';  
				 deletefiltercodes.url = 'ae_tlch_ml_req.php';  
				 defaultpersistentview.url = 'ae_tlch_ml_req.php';  
				 createupdate.url = 'ae_tlch_ml_req.php';  
				 createheadermm.url = 'ae_tlch_ml_req.php';  
				 SubmitDDOpsSec.url = 'ae_tlch_ml_req.php';  
				 SubmitOprGroup.url = 'ae_tlch_ml_req.php';  
				 navigateToJobProgram.url = 'ae_tlch_ml_req.php'; 
				 validate_copytogroup.url = 'ae_tlch_ml_req.php';  
				 ActionButtons.url = 'ae_tlch_ml_req.php'; 
				 add_maintain_operatorgroup.url = 'ae_tlch_ml_req.php'; 
				 delete_maintain_operatorgroup.url = 'ae_tlch_ml_req.php'; 
				 retrieve_maintainrendition.url = 'ae_tlch_ml_req.php'; 
				 retrieve_maintainview.url = 'ae_tlch_ml_req.php'; 
				 retrieve_groupforoperators.url = 'ae_tlch_ml_req.php'; 
				 add_maintain_operator.url = 'ae_tlch_ml_req.php'; 
				 delete_maintain_operator.url = 'ae_tlch_ml_req.php';
				 createheadermm2.url = 'ae_tlch_ml_req.php';
				 filterheaderlist2.url = 'ae_tlch_ml_req.php';
				 retrieve_operator.url = 'ae_tlch_ml_req.php';
				 exporttoxml.url = 'ae_tlch_ml_req.php';
				 unlock_operator.url = 'ae_tlch_ml_req.php';
				 MyViewButtons.url = 'ae_tlch_ml_req.php';
				 getColumnSettings.url = 'ae_tlch_ml_req.php';
				 updatemyview_sequence.url = 'ae_tlch_ml_req.php';
				 retrievemvchart_subtotal.url = 'ae_tlch_ml_req.php';
				 retrievemvchart.url = 'ae_tlch_ml_req.php';
				 saveMyViewChartHTTP.url = 'ae_tlch_ml_req.php';
				 saveMyViewCrunchSubHTTP.url = 'ae_tlch_ml_req.php';
				 retrievemvcrunch.url = 'ae_tlch_ml_req.php';
				 retrievemvquery.url = 'ae_tlch_ml_req.php';
				 saveMyViewCrunchHTTP.url = 'ae_tlch_ml_req.php';
				 saveMyViewQueryHTTP.url = 'ae_tlch_ml_req.php';
				 saveMyViewFilters.url = 'ae_tlch_ml_req.php';
				 saveMyViewColumns.url = 'ae_tlch_ml_req.php';
				 saveMyViewHeader.url = 'ae_tlch_ml_req.php';
				 saveMyViewOldRenditionPerstent.url = 'ae_tlch_ml_req.php';
				 SubmitDateVariable.url = 'ae_tlch_ml_req.php';
			} else {    
			
				httpAYT.url = 'ae_tlch_xmlreq.php'; 
				dataList_2.url = 'ae_tlch_xmlreq.php'; 
				retrieve_componentsearch.url = 'ae_tlch_xmlreq.php'; 
				dataList_history.url = 'ae_tlch_xmlreq.php'; 
				dateRange_history.url = 'ae_tlch_xmlreq.php'; 
				propertiesList.url = 'ae_tlch_xmlreq.php';  
				dataList.url = 'ae_tlch_xmlreq.php';  
				mbdmodule_getpropertylist.url = 'ae_tlch_xmlreq.php'; 
				filterheaderlist.url = 'ae_tlch_xmlreq.php';   
				filterdetaillist.url = 'ae_tlch_xmlreq.php';   
				deletelist.url = 'ae_tlch_xmlreq.php';  
				deletefiltercodes.url = 'ae_tlch_xmlreq.php'; 
				defaultpersistentview.url = 'ae_tlch_xmlreq.php';  
				createupdate.url = 'ae_tlch_xmlreq.php';  
				createheadermm.url = 'ae_tlch_xmlreq.php';  
				SubmitDDOpsSec.url = 'ae_tlch_xmlreq.php';  
				SubmitOprGroup.url = 'ae_tlch_xmlreq.php';  
				navigateToJobProgram.url = 'ae_tlch_xmlreq.php'; 
				validate_copytogroup.url = 'ae_tlch_xmlreq.php';  
				ActionButtons.url = 'ae_tlch_xmlreq.php';  
				add_maintain_operatorgroup.url = 'ae_tlch_xmlreq.php';
				delete_maintain_operatorgroup.url = 'ae_tlch_xmlreq.php';
				retrieve_maintainrendition.url = 'ae_tlch_xmlreq.php';
				retrieve_maintainview.url = 'ae_tlch_xmlreq.php';
				retrieve_groupforoperators.url = 'ae_tlch_xmlreq.php';
				add_maintain_operator.url = 'ae_tlch_xmlreq.php'; 
				delete_maintain_operator.url = 'ae_tlch_xmlreq.php'; 
				createheadermm2.url = 'ae_tlch_xmlreq.php';
				filterheaderlist2.url = 'ae_tlch_xmlreq.php';
				retrieve_operator.url = 'ae_tlch_xmlreq.php';
				exporttoxml.url = 'ae_tlch_xmlreq.php';
				unlock_operator.url = 'ae_tlch_xmlreq.php';
				MyViewButtons.url = 'ae_tlch_xmlreq.php';
				getColumnSettings.url = 'ae_tlch_xmlreq.php';
				updatemyview_sequence.url = 'ae_tlch_xmlreq.php';
				retrievemvchart_subtotal.url = 'ae_tlch_xmlreq.php';
				retrievemvchart.url = 'ae_tlch_xmlreq.php';
				saveMyViewChartHTTP.url = 'ae_tlch_xmlreq.php';
				saveMyViewCrunchSubHTTP.url = 'ae_tlch_xmlreq.php';
				retrievemvcrunch.url = 'ae_tlch_xmlreq.php';
				retrievemvquery.url = 'ae_tlch_xmlreq.php';
				saveMyViewCrunchHTTP.url = 'ae_tlch_xmlreq.php';
				saveMyViewQueryHTTP.url = 'ae_tlch_xmlreq.php';
				saveMyViewFilters.url = 'ae_tlch_xmlreq.php';
				saveMyViewColumns.url = 'ae_tlch_xmlreq.php';
				saveMyViewHeader.url = 'ae_tlch_xmlreq.php';
				saveMyViewOldRenditionPerstent.url = 'ae_tlch_xmlreq.php';
				SubmitDateVariable.url = 'ae_tlch_xmlreq.php';
			}
			
		}
		  
   			//////  END ///////
   			