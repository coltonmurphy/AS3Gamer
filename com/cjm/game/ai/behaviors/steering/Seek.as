package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameEntity;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class Seek extends Behavior 
	{
		protected var _gameEntity:IGameEntity;
	
		override public function enter( ...params ) :Boolean
		{
			super.enter(params);
			
			_gameEntity  = params[0] as IGameEntity;
			
			return  null != _gameEntity;
		}
		
		override public function exit( ...params ) :Boolean
		{
			super.exit(params);
			
			_gameEntity  = params[0] as Vector3D;
			
			return  null != _gameEntity;
		}
		
		override public function execute( ...params ) :Boolean
		{
			super.execute(params);
			
			var desiredVelocity = _gameEntity.getDistance(_owner.getPosition()).normalize() * _owner.getMaxSpeed();
			_owner.getVelocity().scaleBy( desiredVelocity );
			
			return true;
		}
		
	}

}