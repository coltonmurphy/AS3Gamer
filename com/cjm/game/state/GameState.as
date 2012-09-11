package com.cjm.game.state 
{
	import com.cjm.core.IState;
	import com.cjm.game.core.GameError;

	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameState implements IState 
	{

		protected var _changeStateSignal:IGameSignal  = new GameSignal(IState);
		protected var _updateSignal:IGameSignal       = new GameSignal(Number);
		
		protected var _name:String                = null;
		private static var _instance:IState       = null;
	
		
		public function State( name:String = 'State' ) 
		{
			setName( name )
		}
		
		/* INTERFACE com.cjm.game.core.IState */
		public static function getInstance( name:String ):IState
		{
			return _instance || _instance = new State( name );
		}

		public function destroy():void 
		{
			throw new GameError("Must override destroy method of "+_name+" GameState.")
		}

		public function getName():String {return _name;}
		public function setName(n:String) 
		{
			_name = n;
		}
		
		/*This is for notification of enter*/
	
		public function enter(...params):Boolean 
		{
			throw new GameError("Must override enter method of "+_name+" GameState.")
		}
		
	
		public function execute(...params):Boolean 
		{
			throw new GameError("Must override execute method of "+_name+" GameState.")
		}
		
		public function exit(...params):Boolean 
		{
			throw new GameError("Must override exit method of "+_name+" GameState.")
		}
		
		public function get changeStateSignal():IGameSignal {return _onChangeState;}
		public function changeState(toState:IState):void 
		{
			_onChangeState.dispatch( toState );
		}

		public function get updateSignal():ISignal {return _updateSignal;}
		public function update( timeDelta:Number):void 
		{
			_updateSignal.dispatch(this)
		}
		
	}
}