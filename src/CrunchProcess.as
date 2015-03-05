// ActionScript file
import mx.collections.ArrayCollection;

[Bindable]
public var SubTotalCrunchArray:ArrayCollection = new ArrayCollection;
[Bindable]
public var TotalSubTotalCrunchArray:ArrayCollection = new ArrayCollection;
[Bindable]
public var transientArray:ArrayCollection = new ArrayCollection;
[Bindable]
public var totaltransientArray:ArrayCollection = new ArrayCollection;
[Bindable]
public var FinalCrunchArray:ArrayCollection = new ArrayCollection; 
public var subtotalselectedindex:int = 0;

 	private function crunch_subtotal(event:Event):void {
 		SubTotalCrunchArray = new ArrayCollection;
 		TotalSubTotalCrunchArray = new ArrayCollection;
 		transientArray = new ArrayCollection;
 		totaltransientArray = new ArrayCollection;
 		//var transientArray:ArrayCollection = new ArrayCollection;
 		//Alert.show(pop9.cb_sort.selectedIndex.toString());
 		// check if user has chosen a subtotal
 		//if (pop9.cb_sort.selectedIndex == -1){
		if (pop9.cb_sort.selectedIndex == -1){
 			Alert.show("Please choose Sub Total Column");
 			return;
 		}
		subtotalselectedindex = pop9.cb_sort.selectedIndex;
		
 		/* 
 			var ca_fieldname:String = new String;
	 		var ca_datatype:String = new String;
	 		cs_SortByArray = new ArrayCollection;
	 		cs_CAArray = new ArrayCollection;
 		*/
 		// Check if there are sorted columns.  -- Mainly for validation.
 		if (Array1.sort == null){
	 			Alert.show("Please Select Column(s) to Sort");
	 			return;
	 	}
	 	
	 	//  There are sorted columns. --  passed validation.
	 	if (Array1.sort.toString() != null){  
	 		
	 					//  Get sorted fields and store in cs_SortByArray ArrayCollection. - no validation,
	 					// 	it is assumed that there will always be a sorted field(s).
	 						
	 						AddTo_cs_SortByArray(event);
	 						TotalAddTo_cs_SortByArray(event);
	 		  				
	 		  			//  Now time to get a Pass 1 to get total for Array 1
        	  			for (var ctr_pass1:int=0;ctr_pass1<Array1.length;ctr_pass1++)  { 
        	  					
        	  					var obj:Object = new Object();
        	  					var totalobj:Object = new Object();
        	  					
        	  					// set flag for validation.
        	  					var mainflag:Boolean = new Boolean;
        	  					var flag:Boolean = new Boolean;
        	  					// set flag for "total" validation.
        	  					var totalmainflag:Boolean = new Boolean;
        	  					var totalflag:Boolean = new Boolean;
        	  					
        	  					
        	  					mainflag =  true;
        	  					totalmainflag = true;
        	  					
        	  					// time to get the sorted fields from Array 1.
        	  					for (var floating_sortby:int=0;floating_sortby<cs_SortByArray.length;floating_sortby++){
        	  						
        	  						obj[cs_SortByArray[floating_sortby].cs_field] = Array1[ctr_pass1][cs_SortByArray[floating_sortby].cs_field];	
											
											
											// check for string and date only.  numeric is not allowed.  
											if (cs_SortByArray[floating_sortby].cs_datatype != "N"){
												//Alert.show(cs_SortByArray[floating_sortby].cs_datatype);
												
												
												 
												if (ctr_pass1 > 0){ 
														//Alert.show("transient: " + transientArray[0][cs_SortByArray[floating_sortby].cs_field]);
															if ((transientArray[0][cs_SortByArray[floating_sortby].cs_field]) ==  (Array1[ctr_pass1][cs_SortByArray[floating_sortby].cs_field])){
																	flag = true;	
															} else {
																	flag = false;
															}
															mainflag = (mainflag && flag);
															
												}
												
												//  This is going to get complicated.  Whoever shall inherit this application, please, forgive my logic.
												// compute for the total for each selected sub total column.
												//if (floating_sortby <= pop9.cb_sort.selectedIndex){
												if (floating_sortby <= pop9.cb_sort.selectedIndex){	
													totalobj[cs_SortByArray[floating_sortby].cs_field] =  Array1[ctr_pass1][cs_SortByArray[floating_sortby].cs_field];
														if (ctr_pass1 > 0){
															if ((totaltransientArray[0][cs_SortByArray[floating_sortby].cs_field]) ==  (Array1[ctr_pass1][cs_SortByArray[floating_sortby].cs_field])){
																	totalflag = true;	
															} else {
																	totalflag = false;
															}
															totalmainflag = (totalmainflag && totalflag);
														}
												}
											}
											
        	  								if (cs_SortByArray[floating_sortby].cs_datatype == "N"){
        	  									
        	  									if (ctr_pass1 > 0){ 
													if (mainflag == true){
        	  											 	transientArray[0][cs_SortByArray[floating_sortby].cs_field] = Number((transientArray[0][cs_SortByArray[floating_sortby].cs_field])) + Number(obj[cs_SortByArray[floating_sortby].cs_field]);
															transientArray[0][cs_SortByArray[floating_sortby].cs_field] = Math.round(transientArray[0][cs_SortByArray[floating_sortby].cs_field] * 100)/100 ;
													}
        	  									}
        	  									// now for the total numerics.
        	  									totalobj[cs_SortByArray[floating_sortby].cs_field] =  Array1[ctr_pass1][cs_SortByArray[floating_sortby].cs_field];
												totalobj[cs_SortByArray[floating_sortby].cs_field] = Math.round(totalobj[cs_SortByArray[floating_sortby].cs_field] * 100)/100 ;
        	  									if (ctr_pass1 > 0){
        	  										if (totalmainflag == true){
        	  												totaltransientArray[0][cs_SortByArray[floating_sortby].cs_field] = Number((totaltransientArray[0][cs_SortByArray[floating_sortby].cs_field])) + Number(obj[cs_SortByArray[floating_sortby].cs_field]);
															totaltransientArray[0][cs_SortByArray[floating_sortby].cs_field] = Math.round(totaltransientArray[0][cs_SortByArray[floating_sortby].cs_field] * 100)/100 ;
													}
        	  									} 
        	  								}	
        	  								
													
        	  		
        	  					} // end for (var floating_sortby:int=0;floating_sortby<cs_SortByArray.length;floating_sortby++)
        	  			
        	  			
        	  					
        	  			
        	  			
        	  			
        	  					
        	  					// check if transientArray does not have any records yet.
        	  					// if none then insert 1 record to generate the Array structure.
        	  					if (transientArray.length > 0) {
        	  							if (mainflag ==  true){
        	  								transientArray[0].instance = transientArray[0].instance + 1
        	  								
        	  								if (ctr_pass1 == (Array1.length - 1)){
        	  									AddToSubTotalCrunchArray();
        	  								}
        	  								
        	  							} 
        	  							if (mainflag == false){
        	  								
        	  								//if this is a new row, transfer the existing 1 record to the main arraycollection.
        	  								AddToSubTotalCrunchArray();
        	  								transientArray = new ArrayCollection;
        	  								obj.instance =  1; 	
        	  								transientArray.addItem(obj);
        	  								if (ctr_pass1 == (Array1.length - 1)){
        	  									AddToSubTotalCrunchArray();
        	  								}
        	  							}
        	  					
        	  					}
        	  					if (transientArray.length <= 0){
        	  						obj.instance = 1;  
        	  						transientArray.addItem(obj);
        	  						if (ctr_pass1 == (Array1.length - 1)){
        	  									AddToSubTotalCrunchArray();
        	  						}
        	  						
        	  					}
        	  					
        	  					// for Total Sum - put this is another arraycollection.
        	  					
        	  					if (totaltransientArray.length > 0) {
        	  							if (totalmainflag ==  true){
        	  								totaltransientArray[0].instance = totaltransientArray[0].instance + 1
        	  								
        	  								if (ctr_pass1 == (Array1.length - 1)){
        	  										TotalAddToSubTotalCrunchArray();
        	  								}
        	  								
        	  							} 
        	  							if (totalmainflag == false){
        	  								
        	  								//if this is a new row, transfer the existing 1 record to the main arraycollection.
        	  								TotalAddToSubTotalCrunchArray();
        	  								totaltransientArray = new ArrayCollection;
        	  								totalobj.instance =  1; 	
        	  								totaltransientArray.addItem(totalobj);
        	  								if (ctr_pass1 == (Array1.length - 1)){
        	  									TotalAddToSubTotalCrunchArray();
        	  								}
        	  							}
        	  						
        	  					}
        	  					
        	  					
        	  					if (totaltransientArray.length <= 0){
        	  						
        	  						totalobj.instance = 1;
        	  						totaltransientArray.addItem(totalobj); 
        	  						if (ctr_pass1 == (Array1.length - 1)){
        	  							TotalAddToSubTotalCrunchArray();
        	  							
        	  							//launchCrunchAnalysistest(event);
        	  						}
        	  						
        	  					}
        	  					
        	  			
        	  			
        	  			} // end for (var ctr_pass1:int=0;ctr_pass1<Array1.length;ctr_pass1++)
        	  			
        	  			// I LOVE ACTIONSCRIPT!!!!!!!!!!
        	  			// if everything works as expected, do this:
        	  				ComputePass2(event);
        	  			
        	  		
        	  			  
	 	}  // end if for (Array1.sort.toString() != null)
 		
 	} // crunch_subtotal
 	
 	
 	private function ComputePass2(event:Event):void {



		// I now have Sub Total and Total for Sub Total Array Collection.
		// Sub Total = SubTotalCrunchArray - Array Collection
		// Total for Sub Total = TotalSubTotalCrunchArray - Array Collection
		//  I may need to create a new ArrayCollection to hold the final result with the computer Percentages for instance and numeric values.
		//  I shall christened thee 'MainCrunchSubTotal' for the final ArrayCollection.
		// Grabe ang Objects nito!
		
		// Get row records for SubTotalCrunchArray.
		FinalCrunchArray = new ArrayCollection; 	
		for (var ctr_subtotal:int = 0; ctr_subtotal <  SubTotalCrunchArray.length; ctr_subtotal++){    // Get the Array of records
					var obj:Object = new Object;
					var str_updunique:String = new String;
					for (var ctr_scsb:int=0;ctr_scsb<cs_SortByArray.length;ctr_scsb++){    // Get the column name of the records
						obj[cs_SortByArray[ctr_scsb].cs_field] = SubTotalCrunchArray[ctr_subtotal][cs_SortByArray[ctr_scsb].cs_field];
						//Alert.show(SubTotalCrunchArray[ctr_subtotal][cs_SortByArray[ctr_scsb].cs_field]);
						str_updunique = str_updunique + SubTotalCrunchArray[ctr_subtotal][cs_SortByArray[ctr_scsb].cs_field];
					}
					//  This will compare the sub total columns to the total columns.
					//  You are now working on the Total rows Array.
					
					//  use "break;" to exit "for loop" if it satisfies the condition.
					
						obj.instance = SubTotalCrunchArray[ctr_subtotal].instance;
					for (var ctr_total:int = 0; ctr_total <  TotalSubTotalCrunchArray.length; ctr_total++){    // Get the Array of records
						var totobj:Object = new Object;
						var flag:Boolean = new Boolean;
						var mainflag:Boolean = new Boolean;
						mainflag = true;	
						for (var ctr_tscsb:int=0;ctr_tscsb<cs_TotalSortByArray.length;ctr_tscsb++){    // Get the column name of the records.    THERE SHOULD ALWAYS BE AN EQUAL ROW FOR TOTAL!
							//Alert.show("obj: " + obj[cs_TotalSortByArray[ctr_tscsb].cs_field] + " = " + TotalSubTotalCrunchArray[ctr_total][cs_TotalSortByArray[ctr_tscsb].cs_field]);
							//	Alert.show("check1: " + cs_TotalSortByArray[ctr_tscsb].cs_datatype);	
						
							if (cs_TotalSortByArray[ctr_tscsb].cs_datatype != 'N'){
							//	Alert.show("check2: " + cs_TotalSortByArray[ctr_tscsb].cs_datatype);
								if (TotalSubTotalCrunchArray[ctr_total][cs_TotalSortByArray[ctr_tscsb].cs_field] == obj[cs_TotalSortByArray[ctr_tscsb].cs_field]){
									flag = true;		
								} else {
									flag = false;
								}
							}
							
							mainflag = mainflag && flag;
							if (mainflag == true){  // if all is true.. means all are equal.
								if (cs_TotalSortByArray[ctr_tscsb].cs_datatype == 'N'){
									//Alert.show(obj[cs_TotalSortByArray[ctr_tscsb].cs_field] + " : " + TotalSubTotalCrunchArray[ctr_total][cs_TotalSortByArray[ctr_tscsb].cs_field]);
										if(obj[cs_TotalSortByArray[ctr_tscsb].cs_field] > 0){
											obj["pct_" + cs_TotalSortByArray[ctr_tscsb].cs_field] = (obj[cs_TotalSortByArray[ctr_tscsb].cs_field] /  TotalSubTotalCrunchArray[ctr_total][cs_TotalSortByArray[ctr_tscsb].cs_field]) * 100;							
											// Remove for now.
											obj["pct_" + cs_TotalSortByArray[ctr_tscsb].cs_field] = Math.round(obj["pct_" + cs_TotalSortByArray[ctr_tscsb].cs_field] * 100)/100 ;
										}
										if(obj[cs_TotalSortByArray[ctr_tscsb].cs_field] == 0){
												obj["pct_" + cs_TotalSortByArray[ctr_tscsb].cs_field] = 0;
										}
								}
								
							}  
						} 
						if (mainflag == true){
							// Remove for now.
							obj["pct_instance"] = (obj.instance / TotalSubTotalCrunchArray[ctr_total].instance) * 100;
							obj["pct_instance"] = Math.round(obj["pct_instance"] * 100)/100 ;
						}
					}
					// Time to put this on the Final Datagrid! Hope it work!	
					
					
					obj.upd_unique = str_updunique + ctr_subtotal.toString();
					FinalCrunchArray.addItem(obj);
		}			 	
		launchCrunchAnalysisSubTotal(event, 'Sub Total -  ' + pop9.cb_sort.selectedLabel);
	}
 	
 	
 	
 	private function launchCrunchAnalysisSubTotal(event:Event, str_title:String):void {
		  
            	removeMe_9(event);
               	pop404 = CrunchAnalysis(
                //var win:ActionCommand = PopUpManager.createPopUp(this, ActionCommand, true) as ActionCommand);
                PopUpManager.createPopUp(this, CrunchAnalysis, true));
                pop404.columnArray = cs_SortByArray;
                pop404.mainColumnArray = _xlcColumn;
                pop404.mfArray = FinalCrunchArray;
                pop404.headTitle = str_title;
                pop404.local_sesid = my_sid;
                pop404.local_companycode = my_c_code1; 
				pop404.local_crunch = "Sub Total";
				
				pop404.local_fdp = fdp_crunch;   
				    
				/*  Retrieve Chart */ 
				
				if   (myview_flag == 1){
				ntchart = new Timer(TIMER_INTERVAL_CHART);
				ntchart.addEventListener(TimerEvent.TIMER, nt_updatechartsub); 
				ntchart.start();
				}
				 
				pop404["btn_showChart"].addEventListener( MouseEvent.CLICK,showChartSubTotal);
				pop404["btn_showChart"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop404["btn_showChart"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
		
				pop404["btn_saveCrunch"].addEventListener( MouseEvent.CLICK,saveCrunchSubtotal);
				pop404["btn_saveCrunch"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop404["btn_saveCrunch"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);  
				pop404["btn_cancel_mc"].addEventListener( MouseEvent.CLICK,update_mylevel);   
				pop404["btn_cancel_mc"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop404["btn_cancel_mc"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents); 
				
				pop404["btn_cancel_mc_back"].addEventListener( MouseEvent.CLICK,update_mylevel);     
				pop404["btn_cancel_mc_back"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				pop404["btn_cancel_mc_back"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				
            
    }
//private const TIMER_INTERVAL_CHART:int = 5000;  
//private var ntchart:Timer;   

private function nt_updatechartsub(evt:TimerEvent):void {
	
	ntchart.stop();
	checkMVChart_SubTotal(evt); 
}


private function checkMVChart_SubTotal(event:Event):void{
	reqSJ = "";
	//reqParmsMyViewParameters = "REFRESH,UPD_MV_QUERY," + myName_main + "," + mainBoard + ","+ popcmmyviews.inputcode.text + "," +  popcmmyviews.inputdescription.text + "," +  history_reqParms_str;
	reqParmsmvquery = "REFRESH,RETRIEVE|MV_CHART|" + myName_main + "|" + mainBoard + "|"+_xlcRenditionCode+ "|";
	
	retrievemvchart_subtotal.send();
	
	
}   
    
     		//public var popshowChartSubTotal:ShowChart; 
    		private function showChartSubTotal(event:Event):void {
				   
				/*
				
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
				*/
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
				
				popshowChart_crunch["btn_savechart"].addEventListener(MouseEvent.CLICK,saveChart_Grandtotal);
				popshowChart_crunch["btn_close"].addEventListener(MouseEvent.CLICK,closeChart);
				popshowChart_crunch["btn_close"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				popshowChart_crunch["btn_close"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				popshowChart_crunch["btn_close_back"].addEventListener(MouseEvent.CLICK,closeChart);
				popshowChart_crunch["btn_close_back"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				popshowChart_crunch["btn_close_back"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
				
				
			}
    
 
				private function showChartSubTotal_parameter(event:Event, select:int, type:int, maxnum:int):void{    
					
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
					popshowChart_crunch["btn_close"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
					popshowChart_crunch["btn_close"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
					popshowChart_crunch["btn_close_back"].addEventListener(MouseEvent.CLICK,closeChart);     
					popshowChart_crunch["btn_close_back"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
					popshowChart_crunch["btn_close_back"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
					
				}
    
 	private function TotalAddToSubTotalCrunchArray():void{ 
 		/* Testing purposes - shoud be deleted on production.
 		for (var x:int = 0; x < cs_TotalSortByArray.length; x++){
 			Alert.show(cs_TotalSortByArray[x].cs_field);
 		}
 		*/
 			for (var i:int=0;i < totaltransientArray.length; i++)  {
 				var totalobj:Object = new Object();
 				for (var floating_sortby:int=0;floating_sortby<cs_TotalSortByArray.length;floating_sortby++){
 					totalobj[cs_TotalSortByArray[floating_sortby].cs_field] = totaltransientArray[i][cs_TotalSortByArray[floating_sortby].cs_field]
 					
 				}
 				totalobj.instance = totaltransientArray[0].instance; 
 				TotalSubTotalCrunchArray.addItem(totalobj);
 			}
 	
 			
 	} 	
 	private function AddToSubTotalCrunchArray():void{
 		
 			for (var i:int=0;i < transientArray.length; i++)  {
 				var obj:Object = new Object();
 				for (var floating_sortby:int=0;floating_sortby<cs_SortByArray.length;floating_sortby++){
 					obj[cs_SortByArray[floating_sortby].cs_field] = transientArray[i][cs_SortByArray[floating_sortby].cs_field]
 					
 				}
 				obj.instance = transientArray[0].instance;
 				SubTotalCrunchArray.addItem(obj);
 			}
 	
 	
 	}
 	
 	private function AddTo_cs_SortByArray(event:Event):void {
 		
 		
 					var ca_fieldname:String = new String;
	 				var ca_datatype:String = new String;
	 					cs_SortByArray = new ArrayCollection;
	 					cs_CAArray = new ArrayCollection;
 					var tot_column_str:String = new String();
           			var tot_value_str:String = new String();
           			var value_str:String = new String();
           			
           			
           				//  Get sorted fields and store in cs_SortByArray ArrayCollection.
        	  			for (var i:int=0;i < Array1.sort.fields.length; i++)  {
        	  				var obj:Object = new Object();
        	  				ca_fieldname = new String;
	 						ca_datatype = new String;
        	  				ca_fieldname = Array1.sort.fields[i].name.toString();
        	  				
        	  								// Get the datatype for the sorted fields.  S(String) or N(Numeric) or D(Date)
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
										
        	  			} // end for (var i:int=0;i < Array1.sort.fields.length; i++)
        	  			
 	}
 	
 	private function TotalAddTo_cs_SortByArray(event:Event):void {
 		
 		
 					var ca_fieldname:String = new String;
	 				var ca_datatype:String = new String;
	 					cs_TotalSortByArray = new ArrayCollection;
	 					cs_CAArray = new ArrayCollection;
 					var tot_column_str:String = new String();
           			var tot_value_str:String = new String();
           			var value_str:String = new String();
           			
           		//	Alert.show(pop9.cb_sort.selectedIndex.toString());
           				//  Get sorted fields and store in cs_SortByArray ArrayCollection.
        	  			for (var i:int=0;i < Array1.sort.fields.length; i++)  {
        	  				var totalobj:Object = new Object();
        	  				ca_fieldname = new String;
	 						ca_datatype = new String;
        	  				ca_fieldname = Array1.sort.fields[i].name.toString();
        	  				
        	  								// Get the datatype for the sorted fields.  S(String) or N(Numeric) or D(Date)
        	  								for (var c:int=0;c<_xlcColumn.length;c++)  { 
			 									var datafield:String = (_xlcColumn[c]["dataField"]).toString();
			 									var datatype:String = (_xlcColumn[c]["datatype"]).toString();
												if (ca_fieldname == datafield){
												  ca_datatype = (_xlcColumn[c]["datatype"]).toString();
												}
											}
        	  				
        	  				totalobj.cs_field = ca_fieldname; 
							totalobj.cs_datatype = ca_datatype;
							
							if (((i <= pop9.cb_sort.selectedIndex) && (ca_datatype != 'N')) || ((i > pop9.cb_sort.selectedIndex) && (ca_datatype == 'N'))){
								//Alert.show("i: " + i + " sel: " + pop9.cb_sort.selectedIndex.toString() + " datatype: " + ca_datatype);	
								//Alert.show(totalobj.cs_field.toString()); 
								
									cs_TotalSortByArray.addItem(totalobj);
							}		
										
        	  			} // end for (var i:int=0;i < Array1.sort.fields.length; i++)
        	  			
        	  		
        	  		//	Alert.show("onew: " + cs_TotalSortByArray[0].cs_field + " : " + cs_TotalSortByArray[0].cs_datatype);
 	}