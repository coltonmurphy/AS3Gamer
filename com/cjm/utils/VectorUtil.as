package com.cjm.utils 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class VectorUtil 
	{
		public static function assign(vec:*, char:* = "0"):*
		{
			if (vec["fixed"] != null && vec["length"] != null)
			{
				var diff:Number = vec.length;
				for (var i:int = 0; i < diff; i++)
				{
					vec[i] = char;
				}
			}
			return vec;
			
		}
	}

}