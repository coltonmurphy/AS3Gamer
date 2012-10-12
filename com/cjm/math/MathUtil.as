package com.cjm.math 
{
	/**
	 * ...
	 * @author ...
	 */
	public class MathUtil 
	{
		
		public function MathUtil() 
		{
			throw new Error("MathUtil cannot be instanciated.");
		}
		
		//Return value between -1 and 1
		public static function randomClamped():omt
		{
			var result:int = (Math.random() * 2) - 1;
		}
		
		public static function random( min:Number = Number.MIN_VALUE, max:Number = Number.MAX_VALUE )
		{
			return min + (Math.random() * (max - min));
		}
		
		public static function clamp(val:Number, min:Number,max:Number):Number
		{
			if (val > max || val < min )
				val = min;
			
			return val;
		}
		
		public static function degreeToRadian(valueDegree:Number):Number
		{
			var valueRadian:Number;
			
			valueRadian = valueDegree * Math.PI / 180;
			
			return valueRadian;
		}
		
		public static function radianToDegree(valueRadian:Number):Number
		{
			var valueDegree:Number;
			
			valueDegree = valueRadian * 180 / Math.PI;
			
			return valueDegree;
		}
		
		public static function getPointDistance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var dx:Number;
			var dy:Number;
			var dist:Number;
			
			dx = x2 - x1;
			dy = y2 - y1;
			
			dist = Math.sqrt(dx * dx + dy * dy);
			
			return dist;
		}
		
		public static function getObjectDistance(object1:Object, object2:Object):Number
		{
			return getPointDistance(object1.x, object1.y, object2.x, object2.y);
		}
		
		public static function getPointAngle(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var dx:Number;
			var dy:Number;
			var angle:Number;
			
			dx = x2 - x1;
			dy = y2 - y1;
			angle = Math.atan2(dy, dx);
			
			return angle;
		}
		
		public static function getObjectAngle(object1:Object, object2:Object):Number
		{
			return getPointAngle(object1.x, object1.y, object2.x, object2.y);
		}
		
		public static function getRotation(valueRadian:Number):Number
		{
			var rotation:Number;
			
			rotation = radianToDegree(valueRadian);
			
			return rotation;
		}
		
		public static function generateRandomSign():int
		{
			var rand:int;
			
			rand = Math.ceil(Math.random() * 2);
			
			if (rand == 1)
			{
				return -1;
			}
			
			return 1;
		}
		
		public static function isElementOfArray(array:Array, object:Object):Boolean
		{
			if (array.indexOf(object) != -1)
			{
				return true;
			}
			
			return false;
		}
		
		public static function getUniqueArray(array:Array, convertTotString:Boolean = false):Array
		{
			var uniqueArray:Array = new Array();
			
			var arrayLength:int = array.length;
			
			for (var i:int = 0; i < arrayLength; i++)
			{
				var found:Boolean = false;
				
				for (var j:int = 0; j < uniqueArray.length; j++)
				{
					if (!convertTotString) 
					{
						if (array[i] == uniqueArray[j])
						{
							found = true;
						}
					}
					else
					{
						if (array[i].toString() == uniqueArray[j].toString())
						{
							found = true;
						}
					}
				}
				
				if (found == false)
				{
					uniqueArray.push(array[i]);
				}
			}
			
			return uniqueArray;
		}
		
		public static function getAdjacent(angleDegree:Number, hypotenuse:Number):Number
		{
			var angleRadian:Number = degreeToRadian(angleDegree);
			
			return Math.cos(angleRadian) * hypotenuse;
		}
		
		public static function getOpposite(angleDegree:Number, hypotenuse:Number):Number
		{
			var angleRadian:Number = degreeToRadian(angleDegree);
			
			return Math.sin(angleRadian) * hypotenuse;
		}
		
	}

}