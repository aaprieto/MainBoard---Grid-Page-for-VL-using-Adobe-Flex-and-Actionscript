// ActionScript file
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;

import mx.collections.*;
import mx.controls.*;
import mx.events.AdvancedDataGridEvent;
import mx.events.ListEvent;
import mx.managers.ToolTipManager;

private function checkSpeedOptionConnection(event:Event):void{
	
	
	var ag_speed_options:String = parentApplication.speed_options;
	//Alert.show(speed_options);
	if (ag_speed_options =='basic'){
		/*
		dg.setStyle("headerStyleName", '');
		dg.setStyle("horizontalGridLines", "false");
		dg.setStyle("verticalGridLines", "false");
		dg.setStyle("horizontalGridLineColor", "white");
		dg.setStyle("verticalGridLineColor", "white");
		dg.setStyle("borderColor", "white");
		dg.setStyle("borderThickness", "0");
		dg.setStyle("alternatingItemColors", ["white", "white"]);
		*/
		dg.styleName = "actiongridBasic";
	} else {
		dg.styleName = "actiongridStandard";
		/*
		dg.headerStyleName="centerAlignDataGridCol";
		dg.horizontalGridLines="true";
		dg.verticalGridLines="true";
		dg.horizontalGridLineColor="black";
		dg.verticalGridLineColor="black"; 
		dg.borderColor="#010101"; 
		dg.borderThickness="3";   
		*/
	/*
		dg.setStyle("headerStyleName", 'centerAlignDataGridCol');
		dg.setStyle("horizontalGridLines", "true");
		dg.setStyle("verticalGridLines", "true");
		dg.setStyle("horizontalGridLineColor", "black");
		dg.setStyle("verticalGridLineColor", "black");
		dg.setStyle("borderColor", "#010101");
		dg.setStyle("borderThickness", "3");
	*/
		//dg.setStyle("alternatingItemColors", ["#77FFDD", "#FFFFFF"]);
	
		
	}
	
	/* Add Values to Array */
	/*
	ArrayIcons = new ArrayCollection;
	var obj:Object = new Object;
	obj.id = "img_currentview"
	obj.path = 	"image/ico_user_preference_settings.png";
	ArrayIcons.addItem(obj);
	
	obj = new Object;
	obj.id = "img_renditions"
	obj.path = 	"image/ico_renditions.png";
	ArrayIcons.addItem(obj);	
		
	obj = new Object;
	obj.id = "img_persistent_views"
	obj.path = 	"image/ico_persistent_views.png";
	ArrayIcons.addItem(obj);	

	obj = new Object;
	obj.id = "img_transient_views"
	obj.path = 	"image/ico_transient_views.png";
	ArrayIcons.addItem(obj);	

	obj = new Object;
	obj.id = "img_query"
	obj.path = "image/ico_query.png";
	ArrayIcons.addItem(obj);	

	obj = new Object;
	obj.id = "img_clear"
	obj.path = "image/ico_clear.png";
	ArrayIcons.addItem(obj);	
	
	obj = new Object;
	obj.id = "img_reset"
	obj.path = "image/ico_reset.png";
	ArrayIcons.addItem(obj);	

	obj = new Object;
	obj.id = "img_reset"
	obj.path = "image/ico_reset.png";
	ArrayIcons.addItem(obj);	
	
	
	img_keep_selected.source="image/ico_keep_selected.png";
	img_discard_selected.source="image/ico_discard_selected.png";
	img_select_all.source="image/ico_select_all.png";
	img_multi_filter.source="image/ico_multi_filter.png";
	img_unsort.source="image/ico_unsort.png";
	img_total_selected.source="image/ico_total_selected.png";
	img_flash_filter.source="image/ico_flash_filter.png";
	img_crunch_grand_totals.source="image/ico_crunch.png";
	img_crunch_sub_totals.source="image/ico_crunch.png";
	img_export_all_to_excel.source="image/ico_export_all.png";
	img_export_sorted_to_excel.source="image/ico_export_sorted.png";
	img_lstrefrsh.source="image/ico_time_since_last_refresh.png";
	img_rows.source="image/ico_total_rows_displayed.png";
	img_gather.source="image/ico_time_to_load.png";
		*/
	//Alert.show(parentApplication.speed_options);
	//var ag_speed_options:String = parentApplication.speed_options;
	//Alert.show(speed_options);
	//if (ag_speed_options =='basic'){
		//this.setStyle("backgroundImage","");
		/*
		img_currentview.source="";
	
		img_renditions.source="";
	
		img_persistent_views.source="";
		img_transient_views.source="";
		img_query.source="";
		img_clear.source="";
		img_reset.source="";
		img_keep_selected.source="";
		img_discard_selected.source="";
		img_select_all.source="";
		img_multi_filter.source="";
		img_unsort.source="";
		img_total_selected.source="";
		img_flash_filter.source="";
		img_crunch_grand_totals.source="";
		img_crunch_sub_totals.source="";
		img_export_all_to_excel.source="";
		img_export_sorted_to_excel.source="";
		img_lstrefrsh.source="";
		img_rows.source=""; 
		img_gather.source=""; 
	*/
	//} else {
		//this.setStyle("backgroundImage","image/Blue3.png")
		/*
		img_currentview.source="image/ico_user_preference_settings.png";
	 
		img_renditions.source="image/ico_renditions.png";
		img_persistent_views.source="image/ico_persistent_views.png";
		img_transient_views.source="image/ico_transient_views.png";
		
		
		img_query.source="image/ico_query.png";
		
		img_clear.source="image/ico_clear.png";
		img_reset.source="image/ico_reset.png";
		img_keep_selected.source="image/ico_keep_selected.png";
		img_discard_selected.source="image/ico_discard_selected.png";
		img_select_all.source="image/ico_select_all.png";
		img_multi_filter.source="image/ico_multi_filter.png";
		img_unsort.source="image/ico_unsort.png";
		img_total_selected.source="image/ico_total_selected.png";
		img_flash_filter.source="image/ico_flash_filter.png";
		img_crunch_grand_totals.source="image/ico_crunch.png";
		img_crunch_sub_totals.source="image/ico_crunch.png";
		img_export_all_to_excel.source="image/ico_export_all.png";
		img_export_sorted_to_excel.source="image/ico_export_sorted.png";
		img_lstrefrsh.source="image/ico_time_since_last_refresh.png";
		img_rows.source="image/ico_total_rows_displayed.png";
		img_gather.source="image/ico_time_to_load.png";
	*/	
	//}
	
}