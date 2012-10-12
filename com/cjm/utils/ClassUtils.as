package com.cjm.utils 
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class ClassUtils 
	{

		//--------------------------------------
		//   Static Function 
		//--------------------------------------

		static public  function createInstance(type:Class, params:Array):* 
		{
			if(type == null)
			{
				return null;
			}
			
			if (!params)
			{
				return new type();
			}
			
			switch (params.length)
			{
				case 0:
					return new type();
				case 1:
					return new type(params[0]);
				case 2:
					return new type(params[0], params[1]);
				case 3:
					return new type(params[0], params[1], params[2]);
				case 4:
					return new type(params[0], params[1], params[2], params[3]);
				case 5:
					return new type(params[0], params[1], params[2], params[3], params[4]);
				case 6:
					return new type(params[0], params[1], params[2], params[3], params[4], params[5]);
				case 7:
					return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
				case 8:
					return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
				case 9:
					return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
				case 10:
					return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8], params[9]);
			}
			return null;
		}
		
		static public function getType(obj:Object, property:String):Class
		{
			return getDefinitionByName( describeType(obj).accessor.(@name == property).@type ) as Class;
		}

		public static function createInstanceFromInstance(instance:Object, args:Array = null):Object 
		{
			return ClassUtils.createInstance(getDefinitionByName(getQualifiedClassName(instance)) as Class, args);
		}
	}
}
