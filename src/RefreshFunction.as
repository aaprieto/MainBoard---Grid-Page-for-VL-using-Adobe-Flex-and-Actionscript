// ActionScript file
import flash.events.Event;
import mx.collections.ArrayCollection;

	private function joinRetRecToArrayZero(evt:Event):void{
		/*  Changing the 1st column unique key to last column unique.  */
		for( var i:int = 0; i < tdObjectCollectionRefresh.length; i++ ){
			var obj:Object = new Object();
			var flag:String = (tdObjectCollectionRefresh[i]["flag"]).toString();
			if (flag == "D"){
				var column_unique:String = tdObjectCollectionRefresh[i][_xlcColumn[_xlcColumn.length - 2]["dataField"]].toString();
				for( var ia:int = 0; ia < tdObjectCollection.length; ia++ ){
					if (tdObjectCollection[ia][_xlcColumn[_xlcColumn.length - 2]["dataField"]] == column_unique){
						tdObjectCollection.removeItemAt(ia);
					}
				}
			}
			if (flag != "D"){
				var loc_flag:Boolean = true;  
				var column_unique2:String = tdObjectCollectionRefresh[i][_xlcColumn[_xlcColumn.length - 2]["dataField"]].toString();
				for( ia = 0; ia < tdObjectCollection.length; ia++ ){
					if (tdObjectCollection[ia][_xlcColumn[_xlcColumn.length - 2]["dataField"]] == column_unique2){
						tdObjectCollection.removeItemAt(ia);
						for ( ix=0;ix< _xlcColumn.length; ix++)  { 
							datafield = (_xlcColumn[ix]["dataField"]).toString();
							obj[datafield] = tdObjectCollectionRefresh[i][datafield];
						}
						tdObjectCollection.addItemAt(obj,ia);
						loc_flag = false;	
					}
				}
				if (loc_flag == true){
					for (var ix:int=0;ix< _xlcColumn.length; ix++)  { 
						var datafield:String = (_xlcColumn[ix]["dataField"]).toString();
						obj[datafield] = tdObjectCollectionRefresh[i][datafield];
					}
					tdObjectCollection.addItem(obj);
				}
			}
		}
		/*
		for( var i:int = 0; i < tdObjectCollectionRefresh.length; i++ ){
				var obj:Object = new Object();
				var flag:String = (tdObjectCollectionRefresh[i]["flag"]).toString();
				if (flag == "D"){
					var column_unique:String = tdObjectCollectionRefresh[i][_xlcColumn[0]["dataField"]].toString();
						for( var ia:int = 0; ia < tdObjectCollection.length; ia++ ){
							if (tdObjectCollection[ia][_xlcColumn[0]["dataField"]] == column_unique){
								tdObjectCollection.removeItemAt(ia);
							}
						}
				}
				if (flag != "D"){
					var loc_flag:Boolean = true;  
					var column_unique2:String = tdObjectCollectionRefresh[i][_xlcColumn[0]["dataField"]].toString();
						for( ia = 0; ia < tdObjectCollection.length; ia++ ){
							if (tdObjectCollection[ia][_xlcColumn[0]["dataField"]] == column_unique2){
								tdObjectCollection.removeItemAt(ia);
									for ( ix=0;ix< _xlcColumn.length; ix++)  { 
											datafield = (_xlcColumn[ix]["dataField"]).toString();
											obj[datafield] = tdObjectCollectionRefresh[i][datafield];
									}
								tdObjectCollection.addItemAt(obj,ia);
								loc_flag = false;	
							}
						}
						if (loc_flag == true){
									for (var ix:int=0;ix< _xlcColumn.length; ix++)  { 
											var datafield:String = (_xlcColumn[ix]["dataField"]).toString();
											obj[datafield] = tdObjectCollectionRefresh[i][datafield];
									}
								tdObjectCollection.addItem(obj);
						}
				}
		}
		*/
		// restart timer to generate new sets of counter.
		startTimer();
	}



	  public function refreshButton(evt:Event):void{
		 /*
		  Alert.show("go here 1");
		  saveCurSort_button(evt);  
		  Alert.show("go here 2");
		  */
	   	var ctr:int = 0;
	   	//var index_location:int = dg.horizontalScrollPosition - dg.lockedColumnCount;
	   	var index_location:int = dg.horizontalScrollPosition;
	   	var littleflag:Boolean = false;
	   			Array1 = new ArrayCollection();
 			 	Array2 = new ArrayCollection();
 			 	
		//	Array1 = tdObjectCollection;
		//	Array2 = tdObjectCollection;
				//Alert.show(tdObjectCollection.length.toString() + ":" + _xlcColumn.length.toString());
					for( var i:int = 0; i < tdObjectCollection.length; i++ ){
						//var ia:String = i.toString();	
						var obj:Object = new Object();	

						for (var ix:int=0;ix< (_xlcColumn.length); ix++)  { 
							var datafield:String = (_xlcColumn[ix]["dataField"]).toString();
								obj[datafield] = tdObjectCollection[i][datafield];
						}
					Array1.addItem(obj);         
					Array2.addItem(obj);   
					}
			//Alert.show("Check 2: " + tdObjectCollection.length.toString() + ":" + Array1.length.toString() + ":" + Array2.length.toString() );
				
				Array1.refresh();
            			Array2.refresh();   
            	//Alert.show(Array1.length.toString());
				
					for( var i2:int = 0; i2 < ArrayFilterInsert.length; i2++ ){
						
						custom_datafield = (ArrayFilterInsert[i2]["column"]);
						custom_text = (ArrayFilterInsert[i2]["value"]);
						custom_datatype = (ArrayFilterInsert[i2]["type"]); 
						action_command = (ArrayFilterInsert[i2]["action"]);
						
						if (action_command == "clear"){ 
							    Array1 = new ArrayCollection();
            					Array2 = new ArrayCollection();
            					Array1.refresh(); 
            					Array2.refresh();
            					//cb_column_group.selectedIndex = 0;
								
									
								
            			}else if (action_command == "add") {
						addFunction(evt); 
					 			
							ArraySwap_for_add_final(evt);
					
							if (custom_datatype == "S"){
								string_filter_for_add(evt);
							}
							if (custom_datatype == "N"){
								number_filter_for_add(evt);
							}
							if (custom_datatype == "D"){
								date_filter_for_add(evt);
							}
							
							
						} else if (action_command == "sort"){  
							
								SortFunction(evt);  	
						
						} else if (action_command == "keep_number"){  
							
							//Alert.show("go here");
							keepNoOfRows_ac(evt, int(custom_text));
						
						}else if (action_command == "panel"){
						/*	
							 for (var iacg:int=0; iacg< ArrayColumnGroup.length; iacg++) {
                    				if(custom_datafield ==  ArrayColumnGroup[iacg].headerText) {
                    					//cb_column_group.selectedIndex = iacg;
										index_location = parseInt(custom_text);
                        				//dg.horizontalScrollPosition = parseInt(custom_text);
                        				//correctWidth(evt);
	           							//flagger(evt);
                        				//return;
                        				break;
                    				}
                 				}
						*/
							for (var iacg:int=0; iacg< aPanel.length; iacg++) {
								if(custom_datafield ==  aPanel[iacg].label) {
									/*  This takes care of the Panels  */
									aPanel[iacg]["selected"] = true;
									aPanel[iacg].setStyle("color","blue"); 
									aPanel[iacg].setStyle("borderColor", "blue");
									index_location = parseInt(custom_text);
									//dg.horizontalScrollPosition = parseInt(custom_text);
									//correctWidth(evt);
									//flagger(evt);
									//return;
									//break;
								} else {
									aPanel[iacg]["selected"] = false;
									aPanel[iacg].setStyle("color","black"); 
									aPanel[iacg].setStyle("borderColor",""); 
								}
							}
							
                					correctWidth(evt);			
						}else{
									
							if (custom_datatype == "S"){
								string_filter(evt);
							}
							if (custom_datatype == "N"){
								number_filter(evt);
							}
							if (custom_datatype == "D"){
								date_filter(evt);
							}
	   			 		}
					
	   			 }
				 //Alert.show("here");  Alert.show("refresh!");
				        
				     
				
				 
	   			CheckSortAH(evt);     
//	   			dg.dataProvider = Array1;
	   			dg.verticalScrollPosition = dg_vsb;
	   			correctWidth(evt);
	           	dg.horizontalScrollPosition = index_location; 
				flagger(evt);
				
				if (flash_interrupt == true){   
					flash_interrupt = false;
				}
							startTimer();
						//	Alert.show("refresh again");    
	   			 			return;
							        
			//ca_sort(evt);  
							
							
							
  	  }  	
  	  
  	  public function erase(evt:Event):void{
				//var index_location:int = dg.horizontalScrollPosition;
  	  			  	  		dg.horizontalScrollPosition = 0;
  	  			  	  		//cb_column_group.selectedIndex = 0;
  	  			  	  		Array1.sort = null;
  	  			  	  	
  	  		ArrayFilterInsert = new ArrayCollection();
  	  		ArrayFilterInsert.refresh();
  	  		//cb_filter_macro_persistent.selectedIndex = -1;
  	  		//cb_filter_macro.selectedIndex = -1;
			lbl_persistent_view.text = "No selection";
			lbl_transient_view.text = "No selection";
			initializePanel();
			filterDescription_persistent = "";
			filterDescription_transient = "";
			
			refreshButton(evt);
			correctWidth(evt);
			removeMe_2(evt);
  	  }

  	  
  	 