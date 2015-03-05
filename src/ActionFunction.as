// ActionScript file
import flash.events.Event;

import mx.collections.ArrayCollection;
import mx.collections.SortField;

	  private function ActionEvent(evt:Event):void{
	  
	   	var ctr:int = 0;
	 	var arrlen:int =  ArrayFilterInsert.length;
	   			 for( var i2:int = 0; i2 < ArrayFilterInsert.length; i2++ ){
	   		   		if ((i2 + 1) == ArrayFilterInsert.length){
	   			 		sort_mini_flag = true;
						custom_datafield = (ArrayFilterInsert[i2]["column"]);
						custom_text = (ArrayFilterInsert[i2]["value"]);
						custom_datatype = (ArrayFilterInsert[i2]["type"]);
						action_command = (ArrayFilterInsert[i2]["action"]);
			
						if (action_command == "clear"){
							    Array1 = new ArrayCollection();
            					Array2 = new ArrayCollection();
            					Array1.refresh();
            					Array2.refresh();
        				} else if (action_command == "sort"){
							 sort_mini_flag = false;
								
								sort_custom_datafield = custom_datafield; 
	   							sort_custom_text = custom_text;
	   							sort_custom_datatype = custom_datatype;
	   							sort_action_command = action_command;
								
								/*		
						} else if (action_command == "keep_number"){
							
							
							
							keepNoOfRows_ac(evt, int(custom_text));
								
								 */
						} else if (action_command == "panel"){
							
							 for (var iacg:int=0; iacg< ArrayColumnGroup.length; iacg++) {
                    				if(custom_datafield ==  ArrayColumnGroup[iacg].headerText) {
                    					//cb_column_group.selectedIndex = iacg;
                        				dg.horizontalScrollPosition = parseInt(custom_text);
                        				break;
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
	   			 	sort_flag = sort_flag && sort_mini_flag;
	   			 
	   			 }
	   				
	   			dg.dataProvider = Array1;
  	  }  	



	private function keepNoOfRows_ac(event:Event, max_numberofrow:int):void{
		//Alert.show(Array1.length.toString());
		//myDG.selectedIndex = 5;
		/*
		for( var x:int = 10; x < Array1.length; x++ ){
			Array1.removeItemAt(x);
		}
		*/
		
		
		var ArrNumOfRows:Array = new Array;
		
		for (var ctr:int=0;ctr<max_numberofrow;ctr++){
		ArrNumOfRows[ctr] = ctr;
		}
		
		dg.selectedIndices = ArrNumOfRows;
		
		
		
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
		
		
		//choose_numberofrows(event);
	//	aFormFields[0]['text'] = final_dg_key;
	//	aFormFields[0]['data_field'] = _xlcColumn[_xlcColumn.length -2]["dataField"];
	//	aFormFields[0]['data_type'] = "S";
		
		
		custom_datafield = _xlcColumn[_xlcColumn.length -2]["dataField"];
		custom_text = final_dg_key;
		//custom_datatype = (ArrayFilterInsert[i2]["type"]);
		//action_command = (ArrayFilterInsert[i2]["action"]);
		
		string_filter(event);
	}


	private function ActionEventfromMain(event:Event):void{
			   	Array1 = new ArrayCollection();
 			 	Array2 = new ArrayCollection();
				
				
				Array1 = tdObjectCollection;
				Array2 = tdObjectCollection;
				
				/*
 					for( var i:int = 0; i < tdObjectCollection.length; i++ ){
						var ia:String = i.toString();	
						var obj:Object = new Object();	
						for (var ix:int=0;ix< _xlcColumn.length; ix++)  { 
							var datafield:String = (_xlcColumn[ix]["dataField"]).toString();
								obj[datafield] = tdObjectCollection[i][datafield];
						}
					Array1.addItem(obj);
					Array2.addItem(obj);
					}
				*/
	}
	
	
	public function SortFunction(event:Event):void{
		
		var index_location:int = dg.horizontalScrollPosition;
		//Alert.show("armpo;");        
			var sortA:Sort = new Sort();
			var arr_segment_cd:Array = [];
			var arr_segment_ct:Array = [];
			var arr_segment_cdt:Array = [];
			var str_segment_len:int;
			var asc_desc:Boolean = new Boolean;
			var num_string_datatype:Boolean = new Boolean;
			var sort_arr:ArrayCollection = new ArrayCollection();
			var fields:Array = new Array();
			var arr_o:Object = new Object();
			
			arr_segment_cd = custom_datafield.split(";");
			arr_segment_ct = custom_text.split(";");	
			arr_segment_cdt = custom_datatype.split(";");
				str_segment_len = arr_segment_cd.length;
		//	Alert.show(arr_segment_cd.length.toString()); 
				
				
			if 	(str_segment_len > 1){		
				//Alert.show("one");
					for (var ia:int=0; ia<str_segment_len;ia++){
						if (arr_segment_ct[ia] == "descending"){
							asc_desc = true;
						} else if (arr_segment_ct[ia] == "ascending"){
							asc_desc = false;
						}   
						//fields.push(new SortField(arr_segment_cd[ia],false,asc_desc));
						
						
						if (arr_segment_cdt[ia] == "N"){
							fields.push(new SortField(arr_segment_cd[ia],true,asc_desc,true));
							
						}else {
							fields.push(new SortField(arr_segment_cd[ia],true,asc_desc));
							
						}
						
						/*
						if (custom_datatype == "N"){
						
						
						fields.push(new SortField(arr_segment_cd[ia],true,asc_desc,true));
						}else {
							fields.push(new SortField(arr_segment_cd[ia],true,asc_desc));
							
						}
						*/
						//Alert.show(arr_segment_cd[ia]);
						//fields.push(new SortField(arr_segment_cd[ia],true,asc_desc,true));
					}	
			} else if (str_segment_len < 2){     
				//Alert.show("two");
				for (var ia:int=0; ia<str_segment_len;ia++){
					if (arr_segment_ct[ia] == "descending"){
						asc_desc = true;
					} else if (arr_segment_ct[ia] == "ascending"){
						asc_desc = false;
					}
					//fields.push(new SortField(arr_segment_cd[ia],false,asc_desc));
					//fields.push(new SortField(arr_segment_cd[ia],true,asc_desc));
					//Alert.show(arr_segment_cd[ia]);
					//fields.push(new SortField(arr_segment_cd[ia],true,asc_desc));
					
					if (arr_segment_cdt[ia] == "N"){
						fields.push(new SortField(arr_segment_cd[ia],true,asc_desc,true));
						
					}else {
						fields.push(new SortField(arr_segment_cd[ia],true,asc_desc));
						
					}
					/*
					if (custom_datatype == "N"){
						
						
						fields.push(new SortField(arr_segment_cd[ia],true,asc_desc,true));
					}else {
						fields.push(new SortField(arr_segment_cd[ia],true,asc_desc));
					 	
					} 
					*/
				}	
			}		
			sortA.fields = fields;
			Array1.sort = sortA;
			Array1.refresh();
			/*
			var sort:Sort = new Sort();
			sort.fields = [new SortField("status", true, true), new SortField("help_id", true, true)];
			myHelp.sort = sort;
			myHelp.refresh();
			*/
			
           				dg.horizontalScrollPosition = index_location;
           				correctWidth(event);

	}
	