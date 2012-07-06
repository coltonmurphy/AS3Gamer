package com.cjm.game.ai.agent.state 
{
	import com.cjm.game.ai.behaviours.Behavior;
	import com.cjm.patterns.behavioral.state.IState;
	import com.cjm.patterns.behavioral.state.State;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class AgentState implements IState,  
	{
		
		public function AgentState(state:String) 
		{
			super(state);
			
		}
		
		/* INTERFACE com.cjm.patterns.behavioral.state.IState */
		
		public function enter(...params):Boolean 
		{
			
		}
		
		public function execute(...params):Boolean 
		{
			
		}
		
		public function exit(...params):Boolean 
		{
			
		}
		
		public function update(...params):Boolean 
		{
			
		}
		
	}

}