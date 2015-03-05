// ActionScript file
	private var ct:String = new String;
	private var cd:String = new String;
	private var value:String = new String;
	private var str_action:String = new String;
	
	
	/* String Filter Handler for all action help	*/
	public function string_filter(event:Event):void {
		
			 	var index_location:int = dg.horizontalScrollPosition;
					cd = custom_datafield.toString();
            		ct = custom_text.toString();
					str_action = action_command.toString();
			
					// A String Filter can also have the ability to Filter like the Number Filter.
					if ((ct.substr(0,1) == ">")||(ct.substr(0,1) == "<")||(ct.substr(0,1) == "=")){
						Array1.filterFunction = NumberObjectCollectionFilterFunc;
					}else {
						Array1.filterFunction = StringObjectCollectionFilterFunc;
					}
						Array1.refresh();
						ArraySwap(event);
						dg.horizontalScrollPosition = index_location;
						
						//correctWidth(event);
						
						
	}
		
	public function string_filter_for_add(event:Event):void {
			 	var index_location:int = dg.horizontalScrollPosition;
					cd = custom_datafield.toString();
            		ct = custom_text.toString();
					str_action = action_command.toString();
					
 
           		if ((str_action == "keep")||(str_action == "discard")){
           			// A String Filter can also have the ability to Filter like the Number Filter.
           			if ((ct.substr(0,1) == ">")||(ct.substr(0,1) == "<")||(ct.substr(0,1) == "=")){
						Array3.filterFunction = NumberObjectCollectionFilterFunc;
					}else {
           				Array3.filterFunction = StringObjectCollectionFilterFunc;
     				}
           			Array3.refresh();
           				ArraySwap_for_add(event);
           			
           				dg.horizontalScrollPosition = index_location;
           				correctWidth(event);
           		}
 				if (str_action == "add"){
 					
           			str_action = "keep";
           			// A String Filter can also have the ability to Filter like the Number Filter.
           			if ((ct.substr(0,1) == ">")||(ct.substr(0,1) == "<")||(ct.substr(0,1) == "=")){
						Array3.filterFunction = NumberObjectCollectionFilterFunc;
					}else {
           				Array3.filterFunction = StringObjectCollectionFilterFunc;
     				}
           			Array3.refresh();
           			str_action = "add";
           				ArraySwap_for_add_final(event);
           				dg.horizontalScrollPosition = index_location;
           				correctWidth(event);
           		}
	}

	public function StringObjectCollectionFilterFunc(item:Object):Boolean {
         	var str_entry:String;
         	
         	var str_entry_length:int;
         	var str_entry_start_wildcard:String;
         	var str_entry_end_wildcard:String;
         	var str_entry_wo_wildcard:String;
         	
			var str_segment_array:Array = [];
			var flag:Boolean;
			var str_len:int;
			flag = false;
			if (str_action == "discard"){ 
			flag = true;
			}			
			var currentsflag:Boolean = false;
			if (str_action == "discard"){
			currentsflag = true;
			}			
				str_segment_array = ct.split(";");	
				str_len = str_segment_array.length;
				var posn:int;
			for (var i:int=0; i<str_len;i++){
				str_entry = str_segment_array[i].toString();
			/* Removing trim as per walter */
			//	str_entry = c_utils.trim(str_entry);
				
				str_entry.toString();
			
				//  Removed Uppercase for testing purposes.
				//	str_entry = str_entry.toUpperCase();
				///////////////////////////////////////////
					
						var str_value:String = new String;
						str_value = item[cd];
						
						/*  Checks for Wildcard = *5*  */
						
						if ((str_value != "")&&(str_value != null)){
								str_entry_length = str_entry.length;
								if ((str_entry.substr(0,1) == "*") && (str_entry.substr(str_entry_length - 1,1) == "*")){
										
										 str_entry = str_entry.substr(1,str_entry_length - 2);
										
										
											//  Removed Uppercase for testing purposes.
											//posn =(((str_value).toString()).toUpperCase()).search( str_entry );
											/////////////////////////////////////////////////////////////////////
											posn =((str_value).toString()).search( str_entry );
											/////////////////////////////////////////////////
											
												if (posn > -1){
														if (str_action == "keep"){
																flag = true;
																	} else{
																flag = false;
														}
														if (str_action == "discard"){
																flag = false;
																	} else{
																flag = true;
														}
												}
														if (str_action == "keep"){
																currentsflag = (currentsflag || flag);
														}
														if (str_action == "discard"){
																currentsflag = (currentsflag && flag);
														}
								}
								else
								if ((str_entry.substr(0,1) == "*") && (str_entry.substr(str_entry_length - 1,1) != "*")){
									str_entry = str_entry.substr(1,str_entry_length);
									var str_val_length:int = str_value.length;
									var temp_str_value:String = str_value;
									temp_str_value = temp_str_value.substr(temp_str_value.length - str_entry.length, temp_str_value.length);
										
												//if (str_entry.toUpperCase() == temp_str_value.toUpperCase()){
												if (str_entry == temp_str_value){	
														if (str_action == "keep"){
																flag = true;
																	} else{
																flag = false;
														}
														if (str_action == "discard"){
																flag = false;
																	} else{
																flag = true;
														}
												}
														if (str_action == "keep"){
																currentsflag = (currentsflag || flag);
														}
														if (str_action == "discard"){
																currentsflag = (currentsflag && flag);
														}
								}
								
								else 
								if((str_entry.substr(0,1) != "*") && (str_entry.substr(str_entry_length - 1,1) == "*")){
										str_entry = str_entry.substr(0,str_entry_length -1);
									 /* Scan single cell and factor it by ";" a loop within a loop */
									var str_len_cell:int;
									var str_value_3:String;
									var str_segment_array_cell:Array = [];
										str_segment_array_cell = str_value.split(";");	
										str_len_cell = str_segment_array_cell.length;
										
										for (var ia:int=0; ia<str_len_cell;ia++){
													str_value_3 = str_segment_array_cell[ia].toString();
													/* Removing trim as per walter */
													//str_value_3 = c_utils.trim(str_value_3);
									
										
												//  Removed Uppercase for testing purposes.
												//	posn =(((str_value_3).toString()).toUpperCase()).indexOf( str_entry );
												//////////////////////////////////////////////////////////////////////////
												 posn =((str_value_3).toString()).indexOf( str_entry );
												//////////////////////////////////////////////////////////////////////////
												if (posn == 0){
														if (str_action == "keep"){
																flag = true;
																	} else{
																flag = false;
														}
														if (str_action == "discard"){
																flag = false; 
																	} else{
																flag = true;
														} 
												}
												
												
												
												
												
														if (str_action == "keep"){
																currentsflag = (currentsflag || flag);
														}
														if (str_action == "discard"){
																currentsflag = (currentsflag && flag);
														}
										 }
										
										
										
								}
								else 
								if((str_entry.substr(0,1) != "*") && (str_entry.substr(str_entry_length - 1,1) != "*")){
										
										//  Removed Uppercase for testing purposes.
										//	posn =(((str_value).toString()).toUpperCase()).indexOf( str_entry );
										///////////////////////////////////////////////////////////////////////
										 posn =((str_value).toString()).indexOf( str_entry );
										///////////////////////////////////////////////////////////////////////
												if (posn == 0){
														if (str_action == "keep"){
																flag = true;
																	} else{
																flag = false;
														}
														if (str_action == "discard"){
																flag = false; 
																	} else{
																flag = true;
														}
												}
												
												
												
														if (str_action == "keep"){
																currentsflag = (currentsflag || flag);
														}
														if (str_action == "discard"){
																currentsflag = (currentsflag && flag);
														}
										//flag = NumberObjectCollectionFilterFunc(item); 
								}
								
						}
						//flag = NumberObjectCollectionFilterFunc(item); 
						flag = manager_datagrid_handler.CompareWildcard(str_entry, str_value, flag, str_action);
						currentsflag = (currentsflag || flag);
			}	
			    //Alert.show(currentsflag);
			    if (currentsflag == true)
	             	return	true; 	
	            else 
	             	return false; 
	}
	

	private function ArraySwap(evt:Event):void{
			 Array2 = new ArrayCollection();
 					for( var i:int = 0; i < Array1.length; i++ ){
						var obj:Object = new Object();	
						for (var ix:int=0;ix< _xlcColumn.length; ix++)  { 
							var datafield:String = (_xlcColumn[ix]["dataField"]).toString();
								obj[datafield] = Array1[i][datafield];
						}
					Array2.addItem(obj);
					}
 			 Array1 = new ArrayCollection();
 					for( var i2:int = 0; i2 < Array2.length; i2++ ){
						var obj2:Object = new Object();	
						for (var ix2:int=0;ix2< _xlcColumn.length; ix2++)  { 
							var datafield2:String = (_xlcColumn[ix2]["dataField"]).toString();
								obj2[datafield2] = Array2[i2][datafield2];
						}
					Array1.addItem(obj2);
					}
 		}
	
		private function ArraySwap_for_add(evt:Event):void{
			 Array4 = new ArrayCollection();
 					for( var i:int = 0; i < Array3.length; i++ ){
						var obj:Object = new Object();	
						for (var ix:int=0;ix< _xlcColumn.length; ix++)  { 
							var datafield:String = (_xlcColumn[ix]["dataField"]).toString();
								obj[datafield] = Array3[i][datafield];
						}
					Array4.addItem(obj);
					}
 			 		Array3 = new ArrayCollection();
 					for( var i2:int = 0; i2 < Array4.length; i2++ ){
						var obj2:Object = new Object();	
						for (var ix2:int=0;ix2< _xlcColumn.length; ix2++)  { 
							var datafield2:String = (_xlcColumn[ix2]["dataField"]).toString();
								obj2[datafield2] = Array4[i2][datafield2];
						}
					Array3.addItem(obj2);
					}
 		}

		private function ArraySwap_for_add_final(evt:Event):void{
			var flag:Boolean = true;
			var currentsflag:Boolean = true;
			Array5 = new ArrayCollection();
 					for( var i:int = 0; i < Array3.length; i++ ){
						var obj:Object = new Object();
						for (var ix:int=0;ix< _xlcColumn.length; ix++)  { 
							var datafield:String = (_xlcColumn[ix]["dataField"]).toString();
							if (ix == 0){		
							 	for (var ia:int = 0; ia < Array1.length; ia++){
									if(Array3[i][datafield] == Array1[ia][datafield]){
										flag = false;
									}			 	
								
							 		currentsflag = (currentsflag && flag);
							 	}
							}
							if (currentsflag == true){
								obj[datafield] = Array3[i][datafield];
							}
						}
							if (currentsflag == true){
								Array5.addItem(obj);
							}	
					}
					for( var i5:int = 0; i5 < Array5.length; i5++ ){
						var obj5:Object = new Object();	
						for (var ix5:int=0;ix5< _xlcColumn.length; ix5++)  { 
							var datafield5:String = (_xlcColumn[ix5]["dataField"]).toString();
								obj5[datafield5] = Array5[i5][datafield5];
						}
					Array1.addItem(obj5);
					Array1.refresh();
					}
					ArraySwap(evt);
					//Alert.show(Array1.length.toString());
 		}	
 		
