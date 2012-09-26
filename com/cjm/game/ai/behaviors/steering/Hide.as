package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.math.geom.Vector2D;
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
		
		override public function start( ...params ) :void
		{
			super.start();
			
			_obstacles  = params[0] as Vector.<IGameEntity>;
		    _target  = params[1] as IGameEntity;
		}
		
		override public function calculate( multiplierModifier:Number = 1 ) :Vector2D
		{
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
				_steeringForce = (new Evade(_owner, true, _target)).getSteeringForce();
			}
			else
			{
				_steeringForce = (new Arrive(_owner, true, bestHidingSpot, 2)).getSteeringForce();
			}
			
			return super.calculate( multiplierModifier );
		}
		
		private function getHidingPosition( position:Vector2D, radius:Number, target:Vector2D):Vector2D
		{
			//Distance away from obstacle
			var distAway:Number = radius + _distance;
			
			//Calculate the heading toward target
			var heading:Vector2D = position.subtract( target ).normalize();
			
			//Scale it and add the obstacle's position to get hiding spot
			return position.add( heading.scaleBy( distAway ) ) 
		}
		
	}

}