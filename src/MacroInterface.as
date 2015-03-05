// ActionScript file
import flash.events.Event;
import flash.ui.Keyboard;

import mx.collections.ArrayCollection;


		public var usercode:String = myName_main;
		public var view_type:String;
		
        private function savecurrent(event:Event):void {
            	del_sel();
        }

		private function res_defaultpersistentview(event:Event):void {
			
			var dgviewws_si:int = pop_views.dg_views.selectedIndex;
			
			for( var i:int = 0; i < pop_views.arr_views.length; i++ ){
				if (dgviewws_si == i){
					pop_views.arr_views[i].default_view = "Y";
				} else {
					pop_views.arr_views[i].default_view = "N";
				}
				
			}
			AlertMessageShow("Default will take effect the next time you enter the HighView and/or change Renditions. Otherwise, re-select the record and click on 'Apply' for the rendition to take effect without reloading. ");
		
		}
        private function res_delfiltercode(event:Event):void {
			
			//  Remove this for now.  4/12/2013
			//initfilterheaderlist(_xlcCode); 
			// Replace with
			initfilterdetaillist(event,_xlcCode);
        	
        	  erase(event);
        	dg.horizontalScrollPosition = 0;
        	correctWidth(event);
        }
        
         private function deleteres(event:Event):void {
				 
		         	if (saveviews == "P"){
		         		toxml_filtercode = lbl_persistent_view.text;
		         	}
					if (saveviews == "T"){
		         		toxml_filtercode = lbl_transient_view.text;
		         	}
						
						if (toxml_filtercode == ""){
							if (Array1.sort.toString() != null){
									removeLastArrayRecord(event);
							}
							AlertMessageShow("Pls. select a Macro to update");
							return;
						}
						toxml_usercode = myName_main;
						toxml_xmlheaderdoccode = _xlcCode;
		    			reqParms = "REFRESH,CREATE|FILTERHEADER|" + userfh + "|" + toxml_filtercode + "|" + toxml_filterdescription + "|" + _xlcCode + "|" + _xlcTitle + "|001|" + saveviews + "|";
						createheadermm2.send();
		           		ror_inc = 0;
		            	ror_main_inc(event);
			
			 
		 } 
        
        
        
        private function ror_main_inc(event:Event):void 
		{
				
		    	if (ror_inc < ArrayFilterInsert.length){					
		    						toxml_datatype = (ArrayFilterInsert[ror_inc].type.toString());
									toxml_datafield = (ArrayFilterInsert[ror_inc].column.toString());
									toxml_value = (ArrayFilterInsert[ror_inc].value.toString());
									toxml_action = (ArrayFilterInsert[ror_inc].action.toString());
									g_my_action =  "refreshData";
									reqParms = "REFRESH,CREATE|FILTERDETAIL|" + toxml_action + "|" + toxml_datafield + "|" + toxml_datatype + "|" + toxml_filtercode + "|" + userfh + "|" + toxml_value + "|" + toxml_xmlheaderdoccode + "|" + ror_inc  + "|" +  saveviews + "|";
									createupdate.send();
									ror_inc++;
		    	}
           		if (ror_inc >= ArrayFilterInsert.length){
           		removeMe_4(event);
           		removeMe_2(event);
           		initfilterdetaillist(event, toxml_xmlheaderdoccode);
           		}
        }	
        private function del_sel():void 
		{
		   		g_my_action =  "refreshData";
			if (saveviews == "P"){
         			reqParms = "REFRESH,DELETE|FILTERDETAILS|" + userfh  + "|" + c_utils.trim(_xlcCode) + "|" + c_utils.trim(lbl_persistent_view.text) + "|" + saveviews + "|" ;
         	}
			if (saveviews == "T"){
         			reqParms = "REFRESH,DELETE|FILTERDETAILS|" + userfh  + "|" + c_utils.trim(_xlcCode) + "|" + c_utils.trim(lbl_transient_view.text) + "|" + saveviews + "|" ;
		   	
         	}
		    	deletelist.send();
		}	

		private function querychangecolumns(event:Event):void{
			
		}


/*
		private function initfilterheaderlist(xmlcode:String):void {
	     
			g_my_action =  "refreshData";
			reqParmsheader = "REFRESH,RETRIEVE|FILTERHEADER|" + myName_main + "|" + xmlcode + "|"+ _xlcRenditionCode + "|";
	      		filterheaderlist.send();
			      
        }
*/
        private function initfilterdetaillist(evt:Event,xmlcode:String):void {
        	
        	g_my_action =  "refreshData";
			// reqParmsdetail = "REFRESH,RETRIEVE|FILTERDETAILS|" + myName_main + "|" + xmlcode + "|";
			reqParmsdetail = "REFRESH,RETRIEVE|FILTERDETAIL|" + myName_main + "|" + xmlcode + "|" +  _xlcRenditionCode + "|";
        		filterdetaillist.send();     
		} 
		 
	   	private function updateheadermm(xmlcode:String):void {
			g_my_action =  "refreshData";
			reqParms = "REFRESH,RETRIEVE|FILTERHEADERS|" + myName_main + "|" + xmlcode + "|" + _xlcRenditionCode + "|"; 
			filterheaderlist.send();
		}
		private function updateheadermm2(xmlcode:String):void {
			g_my_action =  "refreshData";
			reqParms = "REFRESH,RETRIEVE|FILTERHEADERS|" + myName_main + "|" + xmlcode + "|" + _xlcRenditionCode + "|"; 
			filterheaderlist2.send();
		}
	   	private function MaintainMacroHeader(event:Event, filtercode:String, filterdescription:String,user_for_views:String):void { 
	   		toxml_filtercode = filtercode;		
			toxml_filterdescription = filterdescription;	
			toxml_usercode = user_for_views;	
			toxml_xmlheaderdoccode = _xlcCode;
			
			var userfh:String = new String;
				if  (saveviews == 'P'){
					for( var h:int = 0; h < fhp.length; h++ ){
						if (toxml_filtercode.toLowerCase() == (fhp[h].filtercode.toString()).toLowerCase()){
							if (Array1.sort != null){
								removeLastArrayRecord(event);
							}
							if (pop4.spy.selected == true){
								removeLastArrayRecord(event);
							}
						
							AlertMessageShow("Code Already Exists");
							return;
						
						}
				
					}
				}
				if  (saveviews == 'T'){
					for( var h:int = 0; h < fh.length; h++ ){
						if (toxml_filtercode.toLowerCase() == (fh[h].filtercode.toString()).toLowerCase()){
						// This will remove saved configuration
						// for sort
						if (Array1.sort != null){
							removeLastArrayRecord(event);
						}
						// for panel
						if (pop4.spy.selected == true){
							removeLastArrayRecord(event);
						}
						AlertMessageShow("Code Already Exists");
						return;
						}
					}
				}
				
				g_my_action =  "refreshData";
				reqParms = "REFRESH,CREATE|FILTERHEADER|" + user_for_views + "|" + toxml_filtercode + "|" + toxml_filterdescription + "|" + _xlcCode + "|" + _xlcTitle + "|001|" + saveviews + "|";
		    	createheadermm2.send();
    	    	ror_inc = 0; 
            	ror_main_inc_2(event);
        }
        
        
          private function ror_main_inc_2(event:Event):void 
		{
		    	if (ror_inc < ArrayFilterInsert.length){
		    						toxml_datatype = (ArrayFilterInsert[ror_inc].type.toString());
									toxml_datafield = (ArrayFilterInsert[ror_inc].column.toString());
									toxml_value = (ArrayFilterInsert[ror_inc].value.toString());
									toxml_action = (ArrayFilterInsert[ror_inc].action.toString());
									g_my_action =  "refreshData";
									reqParms = "REFRESH,CREATE|FILTERDETAIL|" + toxml_action + "|" + toxml_datafield + "|" + toxml_datatype + "|" + toxml_filtercode + "|" + toxml_usercode + "|" + toxml_value + "|" + toxml_xmlheaderdoccode + "|" + ror_inc + "|"+ saveviews +"|"; 
									createupdate.send();
									ror_inc++; 
		    	}
           		if (ror_inc >= ArrayFilterInsert.length){
           			removeMe_5(event);
           			removeMe_2(event);
           			initfilterdetaillist(event, toxml_xmlheaderdoccode);
           			erase(event);
           		}
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

		  public function P_handleAlert() : void
			{
			  
        			if (pop_deleteconfirm.inputcode.text == "YES"){
						//Alert.show("delete confirm: " + pop_views.dg_views.selectedItem.filtercode);
							filterDescription_persistent=''; 
        					filterDescription_transient='';
   							saveviews = "P";
   				   			g_my_action =  "refreshData";
		 					reqParms = "REFRESH,DELETE|FILTERS|" + myName_main  + "|" + c_utils.trim(_xlcCode) + "|" + c_utils.trim(pop_views.dg_views.selectedItem.filtercode) + "|" + saveviews + "|" ;
   						//Alert.show(reqParms);
							deletefiltercodes.send();
        			}
        			PopUpManager.removePopUp(pop_deleteconfirm);
					PopUpManager.removePopUp(pop_views);
			}
		public function T_handleAlert() : void
			{
    				if (pop_deleteconfirm.inputcode.text == "YES"){
    								filterDescription_persistent=''; 
    								filterDescription_transient='';
									saveviews = "T";
   				   					g_my_action =  "refreshData";
   									reqParms = "REFRESH,DELETE|FILTERS|" + myName_main  + "|" + c_utils.trim(_xlcCode) + "|" + c_utils.trim(pop_views.dg_views.selectedItem.filtercode) + "|" + saveviews + "|" ;
   		   							deletefiltercodes.send();
   		   			}
   		   			PopUpManager.removePopUp(pop_deleteconfirm);
					PopUpManager.removePopUp(pop_views);
			}
		public function handleDeleteConfirm( event:Event ) : void
			{
			
				if (pop_deleteconfirm.inputcode.text == "YES"){
					if (view_type == "P"){
						 P_handleAlert();
					}
					if (view_type == "T"){
						 T_handleAlert();
					}
				}	
				if (pop_deleteconfirm.inputcode.text != "YES"){
					
					pop_deleteconfirm.inputcode.setFocus();
      				pop_deleteconfirm.inputcode.drawFocus(true);
      				return;
					
				}
			}	
		 public var pop_deleteconfirm:DeleteConfirm;		
		 private function launch_DeleteConfirm(view_code:String, loc_view_type:String):void {
		 			view_type = loc_view_type;
   		 			pop_deleteconfirm = DeleteConfirm(
   		 		 	PopUpManager.createPopUp(this, DeleteConfirm, true));
   		 		 	pop_deleteconfirm.del_filtercode = view_code;
   		 		 		pop_deleteconfirm["btn_ok"].addEventListener("click",  handleDeleteConfirm);
          				pop_deleteconfirm["inputcode"].addEventListener("enter", handleDeleteConfirm);
          			
   		 }
   		 
			private function default_view(fil_type:String):void{
				if (pop_views.dg_views.selectedItems.length < 1){
					AlertMessageShow("Please Select a Code to default");
					return;   
				}
				reqParms = "REFRESH,UPDATE|DFLTFILTER|" + myName_main + "|" + mainBoard + "|" +pop_views.dg_views.selectedItem.filtercode + "|P|";
				defaultpersistentview.send();
				
				
			}

   			private function del_filterview(fil_type:String):void{
   				// Alert.show(pop_views.dg_views.selectedItem.filtercode);
   				//if (fil_type == "P"){
				
				//Alert.show(myName_main.toUpperCase());
				if (myName_main.toUpperCase() != 'MAVES'){
					if(((pop_views.dg_views.selectedItem.filtercode).toUpperCase()).substr(0,4) == 'BASE'){
						AlertMessageShow("You are not allowed to Delete a 'BASE' Code");
						return;
					}	
				}
				
				
				 if (pop_views.currentfilter_views == "fhp"){
					
					/*
					if ((c_utils.trim(cb_filter_macro_persistent.selectedLabel) == "")||(c_utils.trim(cb_filter_macro_persistent.selectedLabel) == "No selection")){
   						AlertMessageShow("Pls. Select a Filter Code to delete");
   						return
   					}
				*/	
					 	
					if (pop_views.dg_views.selectedItems.length < 1){
						AlertMessageShow("Please Select a Code to delete");
						return;
					}
					// Check User Permission
				
					if ( Application.application.parameters.av == 'O'){
						if ((c_utils.trim(pop_views.dg_views.selectedItem.filtercode).substr(0,1)) != '*'){
							AlertMessageShow("You are not allowed to delete a Generic View");
							return;
						}
					}
					
					if ((c_utils.trim(pop_views.dg_views.selectedItem.filtercode) != "")&&(c_utils.trim(pop_views.dg_views.selectedItem.filtercode) != "No selection")){
                       // Alert.show(pop_views.dg_views.selectedItem.filtercode); 
						launch_DeleteConfirm(c_utils.trim(pop_views.dg_views.selectedItem.filtercode),'P');
						
   					}    
				
   				}
   				//if (fil_type == "T"){
				 
				if (pop_views.currentfilter_views == "fh"){	
   				/* 
					if ((c_utils.trim(cb_filter_macro.selectedLabel) == "")||(c_utils.trim(cb_filter_macro.selectedLabel) == "No selection")){
   						AlertMessageShow("Pls. Select a Filter Code to delete");
   						return
   					}
				*/	
					if (pop_views.dg_views.selectedItems.length < 1){
						AlertMessageShow("Please Select a Code to delete");
						return;
					}
					// Check User Permission
					if ( Application.application.parameters.av == 'O'){
						if ((c_utils.trim(pop_views.dg_views.selectedItem.filtercode).substr(0,1)) != '*'){
							AlertMessageShow("You are not allowed to delete a Generic View");
							return;
						}
					}
   					if ((c_utils.trim(pop_views.dg_views.selectedItem.filtercode) != "")&&(c_utils.trim(pop_views.dg_views.selectedItem.filtercode) != "No selection")){
                         launch_DeleteConfirm(c_utils.trim(pop_views.dg_views.selectedItem.filtercode), 'T');
   					}
   				}
   			}


	private function saveMyViewParts(event:Event):void{
		
		var share:String = new String;
		var auto_apply:String = new String;
		// This will save 4 parts of the MyView process.
		// 1.  the MyView Header first.
			
		if (popcmmyviews.gen.selected == true){
			share = 'Y';     
			
		} else {
			share = 'N';
		}
		
		if (_xlcHistory == 'Yes'){
			if (popcmmyviews.aa_yes.selected == true){
				auto_apply = 'Y';     
				   
			} else {
				auto_apply = 'N';
			}
		} else {
			auto_apply = 'Y';
		}
		
		 
		reqSJ = "";
		reqParmsMyViewParameters = "";
		reqParmsMyViewParameters = "REFRESH,UPDATE|MYVIEW|" + popcmmyviews.inputcode.text + "|" + popcmmyviews.inputdescription.text + "|" +
								share + "|" + myName_main + "|" + mainBoard + "|" + auto_apply +"|" + popcmmyviews.ti_btnlabel.text + "|";
		saveMyViewHeader.send();
		
	}

	private function saveMyViewPartsColumns(event:Event):void{
	  
		reqSJ = "";
		reqParmsMyViewParameters = ""; 
		
		
		
		var finalRenditionXML:String = new String;
		var rendition_head:String = '<rendition>'
		var rendition_tail:String = '</rendition>'
		var rendition_body:String = new String;
		var string_detail:String = new String;	
		var string_final:String = new String();	
		finalRenditionXML = new String;
		
		
		/*  Ask Christine for Rendition on the Initial send of rendition. */
		for(var i:int = 0; i <  Arr_columnRendition.length; i++){
			var dg_type:String = Arr_columnRendition[i]["type"];
			var dg_cn:String = Arr_columnRendition[i]["columnname"];
			var dg_ht:String = Arr_columnRendition[i]["headertext"];
			if ((dg_ht == null) || (dg_ht == 'null')|| (dg_ht == '')){
				dg_ht = '';
			}
			
			
			string_detail = string_detail + '<data>' +
				'<type>' + dg_type + '</type>' +
				'<columnname>' + dg_cn + '</columnname>' +
				'<headertext>' + dg_ht + '</headertext>' +
				'</data>'
		}   
		
		finalRenditionXML = ('REFRESH,UPD_RENDITION,' + rendition_head +
			'<mbdcode>' + mainBoard + '</mbdcode>' +
			'<usercode>' + myName_main + '</usercode>' +
			'<rendcode>' + popcmmyviews.inputcode.text + '</rendcode>' +
			string_detail +
			rendition_tail);
			
		reqParmsMyViewParameters = finalRenditionXML;
		saveMyViewColumns.send();
		
	}

	private function saveMyViewPartsFilters(event:Event):void{
			saveCurSort(event);
	}

	private function saveMyViewPartsFiltersFinal(event:Event):void{
		
		reqSJ = "";
		reqParmsMyViewParameters = ""; 
		
		var finalFilterXML:String = new String;
		
		var filter_head:String = '<filter>'
		var filter_tail:String = '</filter>'
		var filter_body:String = new String;
		var string_detail:String = new String;	
		var string_final:String = new String();	
		finalFilterXML = new String;
		
		
		for(var i:int = 0; i <  (ArrayFilterInsert.length); i++){
			
			/*
			var str:String = "She sells seashells by the seashore."; 
			var pattern:RegExp = /sh/gi; 
			trace(str.replace(pattern, "sch")); 
			//sche sells seaschells by the seaschore. 
			*/
			
			var str:String = ArrayFilterInsert[i].value.toString();
			//var pattern:RegExp = />/i; 
			//str.replace(pattern, "lessthan");
	//		str = str + "&amp;lt;";
			 //str = ArrayFilterInsert[i].value.toString();
			// pattern = /</gi; 
			//str.replace(pattern, "&amp;lt;");
			   str = str_replace(">","&gt;",str);
			   str = str_replace("<","&lt;",str);
				   		   
				   
				   
			string_detail = string_detail + '<data>' +
				'<action>' + (ArrayFilterInsert[i].action.toString()) + '</action>' +
				'<datafield>' + (ArrayFilterInsert[i].column.toString()) + '</datafield>' +
				'<datatype>' + (ArrayFilterInsert[i].type.toString()) + '</datatype>' +
				//'<value>' + (ArrayFilterInsert[i].value.toString()) + '</value>' +
				'<value>' + str + '</value>' +
				'<sequence>' + i.toString() + '</sequence>' +
				'</data>';
		}   
		
	//	
		
	
		
		var str_code:String = new String();
		if(!popcmmyviews){
			
			str_code = "No Selection";
		} else {
			str_code = popcmmyviews.inputcode.text;
		}
		//Alert.show(str_code);
		/*
		if(!popcmmyviews || !popcmmyviews.inUse)
		{
			Alert.show(popcmmyviews.inUse.toString()); 
		}
		 */
		/*
		if (popcmmyviews.inputcode.text == null){
			Alert.show("check 1.4:" + string_detail);
		}
		  */
		finalFilterXML = ('REFRESH,UPD_MV_FILTER,' + filter_head +
			'<usercode>' + myName_main + '</usercode>' +  
			//'<filtercode>' + popcmmyviews.inputcode.text + '</filtercode>' +
			'<filtercode>' + str_code + '</filtercode>' +
			'<xmlhdrcode>' + _xlcCode + '</xmlhdrcode>' +
			'<xmlhdrname>' + _xlcTitle + '</xmlhdrname>' +
			'<clientcode>' + '001' + '</clientcode>' +
			'<filtertype>' + 'P' + '</filtertype>' +
			string_detail +
			filter_tail);
		//Alert.show(finalFilterXML);
		reqParmsMyViewParameters = finalFilterXML;
		
		saveMyViewFilters.send();
	}

private function str_replace( replace_with:String, replace:String, original:String ):String
{
	var array:Array = original.split(replace_with);
	return array.join(replace);
}

    
	private function saveMyViewQuery(event:Event):void{
		
		
		
		if (history_reqParms_str == null){
			//Alert.show("This is a null, baby!");  
			PopUpManager.removePopUp(popcmmyviews);    
			//MyViewButtons.send();
			startMyViews(event);
		}              
		else{
			reqSJ = "";
			reqParmsMyViewParameters = "REFRESH,UPD_MV_QUERY," + myName_main + "," + mainBoard + ","+ popcmmyviews.inputcode.text + "," +  popcmmyviews.inputdescription.text + "," +  history_reqParms_str;
			
			saveMyViewQueryHTTP.send();
		}
		  
	}


private function saveCurSort_crunch(event:Event):void{
	
	if (pop404.newObject1.Array1.sort != null){
		
		//ArrayFilterInsert
		/*  Remove all Sort and replace with a new one*/
		
		for (var x:int =  pop404.newObject1.ArrayFilterInsert.length -1; x> -1; x--)  {
			if ( pop404.newObject1.ArrayFilterInsert[x]['action'] == 'sort'){
				
				pop404.newObject1.ArrayFilterInsert.removeItemAt(x);
			}
			
		}
		
		pop404.newObject1.ArrayFilterInsert.refresh();
		var tot_column_str:String = new String();
		var tot_value_str:String = new String();
		var value_str:String = new String();
		var tot_datatype_str:String = new String();
		var obj:Object = new Object();
		for (var i:int=0;i < pop404.newObject1.Array1.sort.fields.length; i++)  {
			tot_column_str = tot_column_str + ";" + pop404.newObject1.Array1.sort.fields[i].name.toString()
			
				
			// Save the last datatype per field //
				/*
			for (var x:int=0;x <pop404.newObject1._xlcColumn.length; x++){
				if (pop404.newObject1.Array1.sort.fields[i].name.toString() == pop404.newObject1._xlcColumn[x].dataField){
					//Alert.show(Array1.sort.fields[i].name.toString() + ":" + _xlcColumn[x].datatype);
					obj.type = pop404.newObject1._xlcColumn[x].datatype;
				}
			}
			*/
				
				
			if (pop404.newObject1.Array1.sort.fields[i].descending.toString() == "true"){
				value_str = "descending";
			} else {
				value_str = "ascending";   
			}
			tot_value_str = tot_value_str + ";" + value_str; 
			
			
			// Save datatype
			for (var x:int=0;x <pop404.newObject1._xlcColumn.length; x++){
				if (pop404.newObject1.Array1.sort.fields[i].name.toString() == pop404.newObject1._xlcColumn[x].dataField){
					//Alert.show(Array1.sort.fields[i].name.toString() + ":" + _xlcColumn[x].datatype);
					//type = _xlcColumn[x].datatype
					
					tot_datatype_str = tot_datatype_str + ";" +pop404.newObject1._xlcColumn[x].datatype.toString();
					break;
				}
			}
		}
		
		  /*
		var type:String = new String;
		for (var x:int=0;x < pop404.newObject1._xlcColumn.length; x++){
			if (pop404.newObject1.Array1.sort.fields[0].name.toString() == pop404.newObject1._xlcColumn[x].dataField){
				//Alert.show(Array1.sort.fields[i].name.toString() + ":" + _xlcColumn[x].datatype);
				type = pop404.newObject1._xlcColumn[x].datatype
				break;
			}
		}
		obj.type = type;
		*/
		
		
		tot_column_str = tot_column_str.substr(1, tot_column_str.length);
		tot_value_str = tot_value_str.substr(1, tot_value_str.length);
		tot_datatype_str = tot_datatype_str.substr(1, tot_datatype_str.length);
		obj.type = tot_datatype_str; 
		obj.value = tot_value_str;
		obj.column = tot_column_str; 
		obj.action =  "sort";	
		pop404.newObject1.ArrayFilterInsert.addItem(obj);
		
	} 	   
	
}


	private function pre_saveMyViewCrunch(event:Event):void{
		
		saveCurSort_crunch(event);
		saveMyViewCrunch(event);
		
		
	}

	private function saveMyViewCrunch(event:Event):void{
		
		
		//Alert.show(pop404.newObject1.ArrayFilterInsert.length.toString());
		//////////////////////////////////////
		
		var string_detail_crunch:String = new String;
		for(var i:int = 0; i <  (pop404.newObject1.ArrayFilterInsert.length); i++){
			
			
			
			var str:String = pop404.newObject1.ArrayFilterInsert[i].value.toString();
			str = str_replace(">","&gt;",str);
			str = str_replace("<","&lt;",str);
			
			
			
			string_detail_crunch = string_detail_crunch + '<filterdetail>' +
				'<action>' + (pop404.newObject1.ArrayFilterInsert[i].action.toString()) + '</action>' +
				'<datafield>' + (pop404.newObject1.ArrayFilterInsert[i].column.toString()) + '</datafield>' +
				'<datatype>' + (pop404.newObject1.ArrayFilterInsert[i].type.toString()) + '</datatype>' +
				//'<value>' + (ArrayFilterInsert[i].value.toString()) + '</value>' +
				'<value>' + str + '</value>' +
				'<sequence>' + i.toString() + '</sequence>' +
				
				
				'<filtercode>' + popcmmyviews.inputcode.text + '</filtercode>' +
				 
				'</filterdetail>';
		}   
		
		/*
		finalFilterXML = ('REFRESH,UPD_MV_FILTER,' + filter_head +
			'<usercode>' + myName_main + '</usercode>' +  
			'<filtercode>' + popcmmyviews.inputcode.text + '</filtercode>' +
			'<xmlhdrcode>' + _xlcCode + '</xmlhdrcode>' +
			'<xmlhdrname>' + _xlcTitle + '</xmlhdrname>' +
			'<clientcode>' + '001' + '</clientcode>' +
			'<filtertype>' + 'P' + '</filtertype>' +
			string_detail +
			filter_tail);
		
		reqParmsMyViewParameters = finalFilterXML;
		saveMyViewFilters.send();
		
		*/
		
		//Alert.show(string_detail_crunch);
		
		///////////////////////////////////////////////
		
		reqSJ = "";
		//reqParmsMyViewParameters = "REFRESH,UPDATE|MV_CRUNCH|" + myName_main + "|" + mainBoard + "|"+ popcmmyviews.inputcode.text +  "|grandtotal|";
		reqParmsMyViewParameters = "REFRESH,UPDATE|MV_CRUNCH|" + myName_main + "|" + mainBoard + "|"+ popcmmyviews.inputcode.text +  
			"|grandtotal|" + string_detail_crunch + "|";
		
		saveMyViewCrunchHTTP.send();  
		 
		
		//REFRESH, UPDATE,MV_CRUNCH|maves|actiongridcode| myview code| description|subtotalcolumn| 
	}

    
		private function pre_saveMyViewCrunchSubTotal(event:Event):void{
			saveCurSort_crunch(event);
			saveMyViewCrunchSubTotal(event);
		}
	private function saveMyViewCrunchSubTotal(event:Event):void{
		
		
		var string_detail_crunch:String = new String;
		for(var i:int = 0; i <  (pop404.newObject1.ArrayFilterInsert.length); i++){
			
			
			
			var str:String = pop404.newObject1.ArrayFilterInsert[i].value.toString();
			str = str_replace(">","&gt;",str);
			str = str_replace("<","&lt;",str);
			
			
			
			string_detail_crunch = string_detail_crunch + '<filterdetail>' +
				'<action>' + (pop404.newObject1.ArrayFilterInsert[i].action.toString()) + '</action>' +
				'<datafield>' + (pop404.newObject1.ArrayFilterInsert[i].column.toString()) + '</datafield>' +
				'<datatype>' + (pop404.newObject1.ArrayFilterInsert[i].type.toString()) + '</datatype>' +
				//'<value>' + (ArrayFilterInsert[i].value.toString()) + '</value>' +
				'<value>' + str + '</value>' +
				'<sequence>' + i.toString() + '</sequence>' +
				'</filterdetail>';
		}   
		
		
		
		reqSJ = "";
		//reqParmsMyViewParameters = "REFRESH,UPDATE|MV_CRUNCH|" + myName_main + "|" + mainBoard + "|"+ popcmmyviews.inputcode.text +  
		//	"|subtotal|" + subtotalselectedindex + "|" ;
		
		reqParmsMyViewParameters = "REFRESH,UPDATE|MV_CRUNCH|" + myName_main + "|" + mainBoard + "|"+ popcmmyviews.inputcode.text +  
				"|subtotal|" + subtotalselectedindex + "|" + string_detail_crunch + "|";
		
		//reqParmsMyViewParameters = "REFRESH,UPDATE|MV_CRUNCH|" + myName_main + "|" + mainBoard + "|"+ popcmmyviews.inputcode.text +  
		//	"|grandtotal|" + string_detail_crunch + "|";
		  
		
		
		saveMyViewCrunchSubHTTP.send();  
		 
		
		//REFRESH, UPDATE,MV_CRUNCH|maves|actiongridcode| myview code| description|subtotalcolumn|
	}

	private function saveMyViewChart(event:Event):void{
		reqSJ = "";
		reqParmsMyViewParameters = "REFRESH,UPDATE|MV_CHART|" + myName_main + "|" + mainBoard + "|"+ popcmmyviews.inputcode.text + "|" +  
			popshowChart_crunch.cb_forchart.selectedIndex + "|" + 
			popshowChart_crunch.chart_combo.selectedIndex +"|" +
		    popshowChart_crunch.number_of_row.text +"|";
		
		//reqParmsMyViewParameters = "REFRESH,UPDATE|MV_CRUNCH|" + myName_main + "|" + mainBoard + "|"+ popcmmyviews.inputcode.text +  "|grandtotal|";
		saveMyViewChartHTTP.send();  
		  
		
		//REFRESH, UPDATE,MV_CRUNCH|maves|actiongridcode| myview code| description|subtotalcolumn|
	}	