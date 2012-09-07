package com.cjm.game.ai.agent.goal 
{
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGoalComposite extends IGoal
	{
		public function addSubGoal(goal:IGoal):void
		public function processSubGoals():void;
		public function removeAllSubGoals():void;
	}
	
}