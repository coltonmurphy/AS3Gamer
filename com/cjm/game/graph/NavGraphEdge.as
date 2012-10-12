package com.cjm.game.graph 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class NavGraphEdge extends GraphEdge
	{
		
		public static const NORMAL:int  = 0;
		public static const SWIM:int    = 1;
		public static const CRAWL:int   = 2;
		public static const CREEP:int   = 3;
		public static const JUMP:int    = 4;
		public static const FLY:int     = 5;
		public static const GRAPPLE:int = 6;
		public static const DOOR:int    = 7;
		
		private var _flag:int;
		private var _idOfIntersectEntity:int;
		
		public function NavGraphEdge( from:int, to:int, cost:Number = 0, flag:int = NavGraphEdge.NORMAL, idOfIntersectEntity:int = -1) 
		{
			super( from, to, cost );
			
			_flag = flag;
			_idOfIntersectEntity = idOfIntersectEntity;
		}
		
		public function setFlag(f:int):void
		{
			_flag = f;
		}
		
		public function getFlag():int
		{
			return _flag;
		}
		
		public function setIDOfIntersectEntity(f:int):void
		{
			_idOfIntersectEntity = f;
		}
		
		public function getIDOfIntersectEntity():int
		{
			return _idOfIntersectEntity;
		}
	}
}