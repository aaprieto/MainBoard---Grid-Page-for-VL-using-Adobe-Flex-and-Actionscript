package com.handler
{
	
		import flash.events.EventDispatcher;
		import flash.external.ExternalInterface;
		
		import mx.collections.ArrayCollection;
		import mx.controls.Alert;
		import mx.controls.AdvancedDataGrid;
		
		public class ExportToExcel extends EventDispatcher
		{ 
			public function ExportToExcel()
			{
				
				
			}
			public function excelheader(arrsel:ArrayCollection, l_dg:AdvancedDataGrid, hcolor:Array):String{
				var l_str:String = new String();
				var colors:String = '';
				for	(var ia:int = 0;ia<(arrsel.length);ia++) {
					for(var i:int = 0;i<(l_dg.columns.length - 1);i++) {
						
						if (arrsel[ia].df == l_dg.columns[i].dataField){
							colors = l_dg.getStyle("themeColor");
							
							if(l_dg.columns[i].headerText != undefined) {
								l_str+="<th "+"style='background-color:#"+Number((hcolor[0])).toString(16)+"' width=\""+Math.ceil(l_dg.columns[i].width)+"\" "+">"+l_dg.columns[i].headerText+"</th>";
							} else {
								l_str+= "<th "+"style='background-color:#"+Number((hcolor[0])).toString(16)+"' width=\""+Math.ceil(l_dg.columns[i].width)+"\" "+">"+l_dg.columns[i].dataField+"</th>";
							}
							break;
						}
						
					}
				}	
				
				//dispatchEvent(new CustomEvent(CustomEvent.BUTTON_CLICKED, 0));
				return l_str;
			} 
			
			
			/*
			for(var j:int =0;j<dg.dataProvider.length;j++) {	
			ayt_ctr = ayt_ctr + 1;
			str+="<tr>";
			//str+=  excelDetailLoop(arrsel, j);
			str+=   c_utils.excelDetail(arrsel,j,dg);
			str += "</tr>";
			//if (ayt_ctr == 50){
			//dispatchEvent( new CustomEvent( CustomEvent.DATA_LOADED, false, false, str ) );
			//AlertMessageShow(str);
			//}
			}
			*/
			
			public function excelDetail(arrsel:ArrayCollection,  dg:AdvancedDataGrid):String{
				var str:String = new String();	
				
				for(var j:int =0;j<dg.dataProvider.length;j++) {	
					//ayt_ctr = ayt_ctr + 1;
					str+="<tr>";	
					
					for	(var ib:int = 0;ib<(arrsel.length);ib++){ 	
						for(var k:int=0; k < (dg.columns.length - 1); k++) {
						
							
							if (arrsel[ib].df == dg.columns[k].dataField){ 
								//Do we still have a valid item?				
								if(dg.dataProvider.getItemAt(j) != undefined && dg.dataProvider.getItemAt(j) != null) {
									//Check to see if the user specified a labelfunction which we must
									//use instead of the dataField
									if(dg.columns[k].labelFunction != undefined) {
										if (arrsel[ib].dt != "N"){
										str += "<td>&nbsp;"+dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField)+"</td>";
										} else {
											str += "<td>"+dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField)+"</td>";
										}
									} else {
										//Our dataprovider contains the real data
										//We need the column information (dataField)
										//to specify which key to use.
										if ((dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == null || (dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == undefined || (dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]) == ''){
											dg.dataProvider.getItemAt(j)[dg.columns[k].dataField] = '';
										} 
										if (arrsel[ib].dt != "N"){
											str += "<td>&nbsp;"  +dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]+"</td>"; 
										} else {
											str += "<td>"  +dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]+"</td>";
										}
									}
								} 
								break;
							}
						}
						
						
					}
					
					
				}	
				//str+=   c_utils.excelDetail(arrsel,j,dg);
				str += "</tr>";
				
				return str;
			}
			
		}
	}