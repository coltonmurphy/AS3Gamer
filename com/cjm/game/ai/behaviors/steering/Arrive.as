package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import flash.geom.Vector3D;

	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class Arrive extends Behavior
	{
		protected var _toPosition:Vector3D;
		protected var _time:Number;
		
		override public function enter( ...params ) :Boolean
		{
			super.enter(params);
			
			_toPosition  = params[0] as Vector3D;
			_time        = params[1] as Number; 
			
			return _time && _toPosition;
		}
		
		override public function exit( ...params ) :Boolean
		{
			super.exit(params);
			
			_toPosition  = params[0] as Vector3D;
			_time        = params[1] as Number; 
			
			return _time && _toPosition;
		}
		
		override public function execute( ...params ) :Boolean
		{
			super.execute(params);
			
			
		}
		
	}

}