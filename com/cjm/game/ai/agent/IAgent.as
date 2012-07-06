package cjm.game.ai.agent 
{
	import cjm.game.ai.pathfinding.IPath;
	import cjm.game.core.IGameMovingEntity;
	import cjm.game.core.IGameWorld;
	import cjm.patterns.behavioral.state.IStateMachine;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IAgent extends IGameMovingEntity, IStateMachine 
	{
		public function get onSetAwarenessRadius:ISignal;
		public function setAwarenessRadius(ar:uint):Boolean;
		public function getAwarenessRadius():uint;
		
		public function get onSetNavPath:ISignal;
		public function setNavPath(ar:IPath):Boolean;
		public function getNavPath():IPath;
		
		public function get onSetLife:ISignal;
		public function setLife(ar:uint):Boolean;
		public function getLife():uint;
		
		public function get onDie:ISignal;
		public function die(ar:uint):Boolean;
	}
	
}