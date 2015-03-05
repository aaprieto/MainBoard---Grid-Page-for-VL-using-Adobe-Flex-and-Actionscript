// ActionScript file
import flash.events.Event;

import mx.collections.ArrayCollection;

	  private function addFunction(evt:Event):void{
	   	var ctr:int = 0;
	   	
	   			Array3 = new ArrayCollection();
 			 	Array4 = new ArrayCollection();
 			 
 					for( var i:int = 0; i < tdObjectCollection.length; i++ ){
						var ia:String = i.toString();	
						var obj:Object = new Object();	

						for (var ix:int=0;ix< _xlcColumn.length; ix++)  { 
							var datafield:String = (_xlcColumn[ix]["dataField"]).toString();
								obj[datafield] = tdObjectCollection[i][datafield];
						}
					Array3.addItem(obj);
					Array4.addItem(obj);
					}
	   			
	  // 	Alert.show(ArrayFilterInsert.length.toString());
	   			 for( var i2:int = 0; i2 < ArrayFilterInsert.length; i2++ ){
						custom_datafield = (ArrayFilterInsert[i2]["column"]);
						custom_text = (ArrayFilterInsert[i2]["value"]);
						custom_datatype = (ArrayFilterInsert[i2]["type"]);
						action_command = (ArrayFilterInsert[i2]["action"]);
						if ((action_command != "clear") &&(action_command != "add")&&(action_command != "sort")&&(action_command != "panel")) {
						
							if (custom_datatype == "S"){
								string_filter_for_add(evt);
							}
							if (custom_datatype == "N"){
								number_filter_for_add(evt);
							}
							if (custom_datatype == "D"){
								date_filter_for_add(evt);
							}
	   			 		}
	   			 		
				//		if (i2 + 1 == ArrayFilterInsert.length){
				//			custom_datafield = (ArrayFilterInsert[i2]["column"]);
				//			custom_text = (ArrayFilterInsert[i2]["value"]);
				//			custom_datatype = (ArrayFilterInsert[i2]["type"]);
				//			action_command = (ArrayFilterInsert[i2]["action"]);
							if (action_command == "add") {
								if (custom_datatype == "S"){
									string_filter_for_add(evt); 
								}
								if (custom_datatype == "N"){
									number_filter_for_add(evt);
								}
								if (custom_datatype == "D"){
									date_filter_for_add(evt);
								}
	   			 			}
	   			 	//		Alert.show("Inside: " + action_command);
					//	}
						
	   			 }
	   			
	   			dg.dataProvider = Array1;
  	  }  	
