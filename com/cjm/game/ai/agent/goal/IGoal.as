package com.cjm.game.ai.agent.goal 
{	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGoal 
	{
		public function activate():void;
		public function process():void;
		public function terminate():void;
		public function addSubGoal( goal:IGoal ):void;
		public function isActive():Boolean;
		public function isCompleted():Boolean;
		public function hasFailed():Boolean;
		public function getType():String;
	}
}