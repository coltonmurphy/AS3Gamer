package cjm.game.ai.agent.state 
{
	import cjm.game.ai.behaviours.Behavior;
	import cjm.patterns.behavioral.state.IState;
	import cjm.patterns.behavioral.state.State;
	
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
		
		/* INTERFACE cjm.patterns.behavioral.state.IState */
		
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