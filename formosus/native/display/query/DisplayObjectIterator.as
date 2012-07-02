package formosus.native.display.query 
{
	import formosus.native.display.query.commands.IDisplayObjectCommand;
	import formosus.native.display.query.iterators.IFrameIterator;
	import formosus.specifications.ISpecification;
	import formosus.utils.types.ClassUtils;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	/**
	 * @author Mark
	 */
	internal class DisplayObjectIterator 
	{
		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function DisplayObjectIterator(displayObject:DisplayObject, frameIterator:IFrameIterator, specification:ISpecification, recursive:Boolean, command:Class, commandParams:Array) 
		{
			var instanceCommand:IDisplayObjectCommand;
			
			frameIterator.displayObject = displayObject;
			frameIterator.rewind();
			
			while(frameIterator.next())
			{
				if(displayObject is MovieClip)
				{
					MovieClip( displayObject ).gotoAndStop( uint( frameIterator.current() ) );
					
//					trace( "displayObject.name: " + (displayObject.name));
//					trace( "uint( frameIterator.current() ) : " + (uint( frameIterator.current( ) ) ) );
				}
				
				if(specification && specification.isSatisfiedBy( displayObject ))
				{
					instanceCommand = ClassUtils.createInstance(command, commandParams);
					instanceCommand.displayObject = displayObject;
					instanceCommand.execute();
				}
				
				if(recursive && displayObject is DisplayObjectContainer)
				{
					var container:DisplayObjectContainer = DisplayObjectContainer( displayObject );
					
					//store the length of the array in a variable
					var lenChildren:int = container.numChildren;
					
					//decrease the setted length so we iterate backwords through the array
					while(--lenChildren > -1)
					{
						new DisplayObjectIterator( container.getChildAt( lenChildren ), frameIterator, specification, recursive, command, commandParams );
					}
				}
			}
		}
	}
}
