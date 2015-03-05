// ActionScript file
import flash.events.Event;

import mx.collections.ArrayCollection;
import mx.core.Application;
import mx.managers.PopUpManager;
import mx.rpc.events.ResultEvent;
import mx.utils.ArrayUtil;

[Bindable]
public var global_rr_return:String = new String;
[Bindable]
private var loc_xlcHistory:String = "No";		
		private function triggerProfileresult(event:ResultEvent):void{
			
				if (event.result.ezware_response.status == "OK"){		
					if (_xlcHistory == "Yes"){
						// do nothing.  As discussed, Histry ActionGrid should not change and only be used as a Query.
						//dataList.send();
					}else if (_xlcRefreshAll == "Y") {
						dataList.send();
					}
					else{
						dataList_2.send();
					}
				} else	{
					
					var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
					AlertMessageShow(s_ret);
					return;
				}	
		}
		
  		public function propertyListHandler(evt:ResultEvent):void
		{
			
			parentApplication.shortcut_myviewcode = null;   
			if (_xlcHistory == "Yes"){
				
				
				if (retfromrendition ==false){
					Array1 = new ArrayCollection();
				} 
			}else {
				Array1 = new ArrayCollection();
			}
			
			
			_xlcColumn = new ArrayCollection
			_xlcColumnGroup = new ArrayCollection;
			
			if ( evt.result.ezware_response.status != 'OK' ) {
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
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
			_xlcColumnQuery = new ArrayCollection;
			_xlcColumnQuery = _xlcColumn;
 			//	_xlcColumn.refresh();
		
			_xlcTitle = evt.result.ezware_response.refresh_data.root.Panel.title;
			_xlcCode = evt.result.ezware_response.refresh_data.root.Panel.code;
			_xlcHistory = evt.result.ezware_response.refresh_data.root.Panel.history;
			_xlcRefreshAll = evt.result.ezware_response.refresh_data.root.Panel.refreshall;
			_xlcSetupJob = evt.result.ezware_response.refresh_data.root.Panel.setupjob;
			_xlcActionCommand = evt.result.ezware_response.refresh_data.root.Panel.actioncommand;
			_xlcLockColumn = evt.result.ezware_response.refresh_data.root.Panel.lockcolumn;
			
			//Alert.show(evt.result.ezware_response.refresh_data.root.Panel.rendcode); 
		//	Alert.show("2: " + _xlcRenditionCode );
			if (_xlcRenditionCode != "No Selection"){
				_xlcRenditionCode = evt.result.ezware_response.refresh_data.root.Panel.rendcode;
				_xlcRenditionDescription = evt.result.ezware_response.refresh_data.root.Panel.renddesc;
				_xlcRenditionbtntitle = evt.result.ezware_response.refresh_data.root.Panel.rendbtnlabel;
			}
		//	Alert.show("3: " + _xlcRenditionCode );
			_xlcDynamicIndicator =	evt.result.ezware_response.refresh_data.root.Panel.dynamicindicator;
			
			 
			
			// Get data for Column Setings.    
			/*
			reqParms = "REFRESH,RENDITION," + r_passed_mainboard + "," + r_user_code + "," + r_file_modify;
			retrievemodifyrendition.send();
			*/
			 
			/*
			if (global_rr_return != "retain"){
				reqParmsColumnsSetting = "REFRESH,RENDITION," + mainBoard + "," + myName_main + "," +"No Selection";
				getColumnSettings.send();
			}
			else{
			*/
			reqParmsColumnsSetting = "REFRESH,RENDITION," + mainBoard + "," + myName_main + "," + _xlcRenditionCode;
			getColumnSettings.send();
			//} 
			
			//_xlcextensiblefield =	evt.result.ezware_response.refresh_data.root.Panel.extsble_gd;
			_xlcextensiblefield =	'Y';	
			 
			var cg:Object = new Object();
			if (evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumnGroup == null){
				PopUpManager.removePopUp(myAlert);
				AlertMessageShow(mainBoard + " does not have the necessary Datagrid Column Group in place on the ADD.  Please contact your System Admininstrator.");
				return;
				
			}
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
					if (drilldown_flag == "Y"){
						if (_xlcHistory == "Yes"){
							loc_xlcHistory = _xlcHistory;
							_xlcHistory = "No";
						}
					   
					}
					
					
					if (_xlcHistory != "Yes"){
						
							g_my_action =  "refreshData";
							reqParms = "REFRESH," + mainBoard + "," + myName_main + "," + _xlcRenditionCode; 
							
							if (xmlheaderdoc_type == 'DDLevel1'){	
								reqParms = "REFRESH," + mainBoard + "," + myName_main + "," + _xlcRenditionCode + ",OPR_ID," + dd_columnone;
							}
							if (xmlheaderdoc_type == 'DDLevelActionButton'){	
								reqParms = "REFRESH," + mainBoard + "," + myName_main + "," + _xlcRenditionCode + "," + dd_field + "," + dd_columnone;
							}
							if (xmlheaderdoc_type == 'DDLevelRendition'){	
								reqParms = "REFRESH," + mainBoard + "," + myName_main + "," + _xlcRenditionCode + "," + rendition +   "," + myName_main + ",BASE";
							}
							if (drilldown_flag == "Y"){
								reqParms = "REFRESH," + mainBoard + "," + myName_main + "," + _xlcRenditionCode + "," + drilldown_reqparm;
							}
							
							buildDatagrid();
							
							//if (global_rr_return != "retain")
							//{
							//	Alert.show(global_rr_return);
							dataList.send();
							//}
					}         
					
					
					/* Since we have default on the MyView Code, the Query would no longer need a
						parameter to be able to retrieve from the database.  Christine will now provide
						the data with the save MyView Code from the Query save. 
					
					if (_xlcHistory == "Yes"){
						Alert.show(retfromrendition.toString());
							buildDatagrid();
							
							PopUpManager.removePopUp(myAlert);
							if (retfromrendition == false){
										launchHistoryRetrievalMultipleParameters(evt,_xlcDynamicIndicator);
							}
							if (retfromrendition == true){
							
								initfilterheaderlist(_xlcCode);
							}  
					}
					*/
					if (_xlcHistory == "Yes"){
						
						//Alert.show(retfromrendition.toString());
						buildDatagrid();
						rettype = "new"; 
						  
					//	if (global_rr_return != "retain")
					//	{
						reqParmsmvquery =  "REFRESH,RETRIEVE|MVQUERY|" + myName_main + "|" + mainBoard +"|"+ _xlcRenditionCode + "|"
						retrievemvquery.send(); 
					//	}
						/*
						reqParms = "REFRESH," + mainBoard + "," + myName_main + "," + _xlcRenditionCode;
						Alert.show(auto_apply_str);
						
						if (auto_apply_str == 'N'){
							launchHistoryRetrievalMultipleParameters(evt,_xlcDynamicIndicator);
							startTimer();
							refreshButton(evt);
						} else {
						dataList_history.send();    
						}
						*/
						
						
							
						//PopUpManager.removePopUp(myAlert);
						//if (retfromrendition == false){
						//	launchHistoryRetrievalMultipleParameters(evt,_xlcDynamicIndicator);
						//}
						//if (retfromrendition == true){
							//Alert.show(_xlcCode);
						//	initfilterheaderlist(_xlcCode);
						//}  
					}
					
					
					
				
				if (xmlheaderdoc_type == 'Profile'){
						 ////////////////////////////////////////////////////////////
    		 			//  Leave this Entry Function for now to give 
    		 			//  priority over Drill Fown first.
    		 			//  Arnold Aprieto 11/27/2009\
    		 			
    		 			createAndMaintain(evt);
    		 			///////////////////////////////////////////////////////////////	
				
				}
				//if ((xmlheaderdoc_type == 'DDLevel1-COMPSYS')||(xmlheaderdoc_type == 'DDLevel1-SSYSJOB')){
				if (xmlheaderdoc_type == 'DDLevel1'){		
						 ////////////////////////////////////////////////////////////
    		 			//  Leave this Entry Function for now to give 
    		 			//  priority over Drill Fown first.
    		 			//  Arnold Aprieto 11/27/2009\
    		 			
    		 			ddlevel1function(evt);
    		 			///////////////////////////////////////////////////////////////	
				     
				}
				
				if (xmlheaderdoc_type == 'WORKFLOW'){		
					Workflow_func(evt);
				}
				//  Remove this now.  This is a hard coded object. 
				//if (xmlheaderdoc_type == 'RFOperator'){		
				//		OperatorAssignment(evt);
    		 	//}
    		 	//
    		 	
    		 //	ActionButtons.send();
    		 	//
				 
				//buildDatagrid(); 
				//initfilterheaderlist(_xlcCode);
				//initfilterdetaillist(evt, _xlcCode);

			
			//		initfilterheaderlist(_xlcCode);
			//		initfilterdetaillist(evt, _xlcCode);
				// Alert.show(fhp.length.toString());
				// Place default Persistent View.
				/*
				for (var ia:int=0;ia < fhp.length; ia++)  {
					//Alert.show(fhp[i].filtercode);
					if (fhp[ia].default_view == "Y"){
						lbl_persistent_view.text = fhp[ia].filtercode;
					}
				}
					*/
				// Place default Persistent View.
				/*
				Alert.show(fhp.length.toString());
				for (var ia:int=0;ia < fhp.length; ia++)  {
					//Alert.show(fhp[i].filtercode);
					if (fhp[ia].default_view == "Y"){
						lbl_persistent_view.text = fhp[ia].filtercode;
					}
				}
				change_filtermacro_persistent(evt);
				lbl_transient_view.text = 'No selection';
				addTotal();     
				refreshButton(evt);
				*/
				
		}		
		public function saveselecteditemsfromMainboard():void{
			
		}
		public function dataList2_trigger(evt:Event, reset:Boolean):void
		{		
				/* Reset Timer first */
				startTimer();
				ah_sort_flag = true;
				
				if (Array1.sort != null){
					CheckSortGeneral(evt);
			
				}
				
			dg_vsb = dg.verticalScrollPosition;
			dg_hsb = dg.horizontalScrollPosition;
				g_my_action =  "refreshData";
			if ((_xlcHistory != "Yes")&& (crunch != true)){
				if (drilldown_flag == "Y"){
					reqParms = "REFRESH," + mainBoard + "," + myName_main + "," + _xlcRenditionCode + "," + ret_date + "," + ret_time + drilldown_reqparm;
					
				} else {
					reqParms = "REFRESH," + mainBoard + "," + myName_main + "," + _xlcRenditionCode + "," + ret_date + "," + ret_time; 
				}
				
			launchErgo();
				//This is for a refresh.  see Christine's Security Operator Profile for retrieval.
				
				if (_xlcRefreshAll == 'Y'){
						if (xmlheaderdoc_type == 'DDLevel1'){	
								reqParms = "REFRESH," + mainBoard + "," + myName_main + "," + _xlcRenditionCode + ",OPR_ID," + dd_columnone;
						}
						if (xmlheaderdoc_type == 'DDLevelActionButton'){	
								reqParms = "REFRESH," + mainBoard + "," + myName_main + "," + _xlcRenditionCode + "," + dd_field + "," + dd_columnone;
							}
						if (xmlheaderdoc_type == 'DDLevelRendition'){	
								reqParms = "REFRESH," + mainBoard + "," + myName_main + "," + _xlcRenditionCode + "," + rendition +   "," + myName_main + ",BASE";
							}
			    		dataList.send();
			    	} else {
			    		dataList_2.send();
			    }
			}	
			if ((_xlcHistory == "Yes")||(crunch == true)){
				
				if (reset == false){	
						launchHistoryRetrievalMultipleParameters(evt,_xlcDynamicIndicator);
				}
				
			}	
		}		
		
		
		private function faultpropertyListHandler(evt:FaultEvent):void
		{
			PopUpManager.removePopUp(popwait);
			var faultMessage:String = "Unable to retrieve the Property File for " + mainBoard;
			AlertMessageShow(faultMessage);
		}
	
			private function faultexporttoxml(evt:FaultEvent):void
			{
				popexporttoxml.exp_pbar.visible = true;
				PopUpManager.removePopUp(popexporttoxml);
				
				var faultMessage:String = "Problem occured exporting to XML.  Check with your Administrator"
				AlertMessageShow(faultMessage);
			}
		private function LotListHandler(evt:ResultEvent):void{
			_LotxlcColumn = new ArrayCollection
			
			if ( evt.result.ezware_response.status != 'OK' ) {
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
			
			
			if (evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumn.column == null)
			{
				_LotxlcColumn=new ArrayCollection()
			}
			else if (evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumn.column is ArrayCollection)
			{
				_LotxlcColumn=evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumn.column;
			}
			else if (evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumn.column is ObjectProxy)
			{
				_LotxlcColumn = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumn.column)); 
			}
			
			launchHistoryRetrievalMultipleParametersLot(evt, "1")
			
		}



			   
			
			public var pophrmpLot:HistoryRetrievalMultipleParameters;
		
			
			public function launchHistoryRetrievalMultipleParametersLot(event:Event, loc_f_di:String):void {
				
				
				
				pophrmpLot = HistoryRetrievalMultipleParameters(
					PopUpManager.createPopUp(this, HistoryRetrievalMultipleParameters, true));   
				pophrmpLot.btn_ecs.enabled = false;
				//title_id.text = mb_title + ' Extensible Data Query'
				//pophrmpLot.title_id.text = 
				
				pophrmpLot.lot_req_sq = req_sq; 
				pophrmpLot.save_str_lotquerydetl = pophrmp.str_lotquerydetl;
				pophrmpLot.pageType = 'lot';
				pophrmpLot.lotquerycode =pophrmp.loc_query_code
				pophrmpLot.lotquerydescription = pophrmp.loc_query_description
					
				
				pophrmpLot.cc_sq = my_c_code1;
				pophrmpLot.sid_sq = my_sid;
				
				pophrmpLot.user_sq = myName_main;		
					
					   
				pophrmpLot.mfArray = _LotxlcColumn.toArray();      
				pophrmpLot.mb_title = mainBoard + ' Extensible Data'; 
				pophrmpLot.filluphistoryParameters = historyParametersQuery; 
				pophrmpLot.dynamicindicator = loc_f_di; 
				  
				/*
				pophrmpLot["btn_nr"].addEventListener("click", historyNewRetrieval); 
				pophrmpLot["btn_nr"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmpLot["btn_nr"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				pophrmpLot["btn_atc"].addEventListener("click", historyCurrentRetrieval);
				pophrmpLot["btn_atc"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmpLot["btn_atc"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				pophrmpLot["btn_close"].addEventListener("click", closehistoryNewRetrieval); 
				pophrmpLot["btn_close"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmpLot["btn_close"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				*/
				
				pophrmpLot["btn_dmc"].addEventListener("click", displayLotComppass2); 
				pophrmpLot["btn_dmc"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmpLot["btn_dmc"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				pophrmpLot["btn_dls"].addEventListener("click", displayLotSetpass2); 
				pophrmpLot["btn_dls"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmpLot["btn_dls"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				//pophrmpLot["btn_ecs"].addEventListener("click", enterComponentSearch); 
				//pophrmpLot["btn_ecs"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				//pophrmpLot["btn_ecs"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				pophrmpLot["btn_close2"].addEventListener("click", closehistoryNewRetrievalLot); 
				pophrmpLot["btn_close2"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pophrmpLot["btn_close2"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				
			}

			       
			
				private function closehistoryNewRetrievalLot(event:Event):void{
					PopUpManager.removePopUp(pophrmpLot);
				}

				private function displayLotSetpass2(event:Event):void{
					var retval:String = new String;
					//Alert.show("Check 1: ");
					retval= xmlLineUpforLotpass2(event, pophrmpLot.myDPColl);
					
					//Alert.show("Check 2 retval: " + retval);
					retval = "<lotdisp>LOTSET</lotdisp>" + retval; 
					//Alert.show("Check 3 retval: " + retval);
					rettype = "new";
					    
					reqParms = displayLot + retval;
					//reqParms = "";
					//Alert.show(reqParms);   
					
					dataList_history.send();   
					   
					PopUpManager.removePopUp(pophrmpLot);    
				}       

				private function displayLotComppass2(event:Event):void{
					var retval:String = new String;
					retval= xmlLineUpforLotpass2(event, pophrmpLot.myDPColl);
					retval = "<lotdisp>LOTCOMP</lotdisp>" + retval;
					rettype = "new"; 
					reqParms = displayLot + retval;
					dataList_history.send();         
					PopUpManager.removePopUp(pophrmpLot);
				}


		[Bindable]
		private var dg_selectedItems:Array = new Array;

		private function ListHandler2(evt:ResultEvent):void{
			if (evt.result.ezware_response.status == 'OK'){
			dg_selectedItems = dg.selectedIndices;
			var suf:String = "data";
 			var suf_gendate:String = "gen_date";
 			var suf_gentime:String = "gen_time";
			tdObjectCollectionRefresh = new ArrayCollection();
			typeofretrieval = evt.result.ezware_response.elapsed.phase;   
 			unitofspeed = evt.result.ezware_response.elapsed.units;
 			timeelapsed = evt.result.ezware_response.elapsed
			
 		if (evt.result.ezware_response.refresh_data[mainBoard][suf] == null) 
		     	
            { 
                tdObjectCollectionRefresh=new ArrayCollection()
            }
            else if (evt.result.ezware_response.refresh_data[mainBoard][suf] is ArrayCollection)
            {
              tdObjectCollectionRefresh=evt.result.ezware_response.refresh_data[mainBoard][suf];
            }
            else if (evt.result.ezware_response.refresh_data[mainBoard][suf] is ObjectProxy)
            {
               tdObjectCollectionRefresh = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data[mainBoard][suf])); 
            }
 			 	ret_date = evt.result.ezware_response.refresh_data[mainBoard][suf_gendate];
 				ret_time = evt.result.ezware_response.refresh_data[mainBoard][suf_gentime];
 				ret_datetime = c_utils.formatyymmdd(ret_date) + " " + c_utils.formathhmmss(ret_time);
 					 PopUpManager.removePopUp(popwait);
 					 if (evt.result.ezware_response.refresh_data.addincluded == "Y"){
						 aDDIncluded(evt);
					 }      
			joinRetRecToArrayZero(evt);
			refreshButton(evt);
 			dataList_2.clearResult(true);
			dg.selectedIndices = dg_selectedItems;
		   
		} else	if (evt.result.ezware_response.status == 'EXPIRED') {
			PopUpManager.removePopUp(popwait);
			PopUpManager.removePopUp(myAlert);
			AlertMessageShow("Session EXPIRED due to inactivity.  Please log out and log back in again to create a new session.");
			return;
		}
		}
 		
 		
 		private function DateRangeHandlerHistory(evt:ResultEvent):void{
 			
			if (evt.result.ezware_response.status == "OK"){
					if ((evt.result.ezware_response.refresh_data.root.daterange.from == null)||(evt.result.ezware_response.refresh_data.root.daterange.to == null)){
		 			 	PopUpManager.removePopUp(popwait);
		 			}
		 			history_daterange_from = evt.result.ezware_response.refresh_data.root.daterange.from;
		 			history_daterange_to = evt.result.ezware_response.refresh_data.root.daterange.to;
		 			reqParms = "REFRESH," + mainBoard + ",FROM," + searchReplace(history_daterange_from, "-", "") + ",TO," + searchReplace(history_daterange_to, "-", "") + "," + myName_main; 
					dataList_history.send();
			} else	{
				
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}
			
 		}   
 		private function ListHandlerHistory(evt:ResultEvent):void{
			//Alert.show("POST!!!");
			if (evt.result.ezware_response.status == "OK"){  
					
					
					
					
		 			if (rettype == 'current'){
		 				ListHandler2(evt);
		 				PopUpManager.removePopUp(pophrmp);
		 			}
		 			if (rettype == 'new'){    
		 				var suf:String = "data";
		 				var suf_gendate:String = "gen_date";
		 				var suf_gentime:String = "gen_time";
						
							tdObjectCollectionRefresh = new ArrayCollection();
							typeofretrieval = evt.result.ezware_response.elapsed.phase;
		 			unitofspeed = evt.result.ezware_response.elapsed.units;
		 			timeelapsed = evt.result.ezware_response.elapsed
		 			
						if (evt.result.ezware_response.refresh_data[mainBoard][suf] == null)
		            	{
						
		                	tdObjectCollectionRefresh=new ArrayCollection()
							
							//Array1 = new ArrayCollection();
							//Array2 = new ArrayCollection(); 
		            	}     
		            	else if (evt.result.ezware_response.refresh_data[mainBoard][suf] is ArrayCollection)
		            	{
							 
		              	tdObjectCollectionRefresh=evt.result.ezware_response.refresh_data[mainBoard][suf];
		            	}
		            	else if (evt.result.ezware_response.refresh_data[mainBoard][suf] is ObjectProxy)
		            	{
						
		               	tdObjectCollectionRefresh = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data[mainBoard][suf])); 
		            	}
						
						//launchHistoryRetrievalMultipleParameters(evt,_xlcDynamicIndicator);
						
						   if (tdObjectCollectionRefresh.length == 0){
							 // launchHistoryRetrievalMultipleParameters(evt,_xlcDynamicIndicator);
							   tdObjectCollection = new ArrayCollection;
							   tdObjectCollection = tdObjectCollectionRefresh;
							   Array1 = new ArrayCollection();
							   Array2 = new ArrayCollection();
							  initfilterdetaillist(evt, _xlcCode);
							
							   correctWidth(evt); 
							   startTimer();
							  PopUpManager.removePopUp(myAlert);   
							  PopUpManager.removePopUp(popwait);
						   }    
						   else{
			 			 		ret_date = evt.result.ezware_response.refresh_data[mainBoard][suf_gendate];
			 					ret_time = evt.result.ezware_response.refresh_data[mainBoard][suf_gentime];
			 					ret_datetime = c_utils.formatyymmdd(ret_date) + " " + c_utils.formathhmmss(ret_time);
			 					 PopUpManager.removePopUp(popwait);
					 			tdObjectCollection = new ArrayCollection;
					 			tdObjectCollection = tdObjectCollectionRefresh;
								dataList_history.clearResult(true);
			 					PopUpManager.removePopUp(pophrmp);
								PopUpManager.removePopUp(myAlert);   
								if (evt.result.ezware_response.refresh_data.addincluded == "Y"){    
									aDDIncluded(evt);
								} else{
									if (evt.result.ezware_response.refresh_data.addincluded != "Y"){   
										//  Remove this for now.  4/12/2013
										//initfilterheaderlist(_xlcCode);
										// Replac with
										initfilterdetaillist(evt, _xlcCode);
													
										correctWidth(evt);  
									}
								}		
								startTimer();
			 					refreshButton(evt);
						   }	
		 			}
			} else	{
				
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}
		}   
 		private function ListHandler(evt:ResultEvent):void{
				//	Alert.show(reqParms);
			
			if (evt.result.ezware_response.status == "OK"){		
					_xlcHistory = loc_xlcHistory;
		 			var suf:String = "data";
		 			var suf_gendate:String = "gen_date";
		 			var suf_gentime:String = "gen_time";
		 			tdObjectCollection = new ArrayCollection();
		 			typeofretrieval = evt.result.ezware_response.elapsed.phase;
		 			unitofspeed = evt.result.ezware_response.elapsed.units;
		 			timeelapsed = evt.result.ezware_response.elapsed;
		 			
		 			if (evt.result.ezware_response.refresh_data[mainBoard][suf] == null)
		            {
						
		                tdObjectCollection=new ArrayCollection();
		            }
		            else if (evt.result.ezware_response.refresh_data[mainBoard][suf] is ArrayCollection)
		            {
						
				      tdObjectCollection=evt.result.ezware_response.refresh_data[mainBoard][suf];
		            }
		            else if (evt.result.ezware_response.refresh_data[mainBoard][suf] is ObjectProxy)
		            {
						
		               tdObjectCollection = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data[mainBoard][suf])); 
		            }
					
					 	ret_date = evt.result.ezware_response.refresh_data[mainBoard][suf_gendate];
		 				ret_time = evt.result.ezware_response.refresh_data[mainBoard][suf_gentime];
		 				  
		 				ret_datetime = c_utils.formatyymmdd(ret_date) + " " + c_utils.formathhmmss(ret_time);
		 				
						
						
		 			 Array1 = new ArrayCollection();
		 			 Array2 = new ArrayCollection();
					
					 Array1 = tdObjectCollection;
					 Array2 = tdObjectCollection;
					 PopUpManager.removePopUp(popwait);
					 PopUpManager.removePopUp(myAlert);
					 /*  Check for 2nd pass of ADD (ActionGrid Document Definition) */
					
					 
					    
					 if (evt.result.ezware_response.refresh_data.addincluded == "Y"){
						 aDDIncluded(evt);   
					 }
					 else{
						// createPanelButtons();
						
								if (evt.result.ezware_response.refresh_data.addincluded != "Y"){
									//  Remove this for now.  4/12/2013
									//initfilterheaderlist(_xlcCode);
									// Replac with
									initfilterdetaillist(evt, _xlcCode);
									
											//correctWidth(evt);  
								}
					 }		
					
			} else	{
				
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}
 		}




		private function ColumnsSettingsHandler(evt:ResultEvent):void{
			//	Alert.show(reqParms);
			if (evt.result.ezware_response.status == "OK"){		
				Arr_columnRendition=new ArrayCollection()
				var suf:String = "data";
				var mainBoard:String = "RENDITION";
				if (evt.result.ezware_response.refresh_data[mainBoard][suf] == null)
				{
					Arr_columnRendition=new ArrayCollection()
				}
				else if (evt.result.ezware_response.refresh_data[mainBoard][suf] is ArrayCollection)
				{
					Arr_columnRendition=evt.result.ezware_response.refresh_data[mainBoard][suf];
				}
				else if (evt.result.ezware_response.refresh_data[mainBoard][suf] is ObjectProxy)
				{
					Arr_columnRendition = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data[mainBoard][suf])); 
				}
				Arr_columnRendition.refresh();
				
				
			} else	{
				
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}
		}





		private function faultxmlcontrol(evt:FaultEvent):void
		{
			AlertMessageShow("XML Control File does not exist");
		}

 		private function faultListHandler2(evt:FaultEvent):void
		{
			PopUpManager.removePopUp(popwait);
			PopUpManager.removePopUp(myAlert);
			var faultMessage:String = "Could not connect with Data.XML 2 file checksum";
			AlertMessageShow(faultMessage);
		} 	
		private function faultListHandlerHistory(evt:FaultEvent):void
		{
			PopUpManager.removePopUp(popwait);
			PopUpManager.removePopUp(myAlert);
			var faultMessage:String = "Could not connect with History file checksum";
			AlertMessageShow(faultMessage);
		} 	
		
		private function faultMVQueryRetrieve(evt:FaultEvent):void
		{
			
			var faultMessage:String = "Could not connect Query retrieval";
			AlertMessageShow(faultMessage);
		} 	
			
		private function faultMVCrunchRetrieve(evt:FaultEvent):void
		{
			
			var faultMessage:String = "Could not connect Crunch retrieval";
			AlertMessageShow(faultMessage);
		}
		private function faultMVChartRetrieve(evt:FaultEvent):void
		{
			
			var faultMessage:String = "Could not connect Chart retrieval";
			AlertMessageShow(faultMessage);
		}
		private function faultUpdateMyViewSequence(evt:FaultEvent):void
		{
			
			var faultMessage:String = "Could not connect MyView Sequence";
			AlertMessageShow(faultMessage);
		}
 		private function faultListHandler(evt:FaultEvent):void
		{
			PopUpManager.removePopUp(popwait);
			PopUpManager.removePopUp(myAlert);
			var faultMessage:String = "XML not properly formatted: " + evt.message;
				AlertMessageShow(faultMessage);
		}

		private function faultListColumnsSetting(evt:FaultEvent):void
		{
			var faultMessage:String = "Unable to retrieve proper Column Settings Data: " + evt.message;
			AlertMessageShow(faultMessage);
		}
		private function filterheader(evt:ResultEvent):void
		{
			if (evt.result.ezware_response.status == "OK"){		
					// I have to create a main repository to accept both the "Persistent - P" and "Transient - T"
					ArrayPandT = new ArrayCollection();
					fh = new ArrayCollection();
					fhp = new ArrayCollection();
					
					
					/*
					
					
					if (evt.result.ezware_response.refresh_data.filterheaders.filterheader == null)
		            {
		                ArrayPandT = new ArrayCollection()
		            }
		            else if (evt.result.ezware_response.refresh_data.filterheaders.filterheader is ArrayCollection)
		            {
		              ArrayPandT = evt.result.ezware_response.refresh_data.filterheaders.filterheader;
		            }
		            else if (evt.result.ezware_response.refresh_data.filterheaders.filterheader is ObjectProxy)
		            {
		               ArrayPandT = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.filterheaders.filterheader)); 
		            }
					*/
					
					
					if (evt.result.ezware_response.refresh_data.filterheader == null)
					{
						ArrayPandT = new ArrayCollection()
					}
					else if (evt.result.ezware_response.refresh_data.filterheader is ArrayCollection)
					{
						ArrayPandT = evt.result.ezware_response.refresh_data.filterheader;
					}
					else if (evt.result.ezware_response.refresh_data.filterheader is ObjectProxy)
					{
						ArrayPandT = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.filterheader)); 
					}
					
					
					
					
					for (var iapt:int=0;iapt < ArrayPandT.length; iapt++)  {
						if (ArrayPandT[iapt].save_as == "T"){
							fh.addItem(ArrayPandT[iapt]);	
						} else {
							fhp.addItem(ArrayPandT[iapt]);
						}
					}   
					fh.refresh();
					fhp.refresh();
					initfilterdetaillist(evt, _xlcCode);
			} else	{
				
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
		}   
private function filterheader2(evt:ResultEvent):void
{  
	if (evt.result.ezware_response.status == "OK"){		
		// I have to create a main repository to accept both the "Persistent - P" and "Transient - T"
		ArrayPandT = new ArrayCollection();
		fh = new ArrayCollection();
		fhp = new ArrayCollection();
		if (evt.result.ezware_response.refresh_data.filterheaders.filterheader == null)
		{
			ArrayPandT = new ArrayCollection()
		}
		else if (evt.result.ezware_response.refresh_data.filterheaders.filterheader is ArrayCollection)
		{
			ArrayPandT = evt.result.ezware_response.refresh_data.filterheaders.filterheader;
		}
		else if (evt.result.ezware_response.refresh_data.filterheaders.filterheader is ObjectProxy)
		{
			ArrayPandT = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.filterheaders.filterheader)); 
		}
		for (var iapt:int=0;iapt < ArrayPandT.length; iapt++)  {
			if (ArrayPandT[iapt].save_as == "T"){
				fh.addItem(ArrayPandT[iapt]);	
			} else {
				fhp.addItem(ArrayPandT[iapt]);
			}
		}
		fh.refresh();
		fhp.refresh();
		
	} else	{
		
		var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
		AlertMessageShow(s_ret);
		return;
	}	
}   
		private function res_dd_ops(event:ResultEvent):void
		{
			if (event.result.ezware_response.status == 'OK'){
				AlertMessageShow("Record(s) succesfully updated.");
				startTimer();
				PopUpManager.removePopUp(popcompsys_access);
			
			} else	{
				
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}

			
		}
		private function res_oprgroup(event:ResultEvent):void
		{
			if (event.result.ezware_response.status == 'OK'){
				dataList2_trigger(event, true);
				
			} else	{
				
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}
			
			
		}
		private function filterheaderfaultHandler(evt:FaultEvent):void
		{
			var faultMessage:String = "Could not connect with Macro Filter Headers XML file checksum";
			AlertMessageShow(faultMessage);
		}
		private function filterdetail(event:ResultEvent):void
		{  
		
			
			if (event.result.ezware_response.status == "OK"){	
					ArrayDetailPandT = new ArrayCollection();
					fd = new ArrayCollection();
					fdp = new ArrayCollection();
					
					if (event.result.ezware_response.refresh_data.filterdetail.filterdetail == null)
		            {
		                ArrayDetailPandT = new ArrayCollection();
		            }
		            else if (event.result.ezware_response.refresh_data.filterdetail.filterdetail is ArrayCollection)
		            {
		              ArrayDetailPandT = event.result.ezware_response.refresh_data.filterdetail.filterdetail;
		            }
		            else if (event.result.ezware_response.refresh_data.filterdetail.filterdetail is ObjectProxy)
		            {
		               ArrayDetailPandT = new ArrayCollection(ArrayUtil.toArray(event.result.ezware_response.refresh_data.filterdetail.filterdetail)); 
		            }   
					for (var iadpt:int=0;iadpt < ArrayDetailPandT.length; iadpt++)  {
						if (ArrayDetailPandT[iadpt].save_as == "T"){
							fd.addItem(ArrayDetailPandT[iadpt]);	
						} else {
							fdp.addItem(ArrayDetailPandT[iadpt]);
						}
					}
				//	buildDatagrid();    
					
					
					fd.refresh();         
					fdp.refresh();   
				// Remove this for now.  3/11/2013	
				//	erase(event);
					
					correctWidth(event);
					
					flagger(event);
					
					executePersistentDefault(event); 
					//createPanelButtons();
			} else	{   
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}			
		}   

		private function filterdetailfaultHandler(evt:FaultEvent):void
		{
			var faultMessage:String = "Could not connect with Macro Filter Details XML file checksum";
			AlertMessageShow(faultMessage);
		}
		private function faulttriggerProfile(evt:Event):void{
			var faultMessage:String = "Could not connect with Profile Return Details";
			AlertMessageShow(faultMessage);
		}
		private function faultcreateupdateHandler(evt:FaultEvent):void
		{ 
			var faultMessage:String = "Could not connect with Macro Filter Details XML file checksum";
			AlertMessageShow(faultMessage);
		}
		private function faultcreatemaintainheaderHandler(evt:FaultEvent):void
		{
			AlertMessageShow(evt.message.toString())
		}
		private function faultresdd_ops(evt:FaultEvent):void
		{
			AlertMessageShow(evt.message.toString())
		}
		private function fault_oprgroup(evt:FaultEvent):void
		{
			AlertMessageShow(evt.message.toString())
		}

		private function mbdmodule_getproperty(evt:ResultEvent):void
		{ 
			
			if (evt.result.ezware_response.status == "OK"){		
				
					toxml_mbdcode = evt.result.ezware_response.refresh_data.mbdmodules.mbdmodule.mbdcode;
				
					if (drilldown_flag == "Y"){
						
						reqParms = "REFRESH,RETRIEVE|GRIDHEADERDOC2|" + myName_main + "|" + toxml_mbdcode + "|BASE|";
						
							  
					} else {
							
							if (parentApplication.shortcut_myviewcode == null){
							
							reqParms = "REFRESH,RETRIEVE|GRIDHEADERDOC2|" + myName_main + "|" + toxml_mbdcode + "|";
							}
							else 
							   
							{ 
							
							
							reqParms = "REFRESH,RETRIEVE|GRIDHEADERDOC2|" + myName_main + "|" 
								+ toxml_mbdcode + "|"   
								+ parentApplication.shortcut_myviewcode + '|';
							
							}
					}		
					
					propertiesList.send();
					//parentApplication.shortcut_myviewcode == null;
			} else	{     
				
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}
					
		}	
		private function mbdmodule_getpropertylistfaultHandler(evt:FaultEvent):void
		{
			PopUpManager.removePopUp(popwait);
			AlertMessageShow(evt.message.toString())
		}
		public var popcopytogroup:CopytoGroup;	
		private function copytogroupHandler(event:ResultEvent):void
		{
			
			
				
        		if (event.result.ezware_response.status == 'OK' ) {
        			if (event.result.ezware_response.refresh_data.root.result == 'invalid'){
        					AlertMessageShow(event.result.ezware_response.refresh_data.root.reason);
        					return;
        			}
        			if (event.result.ezware_response.refresh_data.root.result == 'valid'){
        						popcopytogroup = CopytoGroup(
   		 		 				PopUpManager.createPopUp(this, CopytoGroup, true));
   		 		 				popcopytogroup.dd_compcode = my_c_code1;
								popcopytogroup.dd_type = ag_application_entry;
   		 		 				popcopytogroup.fromgroup = (dg.selectedItem[(_xlcColumn[_xlcColumn.length-2]["dataField"])]) 
   		 		 				//popcopytogroup["btn_submit"].addEventListener("click",  submitCopytoGroup);	
        			}
        		}  else	{
					
					var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
					AlertMessageShow(s_ret);
					return;
				}	
				
				
				
        		
			
		}
		private function faultcopytogroup(event:FaultEvent):void{
			var faultMessage:String = "Unable to retrieve Copy To Group result";
			AlertMessageShow(faultMessage);
		}
		
		private function actionbuttonsHandler(event:ResultEvent):void
		{
			   if (event.result.ezware_response.status == 'OK' ) {
					arr_actionbuttons = new ArrayCollection();
					if (event.result.ezware_response.refresh_data.actionbuttons.actionbutton == null)
            		{ 
                		arr_actionbuttons=new ArrayCollection()
            		}
            		else if (event.result.ezware_response.refresh_data.actionbuttons.actionbutton is ArrayCollection)
            		{
              			arr_actionbuttons=event.result.ezware_response.refresh_data.actionbuttons.actionbutton;
            		}
            		else if (event.result.ezware_response.refresh_data.actionbuttons.actionbutton is ObjectProxy)
            		{
               			arr_actionbuttons = new ArrayCollection(ArrayUtil.toArray(event.result.ezware_response.refresh_data.actionbuttons.actionbutton)); 
            		}
            		createActionButtons(event);
        		} else	{
					
					var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
					AlertMessageShow(s_ret);
					return;
				}	
		}
		

		private function myviewbuttonsHandler(evt:ResultEvent):void
		{ 
			
			
			if (evt.result.ezware_response.status == 'OK' ) {
				
				arr_myviewbuttons = new ArrayCollection();
				
				if (evt.result.ezware_response.refresh_data.myviews.myview == null)
				{    
					arr_myviewbuttons=new ArrayCollection()
				}    
				else if (evt.result.ezware_response.refresh_data.myviews.myview is ArrayCollection)
				{
					arr_myviewbuttons=evt.result.ezware_response.refresh_data.myviews.myview;
				}
				else if (evt.result.ezware_response.refresh_data.myviews.myview is ObjectProxy)
				{
					arr_myviewbuttons = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.myviews.myview)); 
				}
				arr_myviewbuttons.refresh();   
				createMyViewButtons(evt);       
				
			} else	{
				
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}				
			
			
		}


		private function faultactionbuttons(event:FaultEvent):void{
			var faultMessage:String = "Unable to retrieve Action Buttons";
			AlertMessageShow(faultMessage);
		}
		private function faultmyviewbuttons(event:FaultEvent):void{
			var faultMessage:String = "Unable to retrieve MyView Buttons";
			AlertMessageShow(faultMessage);
		}
		private function createOperatorGroupHandler(event:ResultEvent):void
		{
			if (event.result.ezware_response.status == 'OK' ) {
				if (event.result.ezware_response.refresh_data.operatorgroup.success == "Y"){
					PopUpManager.removePopUp(interfacesecuritygroupsoperationsprofile);
					dataList2_trigger(event, false);
				} else {
					AlertMessageShow(event.result.ezware_response.refresh_data.operatorgroup.message);
					return;
				}
				
				
			} else	{
				
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
		}
		
		private function faultOperatorGroup(event:FaultEvent):void{
			var faultMessage:String = "Unable to create/update Operator Group.  Please check with your System Administrator.";
			AlertMessageShow(faultMessage);
		}
		private function faultunlockOperator(event:FaultEvent):void{
			var faultMessage:String = "Unable to unlock Operator.  Please check with your System Administrator.";
			AlertMessageShow(faultMessage);
		}
		private function faultRetrieveMaintainRendition(event:FaultEvent):void{
			var faultMessage:String = "Unable to retrieve Rendition Values.  Please check with your System Administrator.";
			AlertMessageShow(faultMessage);
		}    
		private function faultRetrieveMaintainView(event:FaultEvent):void{
			var faultMessage:String = "Unable to retrieve Views Values.  Please check with your System Administrator.";
			AlertMessageShow(faultMessage);
		}
		private function faultRetrieveOperatorGroup(event:FaultEvent):void{
			var faultMessage:String = "Unable to retrieve Operator Group Values.  Please check with your System Administrator.";
			AlertMessageShow(faultMessage);
		}
		private function faultRetrieveOperator(event:FaultEvent):void{
			var faultMessage:String = "Unable to retrieve Operator Values.  Please check with your System Administrator.";
			AlertMessageShow(faultMessage);
		}
		private function deleteOperatorGroupHandler(event:ResultEvent):void
		{
			if (event.result.ezware_response.status == 'OK' ) {
				if (event.result.ezware_response.refresh_data.operatorgroup.success == "Y"){
					PopUpManager.removePopUp(interfacesecuritygroupsoperationsprofile);
					dataList2_trigger(event, false);
				} else {
					AlertMessageShow(event.result.ezware_response.refresh_data.operatorgroup.message);
					return;
				}
			} else	{
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
		}
		private function deleteOperatorHandler(event:ResultEvent):void
		{
			if (event.result.ezware_response.status == 'OK' ) {
				if (event.result.ezware_response.refresh_data.operator.success == "Y"){
					PopUpManager.removePopUp(interfacesecurityoperationsprofile);
					dataList2_trigger(event, false);
				} else {
					AlertMessageShow(event.result.ezware_response.refresh_data.operator.message);
					return;
				}
			} else	{
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
		}


		private function exporttoexcelHandler(event:ResultEvent):void
		{
			PopUpManager.removePopUp(popexporttoxml); 
			if (event.result.ezware_response.status == 'OK' ) {
					AlertMessageShow(event.result.ezware_response.refresh_data.data.message);
					popexporttoxml.exp_pbar.visible = false;
					dataList2_trigger(event, false);
			} else	{
				popexporttoxml.exp_pbar.visible = false;
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
		}
		private function faultDeleteOperatorGroup(event:FaultEvent):void{
			var faultMessage:String = "Unable to delete Operator Group.  Please check with your System Administrator.";
			AlertMessageShow(faultMessage);
		}
		private function faultDeleteOperator(event:FaultEvent):void{
			var faultMessage:String = "Unable to delete Operator.  Please check with your System Administrator.";
			AlertMessageShow(faultMessage);
		}
		private function createOperatorHandler(event:ResultEvent):void
		{
			   
			if (event.result.ezware_response.status == 'OK' ) {
				if (event.result.ezware_response.refresh_data.operator.success == "Y"){
					PopUpManager.removePopUp(interfacesecurityoperationsprofile);
					dataList2_trigger(event, false);
				} else {
					AlertMessageShow(event.result.ezware_response.refresh_data.operator.message);
					return;
				}
				
				
			} else	{
				
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
			
		}      
		private function unlockOperatorHandler(event:ResultEvent):void
		{
			
			if (event.result.ezware_response.status == 'OK' ) {
				if (event.result.ezware_response.refresh_data.operator.success == "Y"){
					
					
					interfacesecurityoperationsprofile.ina_yes2.selected = false;
					interfacesecurityoperationsprofile.ina_no2.selected = true;
					interfacesecurityoperationsprofile.btn_unlock.visible = false;
					
				} else {
					AlertMessageShow(event.result.ezware_response.refresh_data.operator.message);
					return;
				}
				
				
			} else	{
				
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
			
		}
		private function faultOperator(event:FaultEvent):void{
			var faultMessage:String = "Unable to create/update Operator.  Please check with your System Administrator.";
			AlertMessageShow(faultMessage);
			
		}



		private function faultMyViewHeaderHandler(evt:FaultEvent):void
		{
			
			
			var faultMessage:String = "Problem occured exporting to XML of MyView Header.  Check with your Administrator"
			AlertMessageShow(faultMessage);
			return;
		}
private function faultMyViewMergeHandler(evt:FaultEvent):void
{
	
	
	var faultMessage:String = "Problem occured exporting to XML of MyView Merge.  Check with your Administrator"
	AlertMessageShow(faultMessage);
	return;
}

		private function resultMyViewHeaderHandler(event:ResultEvent):void
		{
			
			if (event.result.ezware_response.status == 'OK' ) {
				updateMyViewSequence(event);
				saveMyViewPartsColumns(event);
			} else	{
				
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
		}



private function resultMyViewMergeHandler(event:ResultEvent):void
{
	
	if (event.result.ezware_response.status == 'OK' ) {
		//saveMyViewPartsColumns(event);
		closeMyViewMerge(event);
	} else	{
		
		var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
		AlertMessageShow(s_ret);
		return;
	}	
}


		private function faultMyViewHeaderColumns(evt:FaultEvent):void
		{
			
			
			var faultMessage:String = "Problem occured exporting to XML of MyView Columns.  Check with your Administrator"
			AlertMessageShow(faultMessage);
			return;
		}
		private function resultMyViewColumnsHandler(event:ResultEvent):void
		{
			
			if (event.result.ezware_response.status == 'OK' ) {   
				saveMyViewPartsFilters(event);
			} else	{
				
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
		}
		private function faultMyViewHeaderFilters(evt:FaultEvent):void
		{
			    
			
			var faultMessage:String = "Problem occured exporting to XML of MyView Filters.  Check with your Administrator"
			AlertMessageShow(faultMessage);
			return;
		}
		private function resultMyViewFiltersHandler(event:ResultEvent):void
		{
			
			if (event.result.ezware_response.status == 'OK' ) {
				
				
				if (_xlcHistory == 'Yes'){
				
					saveMyViewQuery(event);
				} else {
					
					PopUpManager.removePopUp(popcmmyviews);
					
					if (myview_level >0 ){
						//Alert.show(pop404.local_crunch);
						if (pop404.local_crunch == "Grand Total"){
							pre_saveMyViewCrunch(event);
						}
						if (pop404.local_crunch == "Sub Total"){
							pre_saveMyViewCrunchSubTotal(event);
						}
						
						 
						
					}
					MyViewButtons.send();
				}
				
			} else	{
				
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
		}  
		private function faultMyViewHeaderQuery(evt:FaultEvent):void
		{
			
			
			var faultMessage:String = "Problem occured exporting to XML of MyView Query.  Check with your Administrator"
			AlertMessageShow(faultMessage);
			return;
		}
			private function faultMyViewCrunch(evt:FaultEvent):void
			{
				
				
				var faultMessage:String = "Problem occured exporting to XML of MyView Crunch.  Check with your Administrator"
				AlertMessageShow(faultMessage);
				return;
			}
			
			private function faultMyViewChart(evt:FaultEvent):void
			{
				
				
				var faultMessage:String = "Problem occured exporting to XML of MyView Chart.  Check with your Administrator"
				AlertMessageShow(faultMessage);
				return;
			}
			private function resultmyViewChart(evt:Event):void{
				MyViewButtons.send();
			}
			private function faultMyViewCrunchSub(evt:FaultEvent):void
			{
				
				
				var faultMessage:String = "Problem occured exporting to XML of MyView Sub Crunch.  Check with your Administrator"
				AlertMessageShow(faultMessage);
				return;
			}

		private function resultMyViewQueryHandler(event:ResultEvent):void
		{
			
			if (event.result.ezware_response.status == 'OK' ) {
				
				
				PopUpManager.removePopUp(popcmmyviews);
			
				if (myview_level >  0){
					
					if (pop404.local_crunch == "Grand Total"){
						pre_saveMyViewCrunch(event);
						//saveCurSort_crunch(event);
						//saveMyViewCrunch(event);
					}
					if (pop404.local_crunch == "Sub Total"){
						pre_saveMyViewCrunchSubTotal(event);
						//saveCurSort_crunch(event);
						//saveMyViewCrunchSubTotal(event);
					}

					
					
				}
				
				
				
			} else	{
				
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;    
			}	
		}
   


		private function MvQueryHandler(evt:ResultEvent):void{
			//	Alert.show(reqParms);
			if (evt.result.ezware_response.status == "OK"){		
				
				history_reqParms_str = evt.result.ezware_response.refresh_data.mvquery.querydetl;
				auto_apply_str = evt.result.ezware_response.refresh_data.mvquery.auto_apply;
				
				updatedMySquery(evt, history_reqParms_str);
				
			} else	{
				
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}
		}




		private function updatedMySquery(evt:Event, parms:String):void{
			//Alert.show("check 10");
			var str_segmentquery_array:Array = [];
			var str_query_array:Array = [];
			var str_arraycol:ArrayCollection = new ArrayCollection;
			
			var str_querydetl:String = new String;
			var str_len:int;
			var str_query:String = new String;
			
			if (parms == null){
				parms = "";
			}
			   
			
			str_querydetl = parms 
			
				
				
			if (parms != ""){
				str_segmentquery_array = str_querydetl.split("|");
				str_len = str_segmentquery_array.length;
				
				historyParametersQuery = new ArrayCollection;
				   
				for (var i:int=0; i<str_len;i++){
					str_query = str_segmentquery_array[i].toString();
					str_query_array = [];
					str_query_array = str_query.split(",");
					str_arraycol = new ArrayCollection;
					
					
					var newObj:Object = new Object;
					newObj.hp_dataField = str_query_array[1].substr(str_query_array[1].lastIndexOf(":") + 1,str_query_array[1].length);
					newObj.hp_datatype = str_query_array[0].substr(str_query_array[0].lastIndexOf(":") + 1,str_query_array[0].length)
					newObj.hp_value = str_query_array[2].substr(str_query_array[2].lastIndexOf(":") + 1,str_query_array[2].length);
					historyParametersQuery.addItem(newObj);   
					
					
					
				}
		}
				history_reqParms_str = parms;
				
				
				      
				
				//  retrieve 
				reqParms = "REFRESH," + mainBoard + "," + myName_main + "," + _xlcRenditionCode;
				       
				  // Alert.show(auto_apply_str);
				if (auto_apply_str == 'N'){
					PopUpManager.removePopUp(myAlert);   
					PopUpManager.removePopUp(popwait);
					//Alert.show("Test 2");
					//closeMyView(evt);
					PopUpManager.removePopUp(popmyviews);
					//Alert.show("Test 1");
					tdObjectCollection = new ArrayCollection;
					Array1 = new ArrayCollection;
					Array2 = new ArrayCollection;
					
					launchHistoryRetrievalMultipleParameters(evt,_xlcDynamicIndicator);
					
				} else {
					dataList_history.send();    
				}  

				
				
	 
		}

		     
		private function resultMyViewCrunchHandler(evt:ResultEvent):void{
			  
			if (evt.result.ezware_response.status == "OK"){		
			
				if (myview_level > 1){
					//Alert.show(pop404.local_crunch);
					if (popshowChart_crunch.showlocal_crunch == "Grand Total"){
						saveMyViewChart(evt);
					}
					
					if (popshowChart_crunch.showlocal_crunch == "Sub Total"){
						saveMyViewChart(evt);
					}
					
					MyViewButtons.send();  
					
				}   
				
			} else	{
				
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);    
				return;
			}
		}   



		private function MvCrunchHandler(evt:ResultEvent):void{
			
			if (evt.result.ezware_response.refresh_data.data.crunch == 'grandtotal'){
				
				
				////////////////////////////////////////////////////////////////////////////////////
				fd_crunch = new ArrayCollection;         
				fdp_crunch = new ArrayCollection;
				ArrayDetailPandT_GrandTotal_Crunch = new ArrayCollection();
				
				if (evt.result.ezware_response.refresh_data.filterdetails.filterdetail == null)
				{
					ArrayDetailPandT_GrandTotal_Crunch = new ArrayCollection();
				}
				else if (evt.result.ezware_response.refresh_data.filterdetails.filterdetail is ArrayCollection)
				{
					ArrayDetailPandT_GrandTotal_Crunch = evt.result.ezware_response.refresh_data.filterdetails.filterdetail;
				}
				else if (evt.result.ezware_response.refresh_data.filterdetails.filterdetail is ObjectProxy)
				{
					ArrayDetailPandT_GrandTotal_Crunch = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.filterdetails.filterdetail)); 
				}   
				 
				
				for (var iadpt:int=0;iadpt < ArrayDetailPandT_GrandTotal_Crunch.length; iadpt++)  {
					if (ArrayDetailPandT_GrandTotal_Crunch[iadpt].save_as == "T"){
						fd_crunch.addItem(ArrayDetailPandT_GrandTotal_Crunch[iadpt]);	
					} else {
						fdp_crunch.addItem(ArrayDetailPandT_GrandTotal_Crunch[iadpt]);
					}
				}
				//	buildDatagrid();    
				
				
				fd_crunch.refresh();         
				fdp_crunch.refresh();   
				// Remove this for now.  3/11/2013	
				//	erase(event);
				
				//correctWidth(event);
				
				//flagger(event);
				
				//executePersistentDefault(event); 
				
				
				
				 
				
				//////////////////////////////////////////////////////////////////////////////////////
				
				
				
				
				
				
				
				
				
				
				
				//PopUpManager.removePopUp(popmyviews);
				ca_sort(evt); 
				
				
				
				
			}
			if (evt.result.ezware_response.refresh_data.data.crunch == 'subtotal'){
				////////////////////////////////////////////////////////////////////////////////////
				fd_crunch = new ArrayCollection;         
				fdp_crunch = new ArrayCollection;
				ArrayDetailPandT_GrandTotal_Crunch = new ArrayCollection();
				
				if (evt.result.ezware_response.refresh_data.filterdetails.filterdetail == null)
				{
					ArrayDetailPandT_GrandTotal_Crunch = new ArrayCollection();
				}
				else if (evt.result.ezware_response.refresh_data.filterdetails.filterdetail is ArrayCollection)
				{
					ArrayDetailPandT_GrandTotal_Crunch = evt.result.ezware_response.refresh_data.filterdetails.filterdetail;
				}
				else if (evt.result.ezware_response.refresh_data.filterdetails.filterdetail is ObjectProxy)
				{
					ArrayDetailPandT_GrandTotal_Crunch = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.filterdetails.filterdetail)); 
				}   
				
				
				for (var iadpt:int=0;iadpt < ArrayDetailPandT_GrandTotal_Crunch.length; iadpt++)  {
					if (ArrayDetailPandT_GrandTotal_Crunch[iadpt].save_as == "T"){
						fd_crunch.addItem(ArrayDetailPandT_GrandTotal_Crunch[iadpt]);	
					} else {
						fdp_crunch.addItem(ArrayDetailPandT_GrandTotal_Crunch[iadpt]);
					}
				}
				//	buildDatagrid();    
				
				
				fd_crunch.refresh();         
				fdp_crunch.refresh();   
				// Remove this for now.  3/11/2013	
				//	erase(event);
				
				//correctWidth(event);
				
				//flagger(event);
				
				//executePersistentDefault(event); 
				
				
				//Alert.show(fdp_crunch.length.toString());
				
				
				//////////////////////////////////////////////////////////////////////////////////////
				
				
				PopUpManager.removePopUp(popmyviews);
				launch_SubCrunch(evt);
				pop9.cb_sort.selectedIndex = evt.result.ezware_response.refresh_data.data.column;
				
				crunch_subtotal(evt);      
			}
			
			
		}   
		
		private function MvChartHandler(event:ResultEvent):void{
			
			if (event.result.ezware_response.status == 'OK' ) {
				if (event.result.ezware_response.refresh_data.data.select != "nothing"){
					showChart_crunch_parameter(event, event.result.ezware_response.refresh_data.data.select, event.result.ezware_response.refresh_data.data.type,event.result.ezware_response.refresh_data.data.maxnumrows);
				}
			} else	{
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
		}   

		private function MvChartHandlerSubTotal(event:ResultEvent):void{
			
			if (event.result.ezware_response.status == 'OK' ) {
				if (event.result.ezware_response.refresh_data.data.select != "nothing"){
					showChartSubTotal_parameter(event, event.result.ezware_response.refresh_data.data.select, event.result.ezware_response.refresh_data.data.type, event.result.ezware_response.refresh_data.data.maxnumrows);
				}
			} else	{
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
		}   

		private function MyViewSequenceHandler(event:ResultEvent):void{
			
			if (event.result.ezware_response.status == 'OK' ) {
				MyViewButtons.send();
			} else	{
				var s_ret:String = resultStatus(event.result.ezware_response.status, event.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}	
		}


private var DateValueArr:ArrayCollection = new ArrayCollection; 
		private function ValueDateListHandler(evt:ResultEvent):void{
			DateValueArr = new ArrayCollection;
			if (evt.result.ezware_response.status == "OK"){		
				
				
				
				
				if (evt.result.ezware_response.refresh_data.variable_dates.data == null)
				{
					DateValueArr = new ArrayCollection();
				}   
				else if (evt.result.ezware_response.refresh_data.variable_dates.data is ArrayCollection)
				{
					DateValueArr = evt.result.ezware_response.refresh_data.variable_dates.data;
				}
				else if (evt.result.ezware_response.refresh_data.variable_dates.data is ObjectProxy)
				{
					DateValueArr = new ArrayCollection(mx.utils.ArrayUtil.toArray(evt.result.ezware_response.refresh_data.variable_dates.data));
					//DateValueArr = new ArrayCollection(mx.utils.ArrayUtil.toArray(evt.result.ezware_response.refresh_data.variable_dates.data));
					//DateValueArr = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.variable_dates.data));
					//	DateValueArr = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.variable_dates.data));
					//	_LotxlcColumn = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.root.AdvancedDataGridColumn.column));
				}
				
				
				
				DateValueArr.refresh();
				
				
				
				
				
				
				
			} else	{  
				
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}
		} 
private function getValueDatefaultListHandler(evt:FaultEvent):void
{     
	var faultMessage:String = "Value Date Problem: " + evt.message;
	
	AlertMessageShow(faultMessage);
}
