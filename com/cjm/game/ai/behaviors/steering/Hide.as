package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.utils.math.Vector2D;
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class Hide extends Behavior
	{
		private const _distance:Number = 30;
		private const _target:IGameEntity;
		
		private var _obstacles :Vector.<IGameEntity>;
		
		override public function execute( ...params ) :Boolean
		{
			super.execute(params);
			
			_obstacles  = params[0] as Vector.<IGameEntity>;
		    _target  = params[1] as IGameEntity;
			
			var distToClosest:Number = Number.MAX_VALUE;
			var bestHidingSpot:Vector2D;
	
			for ( var obst:IGameEntity in _obstacles )
			{
				var hidingSpot:Vector3D = getHidingPosition( obst.getPosition(), obst.getRadius(), _target.getPosition());
				var distSq:Number = hidingSpot.subtract( _owner.getPosition()).lengthSquared;
				
				if ( distSq < distToClosest )
				{
					distToClosest = distSq;
					bestHidingSpot = hidingSpot;
				}
			}
			
			//No obstacles
			if ( distToClosest == Number.MAX_VALUE )
			{
				return (new Evade(_owner, true, _target)).getSteeringForce();
			}

			return (new Arrive(_owner, true, bestHidingSpot)).getSteeringForce();
		}
		
		private function getHidingPosition( position:Vector3D, radius:Number, target:Vector3D):Vector3D
		{
			var distAway:Number = radius + _distance;
			
			//Calculate the heading toward target
			var heading = position.subtract( target ).normalize();
			
			//Scale it to size and add to the obstacles position to get hiding spot
			return position.add( heading * distAway ) 
		}
		
	}

}