package com.cjm.game.ai.agent 
{
	import com.cjm.game.core.GameSystem;
	import com.cjm.game.core.IGameWorld;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class AgentSystem extends GameSystem 
	{
		protected var _agents:Vector.<IAgent>;
		
		public function AgentSystem(world:IGameWorld) 
		{
			super(world);
			
		}
		
		override public function initialize():void
		{
			
		}
		
	}

}