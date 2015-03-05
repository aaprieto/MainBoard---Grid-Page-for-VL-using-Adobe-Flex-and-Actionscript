// ActionScript file
import mx.collections.ArrayCollection;
import mx.collections.XMLListCollection;
import mx.rpc.events.ResultEvent;
import mx.utils.ArrayUtil;


//private var bm:IBrowserManager;
		private function mainboardlistresult(evt:ResultEvent):void{
		 
			if (evt.result.status == 'OK' ) {
			
			
		 			tdMainBoard=evt.result.refresh_data.mainboards.mainboard; 
					my_c_code_description = evt.result.refresh_data.mainboards.mainboard.mbdescription;
		 			
					if (application_entry == 'ml'){
						applicationlabel.text = cyber_name + ' ' + (evt.result.refresh_data.mainboards.mainboard.mbdescription);
					
						bm = BrowserManager.getInstance();
						bm.init("",applicationlabel.text);
					
					
					} else {
						
						
						applicationlabel.text = my_c_code + ' ' + (evt.result.refresh_data.mainboards.mainboard.mbdescription);
						
						/*
						var str = applicationlabel.text;
						Alert.show(str.indexOf("@").toString());
						*/    
						if (applicationlabel.text.indexOf("@") > 0){
							applicationlabel.text = applicationlabel.text.substr(0,applicationlabel.text.indexOf("@")) 	
						
						}   
						   
					
					}
					
					MainBoardDatagridList();
			} else{
				var s_ret:String = resultStatus(evt.result.status, evt.result.reason);  
				AlertMessageShow(s_ret);
				return;
			}
			
					
			
			
 		}
		private function resultStatus(string_result:String, string_reason:String):String{
			var retstr:String = string_reason;
			
			if (string_result == "EXPIRED"){
				retstr = "Session EXPIRED due to inactivity.  Please log out and log back in again to create a new session.";
			} 
			if (string_result == "FAIL"){
				retstr = string_reason + '. Please log out and log back in again to create a new session.';
			} 
			
			return retstr;
		}
 		private function mainboardlistfaultHandler(evt:FaultEvent):void
		{
			AlertMessageShow(evt.message.toString());
		}
		private function mainboarddatagridlistresult(evt:ResultEvent):void{
			
			
			
			if (evt.result.ezware_response.status == 'OK' ) {
						
						tdMainBoardDatagrid = new ArrayCollection();
			 			if (evt.result.ezware_response.refresh_data.mainboarddatagrids.mainboarddatagrid == null)
			            {
			                tdMainBoardDatagrid=new ArrayCollection();
			            }  
			            else if (evt.result.ezware_response.refresh_data.mainboarddatagrids.mainboarddatagrid is ArrayCollection)
			            {
			              tdMainBoardDatagrid=evt.result.ezware_response.refresh_data.mainboarddatagrids.mainboarddatagrid;
			            } 
			            else if (evt.result.ezware_response.refresh_data.mainboarddatagrids.mainboarddatagrid is ObjectProxy)
			            {
			               tdMainBoardDatagrid = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.mainboarddatagrids.mainboarddatagrid)); 
			            }
						tdMainBoardDatagrid.refresh();
						
						// Check for the default action grid code.
						if ((Application.application.parameters.ag) == null){
							actiongrid_code = 0; 
						} else {
							for (var i:int=0;i<tdMainBoardDatagrid.length;i++)  {
								if (Application.application.parameters.ag == tdMainBoardDatagrid[i].mbdcode){
									actiongrid_code = i;
									break;
								}
							}
						}
					//	if (mainboard_type == 'highview'){
							newCheckBox(evt, tdMainBoardDatagrid);
					//	} else{ 	
							   
					//		retrieveDashboards(evt,tdMainBoardDatagrid)
					//	}
							
			} else{
				var s_ret:String = resultStatus(evt.result.ezware_response.status, evt.result.ezware_response.reason);  
				AlertMessageShow(s_ret);
				return;
			}
			
			
			      
 		}
 		private function mainboarddatagridlistfaultHandler(evt:FaultEvent):void
		{
			AlertMessageShow(evt.message.toString())
		}
		
		private function tdOperatorHandler(evt:ResultEvent):void
		{
				tdOperatorBranch=evt.result.kpi_data.kpi_detail;
			 	operator_namer = (tdOperatorBranch["operator_name"]);
			 	operator_branch = (tdOperatorBranch["operator_branch"]);
		}
		private function hoverhelpdomainHandler(evt:ResultEvent):void
		{
				hoverhelp_domain=evt.result.data.domain;
				company_logo=evt.result.data.logo; 
				
		}
		private function faultOperatorHandler(evt:FaultEvent):void
		{
			 	AlertMessageShow("User for company code: " + my_c_code + " does not exist");
		}
		private function faulthoverhelpdomainHandler(evt:FaultEvent):void
		{
			 	AlertMessageShow("Hover Help Domain does not exist");
		}
		private function tdActionCommandHandler(evt:ResultEvent):void
		{
				
 			tdActionCommand = new ArrayCollection();
 			if (evt.result.ezware_response.refresh_data.actioncommands.actioncommand == null)
            {
                tdActionCommand=new ArrayCollection()
            }
            else if (evt.result.ezware_response.refresh_data.actioncommands.actioncommand is ArrayCollection)
            {
              tdActionCommand=evt.result.ezware_response.refresh_data.actioncommands.actioncommand;
            }
            else if (evt.result.ezware_response.refresh_data.actioncommands.actioncommand is ObjectProxy)
            {
               tdActionCommand = new ArrayCollection(ArrayUtil.toArray(evt.result.ezware_response.refresh_data.actioncommands.actioncommand)); 
            }
			//tdActionCommand.refresh();    
			//Alert.show(tdActionCommand.length.toString());
			takeActionCommand(evt);      
			       
		}
		private function faultActionCommandHandler(evt:FaultEvent):void
		{
			var faultMessage:String = "The origin of this fault is:"+ evt.message; 
			AlertMessageShow(faultMessage);
		}	
		private function runJobResultHandler(event:ResultEvent):void {

			if ( event.result.status != 'OK' ) {
				AlertMessageShow	(
						'runJob failed - ' + event.result.reason
						
						);
			}
			 
		}
		private function hsFaultHandler(event:FaultEvent):void {

			AlertMessageShow	(
					'HTTP request failed - ' + event.message.toString()
					
					);
		}
		private function companyCodeHandler(evt:ResultEvent):void
		{
			if (evt.result.kpi_data.company_info == null)
            {
                tdcompany=new ArrayCollection()
            }
            else if (evt.result.kpi_data.company_info is ArrayCollection)
            {
              tdcompany=evt.result.kpi_data.company_info;
            }
            else if (evt.result.kpi_data.company_info is ObjectProxy)
            {
               tdcompany = new ArrayCollection(ArrayUtil.toArray(evt.result.kpi_data.company_info)); 
            }
			
			tdcompany.refresh();
			for (var i:int=0;i<tdcompany.length;i++)  {
    						if (my_c_code == tdcompany[i].company){
    							my_c_code_description = tdcompany[i].company_desc;
    						}
 			}
		}		
		
		private function globalvariableMouseHoverHandler(evt:ResultEvent):void
		{
			mousehoverpars = Application.application.parameters.mh;
		}	
		private function faultglobalvariableMouseHoverHandler(evt:FaultEvent):void
		{
			var faultMessage:String = "The origin of this fault is:"+ evt.message; 
			AlertMessageShow(faultMessage);
		}	
		private function ezlinkHandlerHV(event:ResultEvent):void {
			//navigateToURL(new URLRequest(event.result.ezware_response.refresh_data.root.ezlink), 'quote')
			ezlearnlink = event.result.ezware_response.refresh_data.root.ezlink;
		//	Alert.show(ezlearnlink);
		}
		private function EZLinkFaultHandlerHV(evt:FaultEvent):void
		{
			var faultMessage:String = "No definition of EZLearn Link on the HighViews.  Please contact your System Administrator";
			AlertMessageShow(faultMessage)
		}