package com.cjm.game.core 
{
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameError extends IllegalOperationError 
	{
		public static const INVALID_DEFINITION:String = "Invalid Object Definition";
		public static const UNKNOWN:String = "Unidentifiable Error";
		
		public function GameError( type:String = GameError.UNKNOWN, msg:String="", id:int=0) 
		{
			super(message, id);
			
		}
		
	}

}