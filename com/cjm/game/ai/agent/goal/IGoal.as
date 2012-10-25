package com.cjm.game.ai.agent.goal 
{	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGoal 
	{
		function activate():void;
		function process():void;
		function terminate():void;
		function addSubGoal( goal:IGoal ):void;
		function isActive():Boolean;
		function isCompleted():Boolean;
		function hasFailed():Boolean; 
		function getType():String;
	}
}