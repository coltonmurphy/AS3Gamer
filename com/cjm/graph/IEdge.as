package com.cjm.graph 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IEdge 
	{
		public function setFrom(f:int):void

		public function getFrom():int

		public function setTo(f:int):void

		public function getTo():int

		public function setCost(c:Number):void

		public function getCost():Number
		
		public function equals( e:GraphEdge ):Boolean	
	}
}