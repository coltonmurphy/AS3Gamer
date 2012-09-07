package com.cjm.game.ai.agent.goal 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Goal implements IGoal 
	{

		protected var _type:String;
		protected var _active:Boolean;
		protected var _completed:Boolean;
		protected var _failed:Boolean;
		
		public function Goal() 
		{
			
		}
		
		/* INTERFACE com.cjm.game.ai.agent.goal.IGoal */
		
		public function activate():void 
		{
			
		}
		
		public function process():void 
		{
			
		}
		
		public function terminate():void 
		{
			
		}

		public function isActive():Boolean 
		{
			return _active;
		}
		
		public function isCompleted():Boolean 
		{
			return _completed;
		}
		
		public function hasFailed():Boolean 
		{
			return _failed;
		}
		
		public function getType():String 
		{
			return _type;
		}
		
	}

}