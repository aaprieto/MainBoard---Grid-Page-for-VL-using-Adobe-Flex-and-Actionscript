// ActionScript file for Date Filter 

		public function number_filter(event:Event):void {
			var index_location:int = dg.horizontalScrollPosition;
		
					cd = custom_datafield.toString();
            		ct = custom_text.toString();
            		str_action = action_command.toString();
            	//tdObjectCollection.filterFunction = NumberObjectCollectionFilterFunc;
           		//tdObjectCollection.refresh();
           		
           		Array1.filterFunction = NumberObjectCollectionFilterFunc;
           		Array1.refresh();
           	//	Alert.show(Array1.length.toString());
           		ArraySwap(event);
           		Array1.refresh();
           		dg.horizontalScrollPosition = index_location;
           		//dg.dataProvider = Array1;
           		//Remove this for one click functionality
				//correctWidth(event);
           		
		}
		
		public function number_filter_for_add(event:Event):void {


			 	var index_location:int = dg.horizontalScrollPosition;
					cd = custom_datafield.toString();
            		ct = custom_text.toString();
					str_action = action_command.toString();
					
			
           		if ((str_action == "keep")||(str_action == "discard")){
           			Array3.filterFunction = NumberObjectCollectionFilterFunc;
           			Array3.refresh();
           				ArraySwap_for_add(event);
           			//	Array2.refresh();
           		
 
           				dg.horizontalScrollPosition = index_location;
           				correctWidth(event);
           		}
 				
 					if (str_action == "add"){
           			//Alert.show(str_action);
           			str_action = "keep";
           			Array3.filterFunction = NumberObjectCollectionFilterFunc;
           			Array3.refresh();
           			str_action = "add";
           				ArraySwap_for_add_final(event);
           			//	Array2.refresh();
           		
 
           				dg.horizontalScrollPosition = index_location;
           				correctWidth(event);
           		}
 
           		
	}

		
		////////////////////////////////////////////////////////  Number Filter ///////////////////////////////////////////////////////////
		
		public function NumberObjectCollectionFilterFunc(item:Object):Boolean {
			
			var number_apptresult:Array = [];
			var number_apptflag:Boolean;
			var currentsflag:Boolean;
			var flag:Boolean = false;
			currentsflag = false;
			if (str_action == "discard"){
			flag = true;
			}			
			if (str_action == "discard"){
			currentsflag = true;
			}			
			number_apptresult = ct.split("+");	
			var	number_apptlen:int = number_apptresult.length;
			var str_value:String = new String;
				str_value = item[cd];
							
			if (number_apptlen == 1){
					var ins_number_appt:String = number_apptresult[0].toString();
					var number_appt_operator:Boolean = false
 						ins_number_appt = c_utils.trim(ins_number_appt);
 				
 					// Greater Than
					var deliv_number_operator:Boolean = (ins_number_appt.indexOf('>') >= 0);
					 if (deliv_number_operator = true){
					 	var posn:Number = ins_number_appt.indexOf('>');
					 	var excerpt_str:String = ins_number_appt.substr(posn, 1);
					 	var phraselen:Number = ins_number_appt.length;
					 	var excerpt_str2:String = ins_number_appt.substr(1, phraselen);
					 	excerpt_str2 = c_utils.trim(excerpt_str2);
					 		if (excerpt_str == ">"){   //  Greater Than
								if (Number(str_value) > Number(excerpt_str2)){
									//flag = true;
								//} else{
									//flag = false;
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
					 		}
					 }
 					 // Less Than
					number_appt_operator = false;
					number_appt_operator = (ins_number_appt.indexOf('<') >= 0);
					if (number_appt_operator = true){
					 	posn = ins_number_appt.indexOf('<');
					 	excerpt_str = ins_number_appt.substr(posn, 1);
					 	phraselen = ins_number_appt.length;
					 	excerpt_str2 = ins_number_appt.substr(1, phraselen);
					 	excerpt_str2 = c_utils.trim(excerpt_str2);
					 		if (excerpt_str == "<"){   // Less Than
								if (Number(str_value) < Number(excerpt_str2)){
									//flag = true;
								//} else{
									//flag = false;
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
					 		}
					}

					// Greater Than , Equal To
					number_appt_operator = false;
					var number_appt_operator_again:Boolean;
					number_appt_operator_again = (ins_number_appt.indexOf('=>') >= 0);
					if (number_appt_operator_again = true){
							ins_number_appt = ins_number_appt.split("=>").join(">=");
					}
					number_appt_operator = (ins_number_appt.indexOf('>=') >= 0);
					if (number_appt_operator = true){
					 	posn = ins_number_appt.indexOf('>=');
					 	excerpt_str = ins_number_appt.substr(posn, 2);
					 	phraselen = ins_number_appt.length;
					 	excerpt_str2 = ins_number_appt.substr(2, phraselen);
					 	excerpt_str2 = c_utils.trim(excerpt_str2);
					 	
					 		if (excerpt_str == ">="){  // Greater Than, Equal To
								if (Number(str_value) >= Number(excerpt_str2)){
										//flag = true;
								//} else{
									//flag = false;
									
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
					 		}
					}


					// Less Than , Equal To
					number_appt_operator = false;
					//var deliv_appt_operator_again:Boolean;
					number_appt_operator_again = (ins_number_appt.indexOf('=<') >= 0);
					if (number_appt_operator_again = true){
							ins_number_appt = ins_number_appt.split("=<").join("<=");
					}
					number_appt_operator = (ins_number_appt.indexOf('<=') >= 0);
					if (number_appt_operator = true){
					 	posn = ins_number_appt.indexOf('<=');
					 	excerpt_str = ins_number_appt.substr(posn, 2);
					 	phraselen = ins_number_appt.length;
					 	excerpt_str2 = ins_number_appt.substr(2, phraselen);
					 	excerpt_str2 = c_utils.trim(excerpt_str2);
					
					 		if (excerpt_str == "<="){  //  Less Than, Equal To
					 			flag = false;
					 				if (Number(str_value) <= Number(excerpt_str2)){
										//flag = true;
									//} else{
										//flag = false;
										
										
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
					 		}
						
					}
					// Equal To
					number_appt_operator = false;
					var sec_len:Number;
					var str_second_len:String = ins_number_appt.substr(0,1)
					var sec_string:String;
					if ((str_second_len != ">")&&(str_second_len != "<")){
					 	excerpt_str = ins_number_appt.substr(0, 1);
					 		if (excerpt_str == "="){
					 				sec_len = ins_number_appt.length;
					 				sec_string = ins_number_appt.substr(1,sec_len);
					 				sec_string = c_utils.trim(sec_string);
					 		
					 				if (Number(str_value) == Number(sec_string)){
										//flag = true;
									//} else{
										//flag = false;
										
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
					 		} else{
					 	
					 				if (Number(str_value) == Number(ins_number_appt)){
									//	flag = true;
									//} else{
									//	flag = false;
									
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
					 		}
					}
			}
			
			if (number_apptlen == 2){
					ins_number_appt = number_apptresult[0].toString();
					var ins_number_appt2:String = number_apptresult[1].toString();
					var number_appt_operator1:Boolean = false
					var number_appt_operator2:Boolean = false
					//var excerpt_str2:String;
					var excerpt_str3:String;
						// Greater than and Less than
						number_appt_operator1 = (ins_number_appt.indexOf('>') >= 0);
					 if (number_appt_operator1 == true){
					 	ins_number_appt = c_utils.trim(ins_number_appt);
					 	posn = ins_number_appt.indexOf('>');
					 	excerpt_str = ins_number_appt.substr(posn, 1);
					 	phraselen = ins_number_appt.length;
					 	excerpt_str2= ins_number_appt.substr(1, phraselen);
					 	excerpt_str2 = c_utils.trim(excerpt_str2);
			
					 }	
					 number_appt_operator2 = (ins_number_appt2.indexOf('<') >= 0);
					 if (number_appt_operator2 == true){
					 	ins_number_appt2 = c_utils.trim(ins_number_appt2);
					 	posn = ins_number_appt2.indexOf('<');
					 	excerpt_str = ins_number_appt2.substr(posn, 1);
					 	phraselen = ins_number_appt2.length;
					 	excerpt_str3= ins_number_appt2.substr(1, phraselen);
					 	excerpt_str3 = c_utils.trim(excerpt_str3);
			
					 }
				if ((number_appt_operator1 == true) && (number_appt_operator2 == true))						
					{
									if ((Number(str_value) > Number(excerpt_str2))&&(Number(str_value) < Number(excerpt_str3))){
										//flag = true;
									//} else{
										//flag = false;
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
					}						
				number_appt_operator1 = false;
				number_appt_operator2 = false;
					 
				////////////////////////////////////////////////////////			
					//var deliv_appt_operator_again:Boolean;
					number_appt_operator_again = (ins_number_appt.indexOf('=>') >= 0);
					if (number_appt_operator_again = true){
							ins_number_appt = ins_number_appt.split("=>").join(">=");
					}
					// Greater Than equal To and Less Than Equal To
					number_appt_operator1 = (ins_number_appt.indexOf('>=') >= 0);
					 if (number_appt_operator1 = true){
					 	ins_number_appt = c_utils.trim(ins_number_appt);
					 	posn = ins_number_appt.indexOf('>=');
					 	excerpt_str = ins_number_appt.substr(posn, 2);
					 	phraselen = ins_number_appt.length;
					 	excerpt_str2= ins_number_appt.substr(2, phraselen);
					 	excerpt_str2 = c_utils.trim(excerpt_str2);
			
					 }
					var number_appt_operator_again2:Boolean;
					number_appt_operator_again2 = (ins_number_appt2.indexOf('=<') >= 0);
					if (number_appt_operator_again2 == true){
							ins_number_appt2 = ins_number_appt2.split("=<").join("<=");
					}
					number_appt_operator2 = (ins_number_appt2.indexOf('<=') >= 0);
					 if (number_appt_operator2 == true){
					 	ins_number_appt2 = c_utils.trim(ins_number_appt2);
					 	posn = ins_number_appt2.indexOf('<=');
					 	excerpt_str = ins_number_appt2.substr(posn, 2);
					 	phraselen = ins_number_appt2.length;
					 	excerpt_str3= ins_number_appt2.substr(2, phraselen);
					 	excerpt_str3 = c_utils.trim(excerpt_str3);
				
					 }
					if ((number_appt_operator1 == true) && (number_appt_operator2 == true)){
									if ((Number(str_value) >= Number(excerpt_str2))&&(Number(str_value) <= Number(excerpt_str3))){
										//flag = true;  
									//} else{
									//	flag = false;
									
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
					}
			}
	            return	flag; 	
        }

