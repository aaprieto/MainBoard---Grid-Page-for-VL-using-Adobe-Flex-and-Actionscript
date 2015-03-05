package com.shared
{
	import com.utilities.Utils;
	
	import mx.controls.*;
	
	
	public class ManipulateDate
	{
		private var f_c_utils = new Utils();	
		//Alert.show("checkpoint 1");
		public function ManipulateDate()
		{ 
			
		
		}
		
		public function date_manipulate(from_filter:String):String {
			//Alert.show("here");
			var d:Date = new Date();
    		//var totalDate:String;
    		var dy:String = ((d.getDate()).toString());
    		var mt:String = ((d.getMonth() + 1).toString());
    		var yr:String = ((d.getFullYear()).toString());
    		var str_mt:String = addzero(mt);   
			var str_dy:String = addzero(dy);
			var f_ent_date:String = from_filter; 
			var f_ent_date_length:int;
			var ent_dateresult:Array = [];		
				//totalDate = String(yr + "-" + str_mt + "-" + str_dy);
					//		if (f_ent_date.length < 9)
				if (f_ent_date.indexOf("-") >= 0){
					ent_dateresult = f_ent_date.split("-");	
				} else{
					ent_dateresult = f_ent_date.split(".");	
				}
					var ent_datelen:int = ent_dateresult.length;	
					if(ent_datelen == 1){
						// Day 
						var ent_date_arr_result_day:String = ent_dateresult[0].toString();
						ent_date_arr_result_day = f_c_utils.trim(ent_date_arr_result_day);
						ent_date_arr_result_day = addzero(ent_date_arr_result_day);
									from_filter = String(yr + "-" + str_mt + "-" + ent_date_arr_result_day);
					}
					if(ent_datelen == 2){
						// Month
						var ent_date_arr_result_month:String = ent_dateresult[0].toString();
						ent_date_arr_result_month = f_c_utils.trim(ent_date_arr_result_month);
						ent_date_arr_result_month = addzero(ent_date_arr_result_month);
						// Day
						ent_date_arr_result_day = ent_dateresult[1].toString();
						ent_date_arr_result_day = f_c_utils.trim(ent_date_arr_result_day);
						ent_date_arr_result_day = addzero(ent_date_arr_result_day);
								from_filter = String(yr + "-" + ent_date_arr_result_month + "-" + ent_date_arr_result_day);
					} 
					if(ent_datelen == 3){
						// Year
						var ent_date_arr_result_year:String = ent_dateresult[0].toString();
						ent_date_arr_result_year = f_c_utils.trim(ent_date_arr_result_year);
						ent_date_arr_result_year = addzero(ent_date_arr_result_year);
						// Month
						ent_date_arr_result_month = ent_dateresult[1].toString();
						ent_date_arr_result_month = f_c_utils.trim(ent_date_arr_result_month);
						ent_date_arr_result_month = addzero(ent_date_arr_result_month);
						// Day
						ent_date_arr_result_day = ent_dateresult[2].toString();
						ent_date_arr_result_day = f_c_utils.trim(ent_date_arr_result_day);
						ent_date_arr_result_day = addzero(ent_date_arr_result_day);
					
					if (ent_date_arr_result_year.length == 2){
								yr = yr.substr(0,2);
								from_filter = String(yr + ent_date_arr_result_year + "-" + ent_date_arr_result_month + "-" + ent_date_arr_result_day);
					} else if (ent_date_arr_result_year.length == 3){
								yr = yr.substr(0,1);
								from_filter = String(yr + ent_date_arr_result_year + "-" + ent_date_arr_result_month + "-" + ent_date_arr_result_day);
					} else {
								from_filter = String(ent_date_arr_result_year + "-" + ent_date_arr_result_month + "-" + ent_date_arr_result_day);
					}
				}
//		}
					return from_filter
			}

		private function addzero(pass_str:String):String{
			var passlength:int = pass_str.length;
			if (passlength == 1){
				pass_str = "0" + pass_str;
			}
			return pass_str;	
		}

		

	}
}