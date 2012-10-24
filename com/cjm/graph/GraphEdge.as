package com.cjm.game.graph 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GraphEdge 
	{
		protected var _from:int//node index of from node
		protected var _to:int//node index of from node
		protected var _cost:Number//node index of from node
		public function GraphEdge( from:int, to:int, cost:Number = 0) 
		{
			_from = from; _to = to; _cost = cost;
		}
		
		public function setFrom(f:int):void
		{
			_from = f;
		}
		
		public function getFrom():int
		{
			return _from;
		}
		
		public function setTo(f:int):void
		{
			_to = f;
		}
		
		public function getTo():int
		{
			return _to;
		}
		
		public function setCost(c:Number):void
		{
			_cost = c;
		}
		
		public function getCost():Number
		{
			return _cost;
		}
		
		public function equals( e:GraphEdge ):Boolean
		{
			return e.getFrom() == getFrom() && 
				   e.getTo() == getTo() && 
				   e.getCost() == getCost());
		}
		
	}

}