package com.cjm.game.ai.agent.goal 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GoalComposite extends Goal implements IGoalComposite 
	{
		protected var _goals:Vector.<IGoal>;
		
		public function GoalComposite() 
		{
			super();
			
		}
		
		/* INTERFACE com.cjm.game.ai.agent.goal.IGoalComposite */
		override public function activate():void 
		{
			
		}
		
		override public function process():void 
		{
			
		}
		
		override public function terminate():void 
		{
			
		}
		
		public function processSubGoals():void 
		{
			
		}
		
		public function removeAllSubGoals():void 
		{
			
		}
		
		public function addSubGoal(goal:IGoal):void 
		{
			
		}
	}
}