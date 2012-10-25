package com.cjm.game.ai.agent.goal 
{
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGoalComposite extends IGoal
	{
		function addSubGoal(goal:IGoal):void
		function processSubGoals():void;
		function removeAllSubGoals():void; 
	}
	
}