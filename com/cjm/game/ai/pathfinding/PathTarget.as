
package com.cjm.game.ai.pathfinding
{
	public class PathTarget
	{

		public static const TYPE_ITEM:int = 1;
		public static const TYPE_POSITION:int = 0;
		public static const TYPE_INVALID:int = -1;
		
		private var _targetItemType:int
		private var _targetPosition:Vector2D;
		private var _type:int;


		public function setTargetAsItem( itemType:int ):void
		{
		   _targetItemType = itemType;
		   _type = TYPE_ITEM;
		}
		
		public function setTargetAsPosition( p:Vector2D)
		{
			_targetPosition = p;
			_type = TYPE_POSITION;
		};

		public function isTargetAnItem()Boolean
		{
			return _type == TYPE_ITEM;
		}
		
		public function isTargetAPosition()Boolean
		{
			return _type == TYPE_POSITION;
		}
		
		public function isTargetValid():Boolean
		{
			return !(_type == TYPE_INVALID);
		}

		public function  getTargetPosition():Vector2D
		{
			return _targetPosition;
		};
	   
		public function  getTargetType():int
		{
		   return type;
		};
	};
}
