package com.cjm.graph 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IEdge 
	{
		function setFrom(f:int):void

		function getFrom():int

		function setTo(f:int):void

		function getTo():int

		function setCost(c:Number):void

		function getCost():Number
		
		function equals( e:GraphEdge ):Boolean	
	}
}