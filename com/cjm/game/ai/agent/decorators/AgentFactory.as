package cjm.game.ai.agent.decorators 
{
	import cjm.game.ai.agent.Agent;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	///Factory Pattern with agent decorators as products
	public final class AgentFactory 
	{
		
		public function AgentFactory() 
		{
			
		}
		
		public static function createHuman( id:String ):Human
		{
			return new Human( new Agent( id ))
		}
	}

}