package  com.cjm.core
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Entity 
	{
		protected var _type:String;
		protected var _name:String;
		protected var _id:uint;
	
		
		public function Entity( type:String='Entity', id:uint=0, name:String='' ) 
		{
			_type = type;
			_id   = id;
			_name = name == '' ? _type.concat(_id.toString()) : name;
		}
		
		public function getName():String
		{
			return _name;
		}
		
		public function getType():String
		{
			return _type;
		}
		
		public function getID():uint
		{
			return _id;
		}
	}

}