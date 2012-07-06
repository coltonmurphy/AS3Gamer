package cjm.game.ai.agent.state 
{
	import cjm.game.ai.agent.Agent;
	import cjm.patterns.behavioral.state.IState;
	import cjm.patterns.behavioral.state.IStateMachine;
	import cjm.patterns.structural.core.IContext;
	import org.osflash.signals.ISignal;
	new IContext
	new INo
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class AgentStateMachine implements IStateMachine, IComposite
	{
		private var _agents:Vector.<Agent>;
		
		public function AgentStateMachine(k:Key) 
		{
			_agents = new Vector.<Agent>;
		}
		
		/* INTERFACE cjm.patterns.behavioral.state.IStateMachine */
		public static function getInstance():IStateMachine
		{
			return _instance || _instance = new AgentStateMachine(new Key());
		}
		
		public static function add( i:*):IStateMachine
		{
			
			switch(i.constructor)
			{
				case Agent:
					_agents.push(i);
					break
				case AgentState:
					for each( a:Agent in _agents)
					{
						Agent(a).add( AgentState(i) );
					}
					break
			}
		}
		
		public function set onChangeState(value:ISignal):void 
		{
			_onChangeState = value;
		}
		
		public function changeState(from:IState, to:IState, ...params):Boolean 
		{
			
			_onChangeState.dispatch(from, to);
		}
		
		public function get onEnterState():ISignal 
		{
			return _onEnterState;
		}
		
		public function get onExitState():ISignal 
		{
			return _onExitState;
		}
		
		public function enter(...params):Boolean 
		{
			
		}
		
		public function exit(...params):Boolean 
		{
			
		}
		
		public function getState():IState 
		{
			
		}
		
		protected function execute(c:IContext, n:INotification):void 
		{
			
		}
		
	}
	
	private class Key{}

}