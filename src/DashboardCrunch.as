// ActionScript file
/*
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.ui.Keyboard;

import flashx.textLayout.formats.BackgroundColor;
*/
import mx.collections.*;
import mx.collections.ArrayCollection;
import mx.controls.*;
import mx.controls.Alert;
import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
import mx.core.ClassFactory;
import mx.core.IFactory;
import mx.events.AdvancedDataGridEvent;
import mx.events.CloseEvent;
import mx.events.ListEvent;
import mx.logging.errors.InvalidFilterError;
import mx.managers.PopUpManager;
import mx.managers.ToolTipManager;
import mx.rpc.events.*;
import mx.states.SetStyle;
import mx.utils.ArrayUtil;
/*
import spark.components.ComboBox;
import spark.components.TextInput; 
*/




[Bindable]
private var d_arrcol:ArrayCollection = new ArrayCollection;
//public var d_newObject1:datagrid_test = new datagrid_test();
private function ca_sortdashbord(event:Event,d_columnArray:ArrayCollection, d_mainColumnArray:Object, d_mfArray:ArrayCollection, d_headTitle:String,d_local_sesid:String,d_local_companycode:String, d_local_crunch:String  ):void{
	//Alert.show(d_columnArray.length.toString());
	
	
	
	var title_header:String = new String;
	var aColumnsNew:Array = new Array;
	var obj:Object = new Object();
	d_arrcol = new ArrayCollection;
	for (var ctr_i:int = 0; ctr_i < d_columnArray.length; ctr_i++){
		
		for (var i:int=0;i<d_mainColumnArray.length;i++)  {
			if (d_columnArray[ctr_i].cs_field == d_mainColumnArray[i]["dataField"]){
				
				obj = new Object();	
				obj.columnId = ctr_i;
				obj.columnName = d_mainColumnArray[i]["dataField"];
				obj.dataField = d_columnArray[ctr_i].cs_field;
				obj.title_header = d_mainColumnArray[i]["title_header"];
				obj.width = parseInt(d_mainColumnArray[i]["width"]);
				obj.wordwrap = d_mainColumnArray[i]["wordwrap"];
				obj.datatype = d_mainColumnArray[i]["datatype"];
				obj.tcv = "-";
				d_arrcol.addItem(obj);
				
			
				
				if (d_mainColumnArray[i]["datatype"] == 'N'){
					dgc.setStyle("textAlign", "right");
					dgc.setStyle('color','green');
					
				}
				break;
				
				
			}
		} 
		
		aColumnsNew.push(dgc);
		
		if (d_columnArray[ctr_i].cs_datatype == 'N'){
		
			obj = new Object();	
			obj.columnId = ctr_i;
			obj.columnName = d_mainColumnArray[i]["dataField"];
			obj.dataField = 'pct_' + d_columnArray[ctr_i].cs_field;
			obj.title_header = '%';
			obj.width = '110';
			obj.wordwrap = false;
			obj.datatype = d_mainColumnArray[i]["datatype"];
			obj.tcv = "-";
			d_arrcol.addItem(obj);
			
			
		}
	}
	
	obj = new Object();	
	obj.columnId = ctr_i;
	obj.columnName ='instance';
	obj.dataField = 'instance';
	obj.title_header = 'Instance';
	obj.width = '110';
	obj.wordwrap = false;
	obj.datatype = 'N';
	obj.tcv = "-";
	d_arrcol.addItem(obj);
	
	
	obj = new Object();	
	obj.columnId = ctr_i;
	obj.columnName ='pct_instance';
	obj.dataField = 'pct_instance';
	obj.title_header = '%';
	obj.width = '110';
	obj.wordwrap = false;
	obj.datatype = 'N';
	obj.tcv = "-";
	d_arrcol.addItem(obj);
	
	

	obj = new Object();	
	obj.columnId = '100';
	obj.columnName = "upd_unique";
	obj.dataField ="upd_unique";
	obj.title_header = "Unique Key";
	obj.width = parseInt("200");
	obj.wordwrap = "false";
	obj.datatype = "S";
	obj.analyzeby = "no";
	obj.drilldown = "no";
	obj.tcv = "-";
	d_arrcol.addItem(obj);
	
	
	
	obj = new Object();	
	obj.columnId = ctr_i;
	obj.columnName ='';
	obj.dataField = '';
	obj.title_header = '';
	obj.width = '1500';
	obj.wordwrap = false;
	obj.datatype = 'N';
	obj.tcv = "-";
	d_arrcol.addItem(obj);
	
	
	d_arrcol.refresh();
	
//	newObject1 = new datagrid_test();
	
	
//	newObject1._xlcTitle = d_local_crunch + ' Console';
//	newObject1._xlcColumn = d_arrcol;
	
//	newObject1.crunch_Array1 = d_mfArray;
	
//	newObject1.ag_application_entry = parentApplication.application_entry;
	//newObject1.height = vdivbox.height; 
//	newObject1.my_sid = d_local_sesid;
//	newObject1.my_c_code1 = d_local_companycode;
//	newObject1.crunch = true;
	//vdivbox.addChild(newObject1); 
	
	
	
	
	
	
	d_popshowChart = DashboardShowChart(
		PopUpManager.createPopUp(this, DashboardShowChart, true));
	
	d_popshowChart.mfArray = d_mfArray; 
	
	d_popshowChart.ca_xlcColumn = d_arrcol;     
	
	//d_popshowChart.adv_mfArray = newObject1.dg;
	
	
	d_popshowChart.cap_title = "Grand Total";
	d_popshowChart.showlocal_crunch = d_local_crunch;
	   
	
}
private var d_popshowChart:DashboardShowChart;  
