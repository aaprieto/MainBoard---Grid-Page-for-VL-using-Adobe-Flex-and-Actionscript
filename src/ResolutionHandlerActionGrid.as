// ActionScript file
public function detectScreenResolutionforActionGrid():void{
	
 	if ((flash.system.Capabilities.screenResolutionX < 1680) && (flash.system.Capabilities.screenResolutionY < 1050)){
 		
 		
 		dg.styleName				="lowResolutionSize";
 		
 		
 		/*
 		namedescription.styleName		="{'lowResolutionLabel'}";
 		time_ctr.styleName				="{'lowResolutionLabel'}";
 		autorefresh_ctr.styleName		="{'lowResolutionLabel'}";
 		applicationlabel.styleName		="{'lowResolutionLabel'}";
 		compcode.styleName				="{'lowResolutionLabel'}";
 		btn_help.styleName				="{'lowResolutionLabel'}";
 		*/
 	}
}