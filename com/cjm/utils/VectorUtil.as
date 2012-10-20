package com.cjm.utils 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class VectorUtil 
	{
		public static function assign(vec:Vector.<*>, size:Number, char:* = "0"):Vector.<*>
		{
			var diff:Number = size - vec.length;
			for (var i:int = 0; i < diff; i++)
			{
				vec.push(char);
			}
			return vec;
		}
	}

}