import mx.collections.ArrayCollection;

// ActionScript file

	public var pivotchooser:PivotChooser; 
	private var PivotDataCollection:ArrayCollection;
	private var SecondPassPivotDataCollection:ArrayCollection;
	private function launchPivotChooser(event:Event):void {
		pivotchooser = PivotChooser(
			PopUpManager.createPopUp(this, PivotChooser, true));
			pivotchooser.pivot_xlcColumn = _xlcColumn;
			//pivotchooser["btn_accept"].addEventListener( MouseEvent.CLICK,pivotGridColumnsToRows);
			pivotchooser["btn_accept"].addEventListener( MouseEvent.CLICK,pre_pivotGrid);  
		//PopUpManager.centerPopUp(pivotchooser);
	}
	private var _ColumnstoRow:ArrayCollection;
	private var _BaseKeep:ArrayCollection;

	private function aytResultHandler(event:ResultEvent):void {
		
		if ( event.result.status != 'OK' ) {
			
			//var s_ret:String = resultStatus(event.result.status, event.result.reason);  
			//AlertMessageShow(s_ret);
			//finishLogout();
			
			
			AlertMessageShow	(
			'AYT failed; Please log out - ' + event.result.reason
			
			);
			
			
		}
		
		pivotGrid(event);
		
	}
	private function hsFaultHandler(event:FaultEvent):void {
		
		AlertMessageShow	(
			'HTTP request failed'
		);	
	}

	private function pre_pivotGrid(event:Event):void {
	
		//Alert.show(ag_application_entry);
		if (ag_application_entry == 'vl'){ 
			//////////////////////////////////////////////////////////////////////////////////////////////////////
			/*  Fire Alert for Waiting Display */
			Alert.buttonWidth =141; 
			myAlert = Alert.show("","Calculating...",0,this,null,confirmIcon);  
			// modify the look of the Alert box
			myAlert.setStyle("backgroundColor", '#C3D9FA');
			myAlert.setStyle("borderColor", 0xffffff);
			myAlert.setStyle("borderAlpha", 0.75);
			myAlert.setStyle("fontSize", 14); 
			myAlert.setStyle("fontWeight", "bold");
			myAlert.setStyle("color", 0x000000); // text color
			///////////////////////////////////////////////////////////////////////////////////////////////////////
			httpAYT.send();
		} else {
			pivotGrid(event);
		}	
	}

	private function pivotGrid(event:Event):void {
		
		
	
		
		
		PivotDataCollection = new ArrayCollection;
	
		var pivotObj:Object; 
		
	
		
		_ColumnstoRow = pivotchooser.Arr_ColumnstoRow;
		_BaseKeep = pivotchooser.Arr_Discard;
		///////////////////////////////////////////////////////////////////////
		/*  Put Validation here.  */
		
		if (_ColumnstoRow.length < 1){
			AlertMessageShow("Please put values on Columns to Row");
			return;
		}
		if (_BaseKeep.length < 1){
			AlertMessageShow("Please put values on Base Columns to Keep");
			return;
		}   
		
		////////////////////////////////////////////////////////////////////////
		
		//  Do not remove first until finish testing.
		//PopUpManager.removePopUp(pivotchooser);
		
		/*  Start your engine */
		/*  Loop for ArrayCollection First. */
		var ctr_unique:int = 0;
		var totaluniquestring:String = new String;
		for (var a:int=0;a<Array1.length;a++)  {
			//Alert.show("a " + a.toString() );
			/* Loop for Columns to Rows */
			for (var c:int=0;c<_ColumnstoRow.length;c++)  {
				
				pivotObj = new Object;
						pivotObj.pivot =  _ColumnstoRow[c]['title_header'];
						pivotObj.value =  Array1[a][_ColumnstoRow[c]['dataField']];
						// Loop for Base Column to Keep    
						var str_unique:String = new String;
						for (var b:int=0;b<_BaseKeep.length;b++)  {
						
							pivotObj[_BaseKeep[b]['dataField']] =  Array1[a][_BaseKeep[b]['dataField']];
							str_unique = str_unique + Array1[a][_BaseKeep[b]['dataField']];
						}
					
						
						var retpdc:int = searchPivotDataCollection(pivotObj);
						//Alert.show(retpdc.toString());
						if (retpdc < 0){
							ctr_unique = ctr_unique + 1;         
							totaluniquestring = str_unique + ctr_unique.toString();
							pivotObj.upd_unique = totaluniquestring;   
							//pivotObj.upd_unique = str_unique + pivotObj.upd_unique;
							PivotDataCollection.addItem(pivotObj);
						}
						if (retpdc >= 0){
							//PivotDataCollection[retpdc]['value'] = Number(PivotDataCollection[retpdc]['value']) +  Number(pivotObj.value);
							//PivotDataCollection[retpdc]['value'] = (PivotDataCollection[retpdc]['value'] / 100)*100;
							//PivotDataCollection[retpdc]['value'] = Math.round((Number(PivotDataCollection[retpdc]['value']) +  Number(pivotObj.value)),2);
						
							PivotDataCollection[retpdc]['value'] = Math.round((Number(PivotDataCollection[retpdc]['value']) +  Number(pivotObj.value))*100)/100;
						
						}
			}   
		}
		// Remove this at end of testing.
		//pivotchooser.dg_testing.dataProvider = PivotDataCollection;
		
		launchPivotAnalysis(event,PivotDataCollection, _ColumnstoRow,_BaseKeep );
	}
	private function searchPivotDataCollection(pObj:Object):int{
		//Alert.show(pObj.pivot);
		var transpivotObj:Object; 
		var flag:Boolean = false;
		var retint:int = -1;
		if (PivotDataCollection.length == 0){
			flag = false;   
		} else{
				
				for (var a:int=0;a<PivotDataCollection.length;a++)  {
					
					
					if (PivotDataCollection[a]['pivot'] == pObj.pivot){
						
						var detflag:Boolean = false;
						flag = true;
						for (var b:int=0;b<_BaseKeep.length;b++)  {
							
							if (pObj[_BaseKeep[b]['dataField']] ==  PivotDataCollection[a][_BaseKeep[b]['dataField']]){
										detflag = true;
							} else {
								detflag = false;
								flag = false;
								break;
							}
							flag = flag && detflag;
						}
					}		
					if (flag== true){
						retint = a;
						break;
					}
				} 
		}
		
		if (flag == false){
			return retint;	
		} else{
			return retint;
		}
		
	}

	public var popPivot:PivotAnalysis; 
	private function launchPivotAnalysis(event:Event, arr_pvc:ArrayCollection, arr_columnstorow:ArrayCollection, arr_basetokeep:ArrayCollection):void {
		PopUpManager.removePopUp(myAlert);
		PopUpManager.removePopUp(pivotchooser);
		popPivot = PivotAnalysis(
			PopUpManager.createPopUp(this, PivotAnalysis, true));
		popPivot.columnstorow = arr_columnstorow;
		popPivot.basetokeep = arr_basetokeep;
		popPivot.mainColumnArray = _xlcColumn;
		popPivot.mfArray = arr_pvc;
		popPivot.headTitle = "Columns to Rows";
		popPivot.local_sesid = my_sid;
		popPivot.local_companycode = my_c_code1; 
		popPivot.local_crunch = "Pivot";
		
	}
