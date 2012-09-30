package com.cjm.game.ai.agent 
{
	import com.cjm.core.Iterator;
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
			//Common pathfinding goals, or weapons system, most likely be in Agent initialize tho
		}
		
		public function getIterator():Iterator
		{
			return new Iterator( _agents as Array );
		}
		
		public function createAgents( amount:int ):Vector<IAgent>
		{
			while (amount--)
			{
				_agents.push( new Agent(amount.toString() );
			}
			return _agents;
		}
	}

}