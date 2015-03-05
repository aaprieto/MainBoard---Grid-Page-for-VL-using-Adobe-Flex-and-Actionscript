// ActionScript file for Date Filter 

		public function date_filter(event:Event):void {
			var index_location:int = dg.horizontalScrollPosition;
					cd = custom_datafield.toString();
            		ct = custom_text.toString();
            		str_action = action_command.toString();
					
				/*  Have to repeat 2x for double valued date parameter.  
					This is not a good way to code this.  Will get back to this when I get a chance.
					*/	
				for (var x:int=0;x<3;x++){
					
						for (var i:int=0;i<DateValueArr.length;i++){
							
							//Alert.show(DateValueArr[i]['code']);
							ct = ct.replace(DateValueArr[i]['code'],DateValueArr[i]['date']);
							
						}
				}		  
				
				         
            	//tdObjectCollection.filterFunction = DateObjectCollectionFilterFunc;
           		//tdObjectCollection.refresh();
           		//Alert.show("First pass: " + Array1.length.toString());
           		Array1.filterFunction = DateObjectCollectionFilterFunc;
           		
           		Array1.refresh();
           		//Alert.show("Second pass: " + Array1.length.toString());
           		ArraySwap(event);
           		Array1.refresh();
           		dg.horizontalScrollPosition = index_location;
				//Remove this for one click functionality
				//correctWidth(event);
		}
		
		
		
			public function date_filter_for_add(event:Event):void {


			 	var index_location:int = dg.horizontalScrollPosition;
					cd = custom_datafield.toString();
            		ct = custom_text.toString();
					str_action = action_command.toString();
					
					
					for (var i:int=0;i<DateValueArr.length;i++){
						
						//Alert.show(DateValueArr[i]['code']);
						ct = ct.replace(DateValueArr[i]['code'],DateValueArr[i]['date']);
					} 
           		if ((str_action == "keep")||(str_action == "discard")){
           			Array3.filterFunction = DateObjectCollectionFilterFunc;
           			Array3.refresh();
           				ArraySwap_for_add(event);
           			//	Array2.refresh();
           		
 
           				dg.horizontalScrollPosition = index_location;
           				correctWidth(event);
           		}
 				
 					if (str_action == "add"){
           			//Alert.show(str_action);
           			str_action = "keep";
           			Array3.filterFunction = DateObjectCollectionFilterFunc;
           			Array3.refresh();
           			str_action = "add";
           				ArraySwap_for_add_final(event);
           			//	Array2.refresh();
           		
 
           				dg.horizontalScrollPosition = index_location;
           				correctWidth(event);
           		}
 
           		
	}
		
		
		
		////////////////////////////////////////////////////////  Date Filter ///////////////////////////////////////////////////////////
		
		public function DateObjectCollectionFilterFunc(item:Object):Boolean {
			
			var man = new ManipulateDate();
			var date_apptresult:Array = [];
			var date_apptflag:Boolean;
			var currentsflag:Boolean;
			var flag:Boolean = false;
			currentsflag = false;
			if (str_action == "discard"){
			flag = true;
			}			
			if (str_action == "discard"){
			currentsflag = true;
			}
				date_apptresult = ct.split("+");	
			var	date_apptlen:int = date_apptresult.length;
			var str_value:String = new String;
				str_value = item[cd];
				
			if (date_apptlen == 1){
				
					var ins_date_appt:String = date_apptresult[0].toString();
					var date_appt_operator:Boolean = false
 						ins_date_appt = c_utils.trim(ins_date_appt);
 			
		
				
 					// Greater Than
					var deliv_date_operator:Boolean = (ins_date_appt.indexOf('>') >= 0);
					 if (deliv_date_operator = true){
					   
					 	var posn:Number = ins_date_appt.indexOf('>');
					 	var excerpt_str:String = ins_date_appt.substr(posn, 1);
					 	var phraselen:Number = ins_date_appt.length;
					 	var excerpt_str2:String = ins_date_appt.substr(1, phraselen);
					 
				
					 	excerpt_str2 = c_utils.trim(excerpt_str2);
					
					    excerpt_str2 = man.date_manipulate(excerpt_str2); 
						
						
						
						
					 		if (excerpt_str == ">"){   //  Greater Than
								if (str_value > excerpt_str2){
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
 					 // Less Than
					date_appt_operator = false;
					date_appt_operator = (ins_date_appt.indexOf('<') >= 0);
					if (date_appt_operator = true){
					 	posn = ins_date_appt.indexOf('<');
					 	excerpt_str = ins_date_appt.substr(posn, 1);
					 	phraselen = ins_date_appt.length;
					 	excerpt_str2 = ins_date_appt.substr(1, phraselen);
					 	excerpt_str2 = c_utils.trim(excerpt_str2);
					 	  excerpt_str2 = man.date_manipulate(excerpt_str2);
					 		if (excerpt_str == "<"){   // Less Than
								if (str_value < excerpt_str2){
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
					date_appt_operator = false;
					var date_appt_operator_again:Boolean;
					date_appt_operator_again = (ins_date_appt.indexOf('=>') >= 0);
					if (date_appt_operator_again = true){
							ins_date_appt = ins_date_appt.split("=>").join(">=");
					}
					date_appt_operator = (ins_date_appt.indexOf('>=') >= 0);
					if (date_appt_operator = true){
					 	posn = ins_date_appt.indexOf('>=');
					 	excerpt_str = ins_date_appt.substr(posn, 2);
					 	phraselen = ins_date_appt.length;
					 	excerpt_str2 = ins_date_appt.substr(2, phraselen);
						
						
						
					 	excerpt_str2 = c_utils.trim(excerpt_str2);
					 	  excerpt_str2 = man.date_manipulate(excerpt_str2);
					 		if (excerpt_str == ">="){  // Greater Than, Equal To
								if (str_value >= excerpt_str2){
									//	flag = true;
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
					date_appt_operator = false;
					//var deliv_appt_operator_again:Boolean;
					date_appt_operator_again = (ins_date_appt.indexOf('=<') >= 0);
					if (date_appt_operator_again = true){
							ins_date_appt = ins_date_appt.split("=<").join("<=");
					}
					date_appt_operator = (ins_date_appt.indexOf('<=') >= 0);
					if (date_appt_operator = true){
					 	posn = ins_date_appt.indexOf('<=');
					 	excerpt_str = ins_date_appt.substr(posn, 2);
					 	phraselen = ins_date_appt.length;
					 	excerpt_str2 = ins_date_appt.substr(2, phraselen);
					 	excerpt_str2 = c_utils.trim(excerpt_str2);
					 	excerpt_str2 = man.date_manipulate(excerpt_str2);
					 		if (excerpt_str == "<="){  //  Less Than, Equal To
					 			flag = false;
					 				if (str_value <= excerpt_str2){
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
					// Equal To
					date_appt_operator = false;
					var sec_len:Number;
					var str_second_len:String = ins_date_appt.substr(0,1)
					var sec_string:String;
					if ((str_second_len != ">")&&(str_second_len != "<")){
					 	excerpt_str = ins_date_appt.substr(0, 1);
					 		if (excerpt_str == "="){
					 				sec_len = ins_date_appt.length;
					 				sec_string = ins_date_appt.substr(1,sec_len);
					 				sec_string = c_utils.trim(sec_string);
					 				sec_string = man.date_manipulate(sec_string);
					 				if (str_value == sec_string){
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
					 		} else{
					 				
					 				/*  This checks for  keyboard strokes on "*","/","-" */					
									flag = manager_datagrid_handler.CompareWildcard(ins_date_appt, str_value, flag, str_action);
									
					 				ins_date_appt = man.date_manipulate(ins_date_appt);
					 				if (str_value == ins_date_appt){
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
			
			if (date_apptlen == 2){
					ins_date_appt = date_apptresult[0].toString();
					var ins_date_appt2:String = date_apptresult[1].toString();
					var date_appt_operator1:Boolean = false
					var date_appt_operator2:Boolean = false
					//var excerpt_str2:String;
					var excerpt_str3:String;
						// Greater than and Less than
						date_appt_operator1 = (ins_date_appt.indexOf('>') >= 0);
					 if (date_appt_operator1 == true){
					 	ins_date_appt = c_utils.trim(ins_date_appt);
					 	posn = ins_date_appt.indexOf('>');
					 	excerpt_str = ins_date_appt.substr(posn, 1);
					 	phraselen = ins_date_appt.length;
					 	excerpt_str2= ins_date_appt.substr(1, phraselen);
					 	excerpt_str2 = c_utils.trim(excerpt_str2);
					 	excerpt_str2 = man.date_manipulate(excerpt_str2);
					 }	
					 date_appt_operator2 = (ins_date_appt2.indexOf('<') >= 0);
					 if (date_appt_operator2 == true){
					 	ins_date_appt2 = c_utils.trim(ins_date_appt2);
					 	posn = ins_date_appt2.indexOf('<');
					 	excerpt_str = ins_date_appt2.substr(posn, 1);
					 	phraselen = ins_date_appt2.length;
					 	excerpt_str3= ins_date_appt2.substr(1, phraselen);
					 	excerpt_str3 = c_utils.trim(excerpt_str3);
					 	excerpt_str3 = man.date_manipulate(excerpt_str3);
					 }
				if ((date_appt_operator1 == true) && (date_appt_operator2 == true))						
					{
									if ((str_value > excerpt_str2)&&(str_value < excerpt_str3)){
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
				date_appt_operator1 = false;
				date_appt_operator2 = false;
					 
				////////////////////////////////////////////////////////			
					//var deliv_appt_operator_again:Boolean;
					date_appt_operator_again = (ins_date_appt.indexOf('=>') >= 0);
					if (date_appt_operator_again = true){
							ins_date_appt = ins_date_appt.split("=>").join(">=");
					}
					// Greater Than equal To and Less Than Equal To
					date_appt_operator1 = (ins_date_appt.indexOf('>=') >= 0);
					 if (date_appt_operator1 = true){
					 	ins_date_appt = c_utils.trim(ins_date_appt);
					 	posn = ins_date_appt.indexOf('>=');
					 	excerpt_str = ins_date_appt.substr(posn, 2);
					 	phraselen = ins_date_appt.length;
					 	excerpt_str2= ins_date_appt.substr(2, phraselen);
					 	excerpt_str2 = c_utils.trim(excerpt_str2);
					 	excerpt_str2 = man.date_manipulate(excerpt_str2);
					 }
					var date_appt_operator_again2:Boolean;
					date_appt_operator_again2 = (ins_date_appt2.indexOf('=<') >= 0);
					if (date_appt_operator_again2 == true){
							ins_date_appt2 = ins_date_appt2.split("=<").join("<=");
					}
					date_appt_operator2 = (ins_date_appt2.indexOf('<=') >= 0);
					 if (date_appt_operator2 == true){
					 	ins_date_appt2 = c_utils.trim(ins_date_appt2);
					 	posn = ins_date_appt2.indexOf('<=');
					 	excerpt_str = ins_date_appt2.substr(posn, 2);
					 	phraselen = ins_date_appt2.length;
					 	excerpt_str3= ins_date_appt2.substr(2, phraselen);
					 	excerpt_str3 = c_utils.trim(excerpt_str3);
					 	excerpt_str3 = man.date_manipulate(excerpt_str3);
					 }
					if ((date_appt_operator1 == true) && (date_appt_operator2 == true)){
									if ((str_value >= excerpt_str2)&&(str_value <= excerpt_str3)){
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
			
	            return	flag; 	
        }
