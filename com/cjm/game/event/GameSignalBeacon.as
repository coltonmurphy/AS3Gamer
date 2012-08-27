package com.cjm.game.event 
{
	import com.cjm.game.core.IGameEntity;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameSignalBeacon 
	{
		
		private static var _instance:GameSignalBeacon = null;
		protected static var type:Class = null;
		
		private static var types:Dictionary = new Dictionary;
		private static var pipe:IGameSignal = new GameSignal(IGameEntity, IGameSignal);
		
		public function GameSignalBeacon( t:Class ) 
		{
			_type = t
		}
		
		public static function getInstance( type:Class ):GameSignalBeacon
		{
			return _instance || _instance = new GameSignalBeacon( type );
		}
		
		public static function dispatch( scope:IGameEntity, signal:IGameSignal, ...params  ):void
		{
			signal.dispatch( params );//Add to local scope
			
			pipe.dispatch( scope, signal  );
		}
		
		public static function add( scope:IGameEntity, signal:IGameSignal, func:Function ):void
		{
			signal.add( func );//Add to local scope

			types[scope][ signal ] = onSignal;
			
			pipe[]
			
			signal.add( types[scope][ signal ] );
			
		}
		
		private static function onSignal(...params):void 
		{
			pipe.dispatch
		}
		
		
		
	
	}

}