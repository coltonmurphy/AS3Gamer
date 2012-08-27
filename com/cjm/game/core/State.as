package com.cjm.game.core 
{
	import com.cjm.game.event.GameSignal;
	import org.osflash.signals.ISignal;
	import com.cjm.game.event.IGameSignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class State implements IState 
	{
		protected var _onDestroy:IGameSignal      = new GameSignal(null);
		protected var _onSetName:IGameSignal      = new GameSignal(String);
		protected var _onEnter:IGameSignal        = new GameSignal(IState);
		protected var _onExecute:IGameSignal      = new GameSignal(IState);
		protected var _onExit:IGameSignal         = new GameSignal(IState);
		protected var _onChangeState:IGameSignal  = new GameSignal(IState);
		
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
		
		public function get onDestroy():ISignal {return _onDestroy;}
		public function destroy():void 
		{
			_onDestroy.dispatch();
		}
		
		public function get onSetName():IGameSignal {return _onSetName;}
		public function getName():String {return _name;}
		public function setName(n:String) 
		{
			_onSetName.dispatch(n)
		}
		
		/*This is for notification of enter*/
		public function get onEnter():IGameSignal {return _onEnter;}
		public function enter(...params):Boolean 
		{
			_onEnter.dispatch( _instance );
		}
		
		public function get onExecute():IGameSignal {return _onExecute;}
		public function execute(...params):Boolean 
		{
			_onExecute.dispatch( _instance );
		}
		
		public function get onExit():IGameSignal {return _onExit;}
		public function exit(...params):Boolean 
		{
			_onExit.dispatch( _instance );
		}
		
		public function get onChangeState():IGameSignal {return _onChangeState;}
		public function changeState(toState:IState):void 
		{
			_onChangeState.dispatch( toState );
		}

		public function get onUpdate():ISignal {return _onUpdate;}
		public function update(...params):Boolean 
		{
			_onUpdate.dispatch(this)
		}
		
	}
}