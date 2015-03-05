// ActionScript file
import mx.collections.ArrayCollection;

	   private function ChartHandler(event:Event):void {
	  	//Alert.show(Array1.length.toString());
	/*
	  	Array6 = new ArrayCollection();
			
	  	for( var i:int = 0; i < Array1.length; i++ ){
	  	var flag:Boolean = false;
	  	var currentsflag:Boolean = false;
	  	var str_column:String = new String;
	  	var obj:Object = new Object();
						for (var ix:int=0;ix< _xlcColumn.length; ix++)  { 
							var datafield:String = (_xlcColumn[ix]["title_header"]).toString();
									if  (cb_columns.selectedLabel == datafield){
										//Alert.show(Array1.length.toString());
										 str_column = Array1[i][_xlcColumn[ix]["dataField"]]
											flag = true;
										//Alert.show(Array1[i][_xlcColumn[ix]["dataField"]]);		
									}else{
											flag = false;
									} 
									
									currentsflag = (currentsflag || flag);

						}
				
			if 	(currentsflag ==  true){
				var arrflag:Boolean = false;
				var currentarrflag:Boolean = false; 
				
				for (var ia:int=0;ia< Array6.length; ia++) {
						if (Array6[ia].group == str_column){
							Array6[ia].noofrec = int(Array6[ia].noofrec) + int(1);
							arrflag = true;
						}
						currentarrflag = (currentarrflag || arrflag);
				}
					
				if (currentarrflag == false){	
					obj.group = str_column;
					obj.noofrec = 	"1";
					Array6.addItem(obj);
				}
			}			
	  	}
	  	/*
	  	for (var a:int=0;a< Array6.length; a++) {
	  		Alert.show(Array6[a].group.toString() + " : " +Array6[a].noofrec.toString());
	  	}
	  	*/
		//Alert.show(analyzeColumns.length.toString());
	  			

	  	launchChart(event); 
	  }
	  
	  
	  
	  
	  
	  		//public var pop8:ChartResult;
	  		public var pop8:ChartingDialog;
            //public var myArray:Array;
            private function launchChart(event:Event):void {
               	//pop8 = ChartResult(
			
			
			
				var obj:Object = new Object();
				//var S_xlcColumn:ArrayCollection =  new ArrayCollection();
			
			
			
				S_xlcColumn =  new ArrayCollection();
			
				for( var i:int = 0; i < _xlcColumn.length; i++ ){
					if (_xlcColumn[i]['datatype'] != 'N'){
						obj = new Object();
						obj.columnId = _xlcColumn[i]['columnId'];
						obj.columnName = _xlcColumn[i]['columnName'];
						obj.dataField = _xlcColumn[i]['dataField'];
						obj.title_header = _xlcColumn[i]['title_header'];
						obj.width = _xlcColumn[i]['width'];
						obj.datatype = _xlcColumn[i]['datatype'];
						S_xlcColumn.addItem(obj);
					}	
				}
				
						
               	pop8 = ChartingDialog(
                //var win:ActionCommand = PopUpManager.createPopUp(this, ActionCommand, true) as ActionCommand);
                PopUpManager.createPopUp(this, ChartingDialog, true));
                //pop8.chart_xlcColumn = _xlcColumn;
                pop8.chart_xlcColumn = S_xlcColumn;
                pop8.chartArray1 = Array1;
                pop8.numericArray = numericColumns;
                pop8.analyzeArray = analyzeColumns;
              //  pop8.myArray = Array6.toArray(); 
                
                
                
                /*
                pop2["dg_1"].addEventListener(KeyboardEvent.KEY_DOWN, enterHistoryValue);
   		        pop2["btn_undo"].addEventListener("click", removeLastArrayRecord);  
   		        //pop2["btn_reapply"].addEventListener("click", refreshButton); 
   		        pop2["btn_undoall"].addEventListener("click", erase);
   		        pop2["btn_save"].addEventListener("click", launchFilterMacro)
   		        */
                // PopUpManager.centerPopUp(pop1);
           		//removeMe(event); 
            }
	  
	  
	  /*
	  
	  
	  	private function ArraySwap_for_add_final(evt:Event):void{
			var flag:Boolean = true;
			var currentsflag:Boolean = true;
			Array6 = new ArrayCollection();
 					for( var i:int = 0; i < Array1.length; i++ ){
						var obj:Object = new Object();
						for (var ix:int=0;ix< _xlcColumn.length; ix++)  { 
							var datafield:String = (_xlcColumn[ix]["dataField"]).toString();
							if (ix == 0){		
							 	for (var ia:int = 0; ia < Array1.length; ia++){
									if(Array1[ia][datafield] == Array3[ix][datafield]){
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
					}
					ArraySwap(evt);
 		}	
 		
*/
/*
	   private function ChartHandler(event:Event):void {
	  	//Alert.show(Array1.length.toString());
	  
	  	Array6 = new ArrayCollection();
			
	  	for( var i:int = 0; i < Array1.length; i++ ){
	  	var flag:Boolean = false;
	  	var currentsflag:Boolean = false;
	  	var str_column:String = new String;
	  	var obj:Object = new Object();
						for (var ix:int=0;ix< _xlcColumn.length; ix++)  { 
							var datafield:String = (_xlcColumn[ix]["title_header"]).toString();
									if  (cb_column_group.selectedLabel == datafield){
										//Alert.show(Array1.length.toString());
										 str_column = Array1[i][_xlcColumn[ix]["dataField"]]
											flag = true;
										//Alert.show(Array1[i][_xlcColumn[ix]["dataField"]]);		
									}else{
											flag = false;
									} 
									
									currentsflag = (currentsflag || flag);

						}
				
			if 	(currentsflag ==  true){
				var arrflag:Boolean = false;
				var currentarrflag:Boolean = false; 
				
				for (var ia:int=0;ia< Array6.length; ia++) {
						if (Array6[ia].group == str_column){
							Array6[ia].noofrec = int(Array6[ia].noofrec) + int(1);
							arrflag = true;
						}
						currentarrflag = (currentarrflag || arrflag);
				}
					
				if (currentarrflag == false){	
					obj.group = str_column;
					obj.noofrec = 	"1";
					Array6.addItem(obj);
				}
			}			
	  	}
	  	
	  	launchChart(event);
	  }
	  
	  
	  
	  
	  
	  		public var pop8:ChartResult;
            //public var myArray:Array;
            private function launchChart(event:Event):void {
               	pop8 = ChartResult(
                //var win:ActionCommand = PopUpManager.createPopUp(this, ActionCommand, true) as ActionCommand);
                PopUpManager.createPopUp(this, ChartResult, true));
                
                pop8.myArray = Array6.toArray(); 
                
                // PopUpManager.centerPopUp(pop1);
           		//removeMe(event); 
            }
	  
	  
	 
 		
*/