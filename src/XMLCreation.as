// ActionScript file
import flash.events.Event;
import flash.events.MouseEvent;
import flash.ui.Keyboard;

import mx.collections.*;

 [Bindable]
			public var XMLRepVal:ArrayCollection = new ArrayCollection;

public var my_xml:XML = new XML; 


	



		public function flashFilter(event :Event):void
				{ 					// Create main head and tail nodes.
					var root_head:String = "<root>";
					var root_tail:String = "</root>";
					 xml_str = "";
					var obj:Object = new Object();
					XMLRepVal = new ArrayCollection;
					var col0:String = "";
					var col1:String = "";
					var col2:String = "";
					/*
					// Parent Node
					var parent_start:String = "<parent label= '";
					var parent_field:String = "' field= '";
					var parent_type:String = "' type= '";
					var parent_end:String = "'>";
					var parent_tail:String = "</parent>";
					
					// Child Node
					var child_start:String = "<child label= '";
					var child_field:String = "' field= '";
					var child_type:String = "' type= '";
					var child_end:String = "'/>";
					*/
					// Parent Node
					var parent_start:String = '<parent label= "';
					var parent_field:String = '" field= "';
					var parent_type:String = '" type= "';
					var parent_end:String = '">';
					var parent_tail:String = '</parent>';
					
					// Child Node
					var child_start:String = '<child label= "';
					var child_field:String = '" field= "';
					var child_type:String = '" type= "';
					//var child_end:String = '"/>';
					var child_end:String = '">';
					var child_tail:String = '</child>';
					
					
					// Grand Child Node
					
					var grand_child_start:String = '<grand_child label= "';
					var grand_child_field:String = '" field= "';
					var grand_child_type:String = '" type= "';
					var grand_child_end:String = '"/>';
					
					// validation for no sort
					if (Array1.sort == null){
	 						AlertMessageShow("Pls. Select Column(s) to Sort");
	 						return;
	 				}
					
					//  For now, we'll go to only 2 column fields to sort
					if (Array1.sort.fields.length > 3){
						AlertMessageShow("You can only have a maximum of 3 fields for Flash Filter");
						return;
					}	
					
					// Get the order for sorted column to maintain hierarchy.
					var obj_isa:Object = new Object;
					for (var isa:int=0;isa < Array1.sort.fields.length; isa++)  {
						obj_isa = new Object;
						obj_isa =  Array1.sort.fields[isa].name;
						XMLRepVal.addItem(obj_isa);
						//  Let it stay here for now.
					}
					
			 
				
					var temp_col0:String = "";
					//var temp_col1:String = "";
					var arr_name:String = new String;
					var str_flashxml_type:String = new String;
					var str_flag:Boolean = new Boolean;
					for (var ia1:int = 0; ia1 < Array1.length; ia1++){ 
						str_flag = true;
						for (var i:int=0;i < Array1.sort.fields.length; i++)  {
							
								 // we have to assign this to a variable so as not to update Array1 result.
								 arr_name = Array1[ia1][Array1.sort.fields[i].name];
								//Alert.show(arr_name);
								//Alert.show(Array1.sort.fields[i].name); 
								
								for (var ix:int=0;ix<_xlcColumn.length;ix++)  { 
									
									if (Array1.sort.fields[i].name == (_xlcColumn[ix]["dataField"]).toString()){
										str_flashxml_type = (_xlcColumn[ix]["datatype"]).toString();
									}
								
								}
								
								 if ((Array1[ia1][Array1.sort.fields[i].name] == null)||(Array1[ia1][Array1.sort.fields[i].name] == "")) {
								 	//Array1[ia1][Array1.sort.fields[i].name] = "";
								 	arr_name = "-";
								 }
								if (i == 0){ 
									
								 
									//temp_col0 = Array1[ia1][Array1.sort.fields[i].name].toString();
									temp_col0 = arr_name;
									if (temp_col0 != col0){
										if (xml_str != ""){
											xml_str = xml_str + parent_tail;
										}
										
										xml_str = xml_str + parent_start + temp_col0 + parent_field + Array1.sort.fields[i].name.toString() + parent_type + str_flashxml_type + parent_end;
											
										col0 = temp_col0;
										col1 = "";
										
									}
								 	
								}
								if (i == 1){
								 	
									//var temp_col1:String = Array1[ia1][Array1.sort.fields[i].name].toString();
									var temp_col1:String = arr_name;
									if (temp_col1 != col1){
											str_flag = false;
										xml_str = xml_str + child_start + temp_col1 + child_field + Array1.sort.fields[i].name + child_type + str_flashxml_type + child_end;
											if (Array1.sort.fields.length == 2){
													xml_str = xml_str + child_tail;
											}
										col1 = temp_col1;
										col2 = "";
									}
								  	
								}
								if (i == 2){
								 	
									//var temp_col1:String = Array1[ia1][Array1.sort.fields[i].name].toString();
									var temp_col2:String = arr_name;
									if (temp_col2 == col2){
										if ((ia1 +1) == Array1.length){
											xml_str = xml_str + child_tail;
										}
										if ((ia1+1) < Array1.length){
											if ((Array1[ia1+1][Array1.sort.fields[i-1].name] != col1)||(Array1[ia1+1][Array1.sort.fields[i-2].name] != col0)){
												xml_str = xml_str + child_tail;
											}
									
										/*
											if (Array1[ia1+1][Array1.sort.fields[i-1].name] != col1){
												xml_str = xml_str + child_tail;
											}
										*/	
										}
									}
									if (temp_col2 != col2){
										   
										xml_str = xml_str + grand_child_start + temp_col2 + grand_child_field + Array1.sort.fields[i].name + grand_child_type + str_flashxml_type + grand_child_end;
										col2 = temp_col2;
										// work on this arnold.
									//	Alert.show(Array1[ia1+1][Array1.sort.fields[i-1].name]);
										//Alert.show(col1);
										
										if ((ia1 +1) == Array1.length){
											xml_str = xml_str + child_tail;
										}
										if ((ia1+1) < Array1.length){
											if ((Array1[ia1+1][Array1.sort.fields[i-1].name] != col1)||(Array1[ia1+1][Array1.sort.fields[i-2].name] != col0)){
												xml_str = xml_str + child_tail;
											}
									
										/*
											if (Array1[ia1+1][Array1.sort.fields[i-1].name] != col1){
												xml_str = xml_str + child_tail;
											}
										*/	
										}
										
										
									}
									
									
									
									
									
								  	
								}
								
						}
						
					
				
					}	
					
					
				/*	
					if (Array1.sort.fields.length == 1){
						xml_str = xml_str + parent_tail;
					}
				*/
					
						
					xml_str = xml_str + parent_tail;
					
					xml_str = root_head + xml_str + root_tail;
					//Alert.show(xml_str);	
					removeMe_9(event);
					launchFlashTree(event); 
				} 
				
				

			public var popft:FlashTree;	     
            private function launchFlashTree(event:Event):void {
               	popft = FlashTree(
                PopUpManager.createPopUp(this, FlashTree, false));
                 //dispatchEvent(new Event("FlashTree", true)));
                popft.xml_string = xml_str;
                popft["btn_exp"].addEventListener(KeyboardEvent.KEY_DOWN, key_exp); 
   		       	popft["btn_exp"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				popft["btn_exp"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
   		       	popft["btn_col"].addEventListener(KeyboardEvent.KEY_DOWN, key_exp);
   		        popft["btn_col"].addEventListener( MouseEvent.ROLL_OVER,passMouseHoverfromComponents);
				popft["btn_col"].addEventListener( MouseEvent.ROLL_OUT,closepassMouseHoverfromComponents);
   		       	popft["xmllisttree"].addEventListener(KeyboardEvent.KEY_DOWN, key_exp); 
   		       	popft["xmllisttree"].addEventListener(MouseEvent.CLICK, filterOneClick);  
   		        popft["btn_submit"].addEventListener(KeyboardEvent.KEY_DOWN,enterFlashSubmit);
   		       	popft["btn_cancel"].addEventListener(KeyboardEvent.KEY_DOWN, enterFlashCancel); 
   		     }
   		     
   		     
   		     	private function filterOneClick(event:Event):void{
   		     		var obj:Object = new Object;
   		     		var dg_hsp:int = 0;
   		  			
   		  			//for (var i:int=0;i < Array1.sort.fields.length; i++){}
   		  			
   		  			// Alert.show(dg.horizontalScrollPosition.toString());
   		  			 dg_hsp = dg.horizontalScrollPosition;
   		  			
					 /*  Remove the first two clear and add first */
					 
					 
					 
					 //Alert.show(ArrayFilterInsert.length.toString());
					 if (ArrayFilterInsert.length > 1){
						if (ArrayFilterInsert[ArrayFilterInsert.length - 1]['action'] == "add"){
							if (ArrayFilterInsert[ArrayFilterInsert.length - 2]['action'] == "clear"){
								ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1);
								ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1);
							}
						}
	    					
						
						
						
						 /*
						 for (var x:int = ArrayFilterInsert.length - 1 ; x>=-1; x--){
								if (ArrayFilterInsert[x]['action'] == "add"){
									ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1);
									ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 2);
								}
						 }  
						 */
					 }
					 
					 
					 
					 /*
					 for (var ib:int = 0; ib<popft.xmllisttree.selectedItems.length; ib++){
					 	ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1);
					 }
					 	ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1);
					 */
    		  			 
   		  			
   		  			 if 	(popft.xmllisttree.selectedItems.length > 0){
   		  			 	
   		  						// Clear first in preparation for the Add Action Command
   		  						
   		  						obj = new Object;
   		     					obj.column = "";
								obj.value = ""
								obj.type = ""
								obj.action = "clear";
								ArrayFilterInsert.addItem(obj);
							
							 	Array1 = new ArrayCollection();
            					Array2 = new ArrayCollection();
            					Array1.refresh();
            					Array2.refresh();
   		  						
   		  						for (var ia:int = 0; ia<popft.xmllisttree.selectedItems.length; ia++){
   		  								obj = new Object;
   		     							obj.column 	= popft.xmllisttree.selectedItems[ia].@field;
										obj.value 	= popft.xmllisttree.selectedItems[ia].@label;
										obj.type 	= popft.xmllisttree.selectedItems[ia].@type;
										obj.action 	= "add";
										ArrayFilterInsert.addItem(obj);
									
										addFunction(event);
										
										//refreshButton(event)
							//	ArraySwap_for_add_final(event);
						
					/*
							if (popft.xmllisttree.selectedItems[ia].@type == "S"){
								string_filter_for_add(event);
							}
							if (popft.xmllisttree.selectedItems[ia].@type == "N"){
								number_filter_for_add(event);
							}
							if (popft.xmllisttree.selectedItems[ia].@type == "D"){
								date_filter_for_add(event);
							}
							
										*/
										
										
										
										
										
										
										
										
										
										
										
								}
								
								
				///////////////////////////  REMOVE THIS FOR NOW //////////////////////////////////////////			
								/*
   		  			 	for (var ib:int = 0; ib<popft.xmllisttree.selectedItems.length; ib++){
   		  					 			ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1);
   		  			 	}
   		  			 			ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1);
								*/
				///////////////////////////////////////////////////////////////////////////////////////////////				
   		  			 }
   		  			 
   		  			 //Alert.show(dg.horizontalScrollPosition.toString());
   		  			 // to retain the column number of the selected row in Flash Filter.
   		  			 dg.horizontalScrollPosition = dg_hsp;
					 //PopUpManager.removePopUp(popft);  //  <-- Add this.
   		  			 correctWidth(event);
   		  			 
   		     	}
   		     	private function filterOneClick_reserve_latest(event:Event):void{
   		     		
   		     	  if 	(popft.xmllisttree.selectedItems.length > 0){
   		     		//launchErgo();
   		     		flash_interrupt = true;
   		     		var XMLRepVal_row1:String = "";
   		     		var XMLRepVal_row1_type:String = "";
   		     		var XMLRepVal_row2:String = "";
   		     		var XMLRepVal_row2_type:String = "";
   		     		var obj:Object = new Object;
// - remove this for now.   		     		if (XMLRepVal.length == 2 ){
   		     			for (var i:int = 0; i< XMLRepVal.length; i++){
   		     				for (var ia:int = 0; ia<popft.xmllisttree.selectedItems.length; ia++){
								if (XMLRepVal[i] == popft.xmllisttree.selectedItems[ia].@field){
									if (i == 0){
										if (XMLRepVal_row1 == ""){
											XMLRepVal_row1 = popft.xmllisttree.selectedItems[ia].@label;
										} else {
											XMLRepVal_row1 = XMLRepVal_row1 + ";" + popft.xmllisttree.selectedItems[ia].@label;
										}
										XMLRepVal_row1_type = popft.xmllisttree.selectedItems[ia].@type;
									}
									if (i == 1){
										if (XMLRepVal_row2 == ""){
											XMLRepVal_row2 = popft.xmllisttree.selectedItems[ia].@label;
										} else {
											XMLRepVal_row2 = XMLRepVal_row2 + ";" + popft.xmllisttree.selectedItems[ia].@label;
										}
										XMLRepVal_row2_type = popft.xmllisttree.selectedItems[ia].@type;
									}
								}   
							}
   		     			}
   		     			
   		     			
   		     			if (XMLRepVal.length == 1){
   		     				obj = new Object;
   		     				obj.column = "";
							obj.value = ""
							obj.type = ""
							obj.action = "clear";
							ArrayFilterInsert.addItem(obj);
							
							 Array1 = new ArrayCollection();
            					Array2 = new ArrayCollection();
            					Array1.refresh();
            					Array2.refresh();
							
							
							//refreshButton(event);
   		     			
   		     			//if (XMLRepVal.length == 1){
  						
   		     				obj = new Object;
   		     				obj.column = XMLRepVal[0];
							obj.value = XMLRepVal_row1;
							obj.type = XMLRepVal_row1_type;
							obj.action = "add";
							ArrayFilterInsert.addItem(obj);
							addFunction(event);
							//ArraySwap_for_add_final(event);
							//refreshButton(event);
   		     			//}
  								ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1);
								ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1);
   		     			}
   		     			
  						if (XMLRepVal.length == 2){
  							obj = new Object;
   		     				obj.column = "";
							obj.value = ""
							obj.type = ""
							obj.action = "clear";
							ArrayFilterInsert.addItem(obj);
							 Array1 = new ArrayCollection();
            					Array2 = new ArrayCollection();
            					Array1.refresh();
            					Array2.refresh();
							
							
  							if (XMLRepVal_row1 != ""){
  								obj = new Object;
   		     					obj.column = XMLRepVal[0];
								obj.value = XMLRepVal_row1;
								obj.type = XMLRepVal_row1_type;
								obj.action = "add";
								ArrayFilterInsert.addItem(obj);
								addFunction(event);
								//ArraySwap_for_add_final(event);
							
   		    				}
   		    				if (XMLRepVal_row2 != ""){
  								obj = new Object;
  								obj.column = XMLRepVal[1];
								obj.value = XMLRepVal_row2;
								obj.type = XMLRepVal_row2_type
								obj.action = "add";
								ArrayFilterInsert.addItem(obj);
								addFunction(event);
								//ArraySwap_for_add_final(event);
   		    				}
   		    				//addFunction(event)
  							//refreshButton(event);
  							ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1);
							ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1);
							ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1);
  						}	     			
   		     			
   		     			
   		     			
   		     			//refreshButton(event);
   		     			
   		     			
//   		     		}
   		     		
   		     		
   		     //		Alert.show("row1: " + XMLRepVal_row1);
   		     //		Alert.show("row 2: " + XMLRepVal_row2);
   		     		
   		     		/*
   		     		for (var i:int = 0; i<= popft.xmllisttree.selectedItems.length; i++){
   		     			Alert.show(popft.xmllisttree.selectedItems[i].@label.toString() + " : " + popft.xmllisttree.selectedItems[i].@type.toString() + " : " + popft.xmllisttree.selectedItems[i].@field.toString());
   		     		}
   		     		*/
   		     		
   		     		//Alert.show(XMLRepVal[0].toString());
   		     		//Alert.show(XMLRepVal[1].toString());
   		     	  }	
   		     	}
   		     	
   		     
				
				private function filterOneClick_reserve(event:Event):void{
					//	Alert.show(popft.xmllisttree.selectedItem.@label.toString() + " : " + popft.xmllisttree.selectedItem.@type.toString() + " : " + popft.xmllisttree.selectedItem.@field.toString());
					/*
					action_command = "keep";
					custom_datafield = popft.xmllisttree.selectedItem.@field.toString();
					custom_text = popft.xmllisttree.selectedItem.@label.toString();
					custom_datatype = popft.xmllisttree.selectedItem.@type.toString();
					
					custom_datafield = (ArrayFilterInsert[i2]["column"]);
						custom_text = (ArrayFilterInsert[i2]["value"]);
						custom_datatype = (ArrayFilterInsert[i2]["type"]); 
						action_command = (ArrayFilterInsert[i2]["action"]);
						*/
						var obj:Object = new Object;
						// toggle flash_interrupt for flash function
						flash_interrupt = true;
						
						obj.column = popft.xmllisttree.selectedItem.@field;
						obj.value = popft.xmllisttree.selectedItem.@label;
						obj.type = popft.xmllisttree.selectedItem.@type;
						obj.action = "keep";
						ArrayFilterInsert.addItem(obj);
					refreshButton(event);
					//FilterHistoryLog(event);
				//	Alert.show(ArrayFilterInsert.length.toString());
				 
				//	ArrayFilterInsert.removeItemAt((ArrayFilterInsert.length) - 1); 
				}
				
				private function key_exp(event :KeyboardEvent):void
				{
					//Alert.show(event.toString());
					// 4o key up
					// 38 key down
					if ((event.keyCode == 38)||(event.keyCode == 40)||(event.keyCode == Keyboard.ENTER))
					{
						//Alert.show(event.keyCode.toString());
						filterOneClick(event);
						//Alert.show(popft.xmllisttree.selectedItem.@type.toString());
					}
						
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_ft(event);
					}
					
					
				}	
				private function enterFlashSubmit(event :KeyboardEvent):void
				{
					if (event.keyCode == Keyboard.ENTER)
					{
						flashFilter(event);
						
					}
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_ft(event);
					}
					
					
				}
				private function enterFlashCancel(event :KeyboardEvent):void
				{
					
					if (event.keyCode == Keyboard.ESCAPE)
					{
						removeMe_ft(event);
					}
					if  (event.keyCode == Keyboard.ENTER)
					{
						removeMe_ft(event);
					}
					
					
					
				}	
				/*
				
				public function OpSecSendXML(event:Event):void{
					
					var xml_str:String = new String;
						//Alert.show(xml_str);
					// This is specifically for Operator Security Profile only.
					//  will modify in case there are some more additional generic use to it.
					//  dd_columnone is a variable from dg.
					xml_str = xml_str + "<operator>" + dd_columnone + "</operator>";
						
					
					var root_head:String = "<" + mainBoard + ">";
					var root_tail:String = "</" + mainBoard + ">";
					
					var data_head:String = "<data>";
					var data_tail:String = "</data>";
					
					xml_str = xml_str + root_head;
				
						for (var i:int=0;i<Array1.length;i++){
         			
         						if 	(Array1[i][_xlcColumn[0]["dataField"]] == 'Y'){
         							
         								xml_str = xml_str + data_head;
         								//Alert.show(Array1[i][_xlcColumn[0]["dataField"]]);
         								for (var j:int=0;j<((_xlcColumn.length) - 1);j++){
         									xml_str = xml_str + "<" + _xlcColumn[j]["dataField"] + ">";
         									xml_str = xml_str + Array1[i][_xlcColumn[j]["dataField"]];
         									xml_str = xml_str + "</" + _xlcColumn[j]["dataField"] + ">";
         								}
         								
         								xml_str = xml_str + data_tail;
         								
         						}		
      					}
      				xml_str = xml_str + root_tail;
      				
      				//Alert.show(xml_str);
      					
         		}
				
				*/
				
					