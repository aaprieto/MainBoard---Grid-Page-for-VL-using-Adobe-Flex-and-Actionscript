package components  
	{     import mx.controls.DataGrid;     
			import mx.controls.Alert;
				import flash.display.Sprite;     
				import flash.display.Shape;     
				import mx.core.FlexShape;     
				import flash.display.Graphics;     
				import mx.controls.listClasses.ListBaseContentHolder;     
			public class DatagridBackground extends DataGrid     {         
				public function DatagridBackground()         {             
					super();         
					}         
					override protected function drawRowBackground(s:Sprite, rowIndex:int,
					y:Number, height:Number, color:uint, dataIndex:int):void         
						{             
							var contentHolder:ListBaseContentHolder = ListBaseContentHolder(s.parent);              
							var background:Shape;            
							
							if (rowIndex < s.numChildren)             
							{                 
								background = Shape(s.getChildAt(rowIndex));             
							}             
							else             
							{                 
							background = new FlexShape();
                background.name = "background";
                s.addChild(background);
            }

            background.y = y;

            // Height is usually as tall is the items in the row, but not if
            // it would extend below the bottom of listContent
            var height:Number = Math.min(height,
                                         contentHolder.height -
                                         y);

            var g:Graphics = background.graphics;
            g.clear();
			
            var color2:uint;
          //  Alert.show(color.toString());
            if(dataIndex<this.dataProvider.length)
            {
				           
                //if(this.dataProvider.getItemAt(dataIndex).color != "2000")
              	if(this.dataProvider.getItemAt(dataIndex).filter_seq != "2000")
              	// if(this.dataProvider.getItemAt(dataIndex).color)
                {
                   //color2 = this.dataProvider.getItemAt(dataIndex).color;
                   //color2 = 0xff1122;
                   color2 = 0x6633CC;
                }
                else
                {
                    color2 = color;
                }
            }
            else
            {
                color2 = color;
            }
            g.beginFill(color2, getStyle("backgroundAlpha"));
            g.drawRect(0, 0, contentHolder.width, height);
            g.endFill();
        }
    }
}