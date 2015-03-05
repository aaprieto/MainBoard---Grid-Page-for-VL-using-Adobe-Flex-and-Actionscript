package com.handler
{
	import flash.events.Event;
	
	public class ManagerDatagridHandler
	{
		import mx.controls.Alert;
		public function ManagerDatagridHandler()
		{
		}
		
		
		
		public function CompareWildcard(entryvalue:String, columnvalue:String, flag:Boolean, action:String): Boolean{
				
					if (action == "keep"){
						
							if (entryvalue == "-"){
								if ((columnvalue == "")||(columnvalue == null)){
										flag = true;
									
								} else {
										flag = false; 
								}
							}
							if (entryvalue == "/"){
								if ((columnvalue != "")&&(columnvalue != null)){
										flag = true;
								} else {
											flag = false; 
								}
							}
							if (entryvalue == "*"){
										flag = true;
							}
					}		
					if (action == "discard"){
			
							if (entryvalue == "-"){
								
								if ((columnvalue == "")||(columnvalue == null)){
										flag = false;
								} 
								else {
										flag = true; 
								}
							}
							if (entryvalue == "/"){
								if ((columnvalue != "")&&(columnvalue != null)){
										flag = false;
								} else {
											flag = true; 
								}
							}
							if (entryvalue == "*"){
										flag = false;
							}
					}		
							
						return flag;
		}
	}
}