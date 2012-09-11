package com.cjm.core
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
		public function destroy():void
		public function getName( ):String;
		public function setName( n:String );

		public function enter(...params ):Boolean;
		public function execute( ...params ):Boolean;
		public function exit( ...params ):Boolean;
		public function changeState( toState:IState ):void;
		public function getStateMachine():IStateMachine;
	}
	
}