package com.handler
{ import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.AdvancedDataGrid;
	public class CopyToClipboardClass extends EventDispatcher
	{
		public function CopyToClipboardClass()
		{
		}
		
		
		public function clipboardDetail(arrsel:ArrayCollection,  dg:AdvancedDataGrid):String{
			var str:String = new String();	
			
			for(var j:int =0;j<dg.dataProvider.length;j++) {	
				//ayt_ctr = ayt_ctr + 1;
				//str+="<tr>";	
				
				for	(var ib:int = 0;ib<(arrsel.length);ib++){ 	
					for(var k:int=0; k < (dg.columns.length - 1); k++) {
						if (arrsel[ib].df == dg.columns[k].dataField){ 
							//Do we still have a valid item?				
							if(dg.dataProvider.getItemAt(j) != undefined && dg.dataProvider.getItemAt(j) != null) {
								//Check to see if the user specified a labelfunction which we must
								//use instead of the dataField
								if(dg.columns[k].labelFunction != undefined) {
									str += dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField)+";";
									
								} else {
									//Our dataprovider contains the real data
									//We need the column information (dataField)
									//to specify which key to use.
									if ((dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == null || (dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == undefined || (dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == ''){
										dg.dataProvider.getItemAt(j)[dg.columns[k].dataField] = '';
									} 
									str += dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]+";";
								}
							} 
							break;
						}
					}
					 if (ib == (arrsel.length - 1)){
						 str = str + '\n';
					 }
					
				}
				
				
			}	
			//str+=   c_utils.excelDetail(arrsel,j,dg);
			//str += ";";
			return str;
		}
		
		
		
	}
}

