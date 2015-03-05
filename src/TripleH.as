// ActionScript file
import mx.events.AdvancedDataGridEvent;
import flash.events.MouseEvent;
   			
   			/////////   Procedure for MouseHover as per Tim Legere
   			public var pophoverinterface:MouseHoverMenu;
   			private const TIMER_INTERVAL_FOR_HOVER:int = 1500;
   			public var nt:Timer;
   			public var objecttitle:String;
   			public var objecttitleheader:String;
   			
   			private function mousehovering_forhelp(event:Event, object_id:String, object_type:String):void{
				if (parentApplication.mousehoverpars == "YES"){
						// http://rhcert.tor.maves.ca/maves/vl/helpdocs/VLHelp/ApplicationHelp.htm
						//var url:String = "http://rhcert.tor.maves.ca/maves/vl/helpdocs/VLHelp/Content/HoverText/HV-Clear.htm";
						var url:String = "http://rhcert.tor.maves.ca/maves/vl/helpdocs/VLHelp/ApplicationHelp_CSH.htm#1000";
						var request:URLRequest = new URLRequest(url);
						try { 
  								navigateToURL(request, '_blank'); // second argument is target
  										//_blank, _self, _parent, _top ?
							} catch (e:Error) {
  								trace("Error occurred!");
							}
						
						
				
				}
   			}
   			private function mousehovering(event:Event, object_id:String, object_type:String):void{
				
				if (parentApplication.mousehoverpars == "YES"){
					objecttitle = object_id;
					//Alert.show(objecttitle);
					objecttitleheader =  object_type;
            		nt = new Timer(TIMER_INTERVAL_FOR_HOVER);
                	nt.addEventListener(TimerEvent.TIMER, updateHoverTimer_old); 
                	//stopHoverTimer();
                	startHoverTimer();
            		//removeMe_fdr(event);
				}
            }	
            
            
           private function eZLearn_for_help_actiongrid():void{
   					//var urlpass:String = "../helpdocs/VLHelp/ApplicationHelp_CSH.htm#" + objecttitle;
   					var urlpass:String = hover_help_actiongrid_domain + objecttitle;
   					
					var jscommand:String = "window.open('" + urlpass + "','win','top=100,left=0,height=775,width=900,toolbar=no,scrollbars=yes');"; 
					//Alert.show(jscommand);
					var url:URLRequest = new URLRequest("javascript:" + jscommand + " void(0);"); 
					navigateToURL(url, "_self");
			}
			private function updateHoverTimer(evt:TimerEvent):void {
   				//Alert.show(objecttitle);
   				stopHoverTimer();
   				 eZLearn_for_help_actiongrid();
   				/*if (parentApplication.mousehoverpars == "YES"){
   					pophoverinterface = MouseHoverMenu(
                	PopUpManager.createPopUp(this, MouseHoverMenu,true));
                	pophoverinterface.helpfortitle = objecttitle;
                	pophoverinterface.object_type = objecttitleheader;
					pophoverinterface.loc_ccode = my_c_code1;
					pophoverinterface.loc_sid = my_sid;
   				} */
		    } 
   			private function updateHoverTimer_old(evt:TimerEvent):void {
   				
   				stopHoverTimer();
				
   				if (parentApplication.mousehoverpars == "YES"){
   					pophoverinterface = MouseHoverMenu(
                	PopUpManager.createPopUp(this, MouseHoverMenu,true));
                	pophoverinterface.helpfortitle = objecttitle;
                	pophoverinterface.object_type = objecttitleheader;
					pophoverinterface.loc_ccode = my_c_code1;
					pophoverinterface.loc_sid = my_sid;
					pophoverinterface.loc_appcode = ag_application_entry
   				}
				
		    }
   			private function startHoverTimer():void {
                //baseTimer = getTimer();
                nt.start(); 
            }
            public function stopHoverTimer():void {
                 nt.stop();
            } 
   			private function cellRollOver(event: ListEvent):void{
   				
 					// Get the target of this event (Datagrid) 
						var dataGrid:AdvancedDataGrid = event.target as AdvancedDataGrid; 
					// Get selected column index 
						var columname:String = new String;
						var dsColumnIndex:Number = event.columnIndex; 
								for (var i:int=0;i<_xlcColumn.length;i++)  { 
			 						var columnId:String = (_xlcColumn[i]["columnId"]);
			 						var title_header:String = (_xlcColumn[i]["title_header"]);
			 						var width:String = (_xlcColumn[i]["width"]);
			 						var datafield:String = (_xlcColumn[i]["dataField"]).toString();
								}
								
						mousehovering(event,Array1[event.rowIndex][_xlcColumn[event.columnIndex]["dataField"]].toString(),'CELL');
   				
   				return;
   			}
   			
   			
   			private function columnRollOver(event:MouseEvent):void{
   				Alert.show(event.target.listData.columnIndex.toString() ); 
   			}