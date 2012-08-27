package com.cjm.game.core
{
	
	import com.cjm.game.core.IName;
	import com.cjm.game.core.IUpdate;
	import com.cjm.game.core.IDestroy;
	import com.cjm.game.event.IGameSignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IState extends IUpdate implements IName, IDestroy
	{
		public function getInstance():IState
		
		public function get onDestroy:IGameSignal;
		public function destroy():void
		
		public function get onSetName : IGameSignal;
		public function getName( ):String;
		public function setName( n:String );
		
		public function get onEnter:IGameSignal;//Force signal member
		public function enter(...params ):Boolean;
		
		public function get onExecute:IGameSignal;
		public function execute( ...params ):Boolean;
		
		public function get onExit:IGameSignal;
		public function exit( ...params ):Boolean;
		
		public function get onChangeState:IGameSignal;
		public function changeState( toState:IState ):void;
		public function getStateMachine():IStateMachine;
	}
	
}