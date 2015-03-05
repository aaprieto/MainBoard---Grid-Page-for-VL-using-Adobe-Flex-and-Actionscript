// ActionScript file
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.LocalConnection;
import flash.net.URLRequest;
import flash.xml.XMLDocument;

import mx.collections.ArrayCollection;
import mx.core.Application;
import mx.core.FlexGlobals;
import mx.events.BrowserChangeEvent;
import mx.events.CloseEvent;
import mx.managers.BrowserManager;
import mx.managers.IBrowserManager;
import mx.rpc.xml.SimpleXMLDecoder;

private var conn:LocalConnection;
        
 
		
private var bm:IBrowserManager;

//  mainboard_type:
//   1.  dashboard
//   2.  highview
public var mainboard_type:String = 'dashboard';  
[Bindable]
private var myLogisticsarr_Logmenu:ArrayCollection = new ArrayCollection;

//private var ArrayRetainComboGroup:ArrayCollection = new ArrayCollection;	
[Bindable]
public var tomylogjobcode:String = new String;
[Bindable]
public var xmltomylogjobcode:XML;
[Bindable]
public var ds_xmltomylogjobcode:ArrayCollection = new ArrayCollection;

        private function init():void{
        	
		   	//Alert.show(mx.core.FlexGlobals.topLevelApplication.parameters.scc);
			if (mx.core.FlexGlobals.topLevelApplication.parameters.app == "ml"){
				mainboard_h_command.visible = false;
				//mainboard_h_command.width = 0;
				btn_browse_jobs.visible = false;
				//btn_browse_jobs.width = 0
					
					
				mylogistics_menu.visible = true;
				mylogistics_menu.width=400;
				
				
				
				tomylogjobcode= mx.core.FlexGlobals.topLevelApplication.parameters.mylogjob;
				
				xmltomylogjobcode = new XML(tomylogjobcode);
				myLogisticsarr_Logmenu = convertXmlToArrayCollection(xmltomylogjobcode);
				ds_xmltomylogjobcode = new ArrayCollection;
				for (var ib:int=0;ib<myLogisticsarr_Logmenu.length;ib++){
					var newObj:Object = new Object();
					
					
					
					newObj.loc_cybername = myLogisticsarr_Logmenu[ib].cybername;
					newObj.loc_name = myLogisticsarr_Logmenu[ib].name;
					newObj.loc_cn = myLogisticsarr_Logmenu[ib].cybername + " - " + myLogisticsarr_Logmenu[ib].name; 
					newObj.loc_image = myLogisticsarr_Logmenu[ib].image;
					newObj.loc_launchHighViewparam = myLogisticsarr_Logmenu[ib].job_program
					newObj.loc_company = myLogisticsarr_Logmenu[ib].company
						
					ds_xmltomylogjobcode.addItem(newObj); 
					
				}
				
				
			}
			 
			
     		toxml_mbcode 	= mx.core.FlexGlobals.topLevelApplication.parameters.mb;
     		chainCode 		= mx.core.FlexGlobals.topLevelApplication.parameters.ch; 
     		sub_sys 		= mx.core.FlexGlobals.topLevelApplication.parameters.subsys; 
        	myName 			= mx.core.FlexGlobals.topLevelApplication.parameters.u;
			myNameDescription = mx.core.FlexGlobals.topLevelApplication.parameters.n;
        	session_id 		= mx.core.FlexGlobals.topLevelApplication.parameters.sid;
        	my_c_code 		= mx.core.FlexGlobals.topLevelApplication.parameters.c;
			access_rendition = mx.core.FlexGlobals.topLevelApplication.parameters.ar;
			access_view = 	mx.core.FlexGlobals.topLevelApplication.parameters.av;
			speed_options = mx.core.FlexGlobals.topLevelApplication.parameters.so;
			application_entry = mx.core.FlexGlobals.topLevelApplication.parameters.app;
			cyber_name = Application.application.parameters.cbn;  // This is coming from the query url string;
			client_restriction = mx.core.FlexGlobals.topLevelApplication.parameters.crcc;
			shortcut_myviewcode = mx.core.FlexGlobals.topLevelApplication.parameters.scc;
			
			if (speed_options =='basic'){
				 this.setStyle("backgroundImage","");
			 } else {
				 this.setStyle("backgroundImage","image/Blue3.png")
			 }
		
			bm = BrowserManager.getInstance();      
			bm.init("", my_c_code + " " + toxml_mbcode);
	 		
        	config.send(); // retrieve hover help domain
			
			
        
        	EZLinkJob.send();
        	ToolTip.maxWidth = 1000;
        	MainBoardList(); 
        	       
             detectScreenResolutionforHighView();   
        	passHoverVariable();
        	mousehoverparslabel = "OFF"
        	initFocus(); 
        	
         	
        } 
        	
		private function convertXmlToArrayCollection( file:String ):ArrayCollection
		{
			var xml:XMLDocument = new XMLDocument( file );
			
			var decoder:SimpleXMLDecoder = new SimpleXMLDecoder();
			var data:Object = decoder.decodeXML( xml );
			var array:Array = ArrayUtil.toArray( data.mljobs.mljob );
			
			return new ArrayCollection( array );
		}
		private function passHoverVariable():void{
				httpMouseHoverVariable.url = "../dashhome/rd_settings.php?sid=" + session_id + "&mh=NO";	  
				httpMouseHoverVariable.send();
			
		}  

         private function initFocus():void{
							
					   if (ExternalInterface.available) {
       						 ExternalInterface.call('setFocus');
    						} else {
        					AlertMessageShow("Browser not available");
    						}
		}
        
        private function MainBoardList():void 
		{
			
				g_action =  "refreshData";
				reqParms = "REFRESH,RETRIEVE|MAINBOARD|" + toxml_mbcode + "|"; 
				mainboardlist.send();
		}	
        private function MainBoardDatagridList():void 
		{
			
		    	g_action =  "refreshData";
				reqParms = "REFRESH,RETRIEVE|DATAGRID|" + toxml_mbcode + "|"; 
				mainboarddatagridlist.send();
		    	
		}	
        private function closeApp():void
   		{
		       
			   if (mx.core.FlexGlobals.topLevelApplication.parameters.app == "ml"){
				   
				   alertListener();
				   
				   
			   } else{
				   var urlString:String = "javascript:self.close()";
				   var request:URLRequest = new URLRequest(urlString);
				   navigateToURL(request, "_self");
				   
			   }
			   
			   
  		 }
  		 
  		 



[Embed(source='image/Question_Mark_Orb_175.png')]
private var confirmIcon:Class;
private function alertListener():void {
	
	Alert.okLabel = "Log-out";
	Alert.buttonWidth = 140;
	
	// instantiate the Alert box
	var a:Alert = Alert.show(
		"Are you sure you want to navigate away from this page?\n"  +
		"Leaving this page will cause you to lose any unsaved data (related tabs and windows should be closed first).\n"  +
		"Press Log-out or Cancel to stay on the current page.\n",
		"Confirmation of Log-out",
		Alert.OK|Alert.CANCEL,
		this, 
		confirmHandler,
		confirmIcon,
		Alert.CANCEL
	);
	
	// modify the look of the Alert box
	a.setStyle("backgroundColor", '#C3D9FA');
	a.setStyle("borderColor", 0xffffff);
	a.setStyle("borderAlpha", 0.75);
	a.setStyle("fontSize", 14); 
	a.setStyle("fontWeight", "bold");
	a.setStyle("color", 0x000000); // text color
}
private function confirmHandler(event:CloseEvent):void {
	
	if (event.detail == Alert.OK) {
		// what to do if user selected "yes"
		httpLogout.send();
	} 
	/*
	else if (event.detail == Alert.NO) {
	// what to do if user selected "no"
	result.text = “No”;
	}
	*/
}




private function logoutResultHandler(event:ResultEvent):void {
	if ( event.result.status != 'OK' ) {
		
		AlertMessageShow	(
			'logout failed - ' + event.result.reason
		);
	} 
	navigateToURL(new URLRequest('../dashhome/mylogistics.html'), '_self')
}
  		  public var poptotsel:DrillDown;
  		   private function launchdrilldown(event:Event):void {
            	
               	poptotsel = DrillDown(
                PopUpManager.createPopUp(this, DrillDown, false));
                poptotsel.width = 1600;
                poptotsel.height = 800
   		    }
  		 
  		 
  		 public var popezlearnmenu:EZLearnMenu;	
 	
  		public function launchEZLearnMenu(event:Event):void{
  		 	if (mousehoverparslabel == "OFF")
  		 	{
  	           	mousehoverparslabel = "ON"
  	           	mousehoverpars = "YES";
      			
      		}
      		else
  		 	{
  		 		mousehoverpars = "NO";
  		 		mousehoverparslabel = "OFF"
  	   		}
      		
         }
    	 private function switchedHover(event:Event):void{
  		 		mousehoverpars = "YES";
  		 		mousehoverparslabel = "ON"
  		 	
  		 	PopUpManager.removePopUp(popezlearnmenu);
  		 	
  		 }

		public var mbdg_popmylogistics:MyLogisticsPopMenu;
		private function openMyLogisticsMainMenu():void
		{
			mbdg_popmylogistics = MyLogisticsPopMenu(
				PopUpManager.createPopUp(this, MyLogisticsPopMenu,true));
			//session_id
			//my_c_code
			
			mbdg_popmylogistics.loc_ccode = my_c_code;
			mbdg_popmylogistics.loc_sid = session_id;
			mbdg_popmylogistics.loc_appcode = 'ml';
			mbdg_popmylogistics.loc_username = myName;
			mbdg_popmylogistics.loc_xmljobs = xmltomylogjobcode;
			PopUpManager.centerPopUp(mbdg_popmylogistics);
			
			
			/*mbdg_pophoverinterface.helpfortitleheader = mbdg_objecthelpfortitle;
			mbdg_pophoverinterface.helpfortitle = mbdg_objecttitle;
			mbdg_pophoverinterface.object_type = mbdg_objecttitleheader;
			mbdg_pophoverinterface.loc_ccode = my_c_code; 
			mbdg_pophoverinterface.loc_sid = session_id;
			mbdg_pophoverinterface.loc_appcode = application_entry;
			*/
		}

		private function change_mylogmenu():void{
			//Alert.show(mylogistics_menu.selectedItem.loc_launchHighViewparam);
			navigateToURL(new URLRequest(mylogistics_menu.selectedItem.loc_launchHighViewparam +'&c='+ my_c_code + '&app=ml'+ '&cbn=' + mylogistics_menu.selectedItem.loc_cybername),'_self');
		}

		private function httpRequestUrlMainboard(str_app:String):void{
		  /*  I will just leave this for vl and ml for now.  I believe there will be another one coming for the mobileweb */ 
			if (str_app == 'ml'){
				
				tdJobCodeMainboard.url = 'ae_tlch_ml_req.php'; 
				mainboardlist.url = 'ae_tlch_ml_req.php';
				mainboarddatagridlist.url = 'ae_tlch_ml_req.php'; 
				trigger_job.url = 'ae_tlch_ml_req.php';
				EZLinkJob .url = 'ae_tlch_ml_req.php';

			} else {
				
				tdJobCodeMainboard.url = 'ae_tlch_xmlreq.php'; 
				mainboardlist.url = 'ae_tlch_xmlreq.php';
				mainboarddatagridlist.url = 'ae_tlch_xmlreq.php'; 
				trigger_job.url = 'ae_tlch_xmlreq.php';
				EZLinkJob .url = 'ae_tlch_xmlreq.php';
			
			}
		
		}
  		 