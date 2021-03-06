package com.cjm.game.ai.behaviors.steering 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.math.geom.Geometry2D;
	import com.cjm.utils.math.Vector2D;

	internal class ObstacleAvoidance extends Behavior
	{
		protected const _minDetectBoxLength:Number = 10;
		protected const _breakingWeight:Number     = 0.2;
		
		//Distance to CIB
		protected const _distToClosestIP:Number = Number.MAX_VALUE;
		
		//Closest found this update
		//Keep track of closest obstacle
		protected const _closetObstacle:IGameEntity;
		
		//Record local position
		protected const _localPosOfClosestObj:Vector2D;
		protected const _obstacles:Vector.<IGameEntity>;
		
		override public function start( ...params ) :Vector2D
		{
			_obstacles = params[0] as Vector.<IGameEntity>;
		}
		
		override public function calculate( multiplierModifier:Number = 1 ) :Vector2D
		{
			//Create Detection Box
			var detectBoxLength = ( _minDetectBoxLength + _owner.getSpeed() ) / ( _owner.getMaxSpeed() + _minDetectBoxLength );
			
			//Tag all close range obstacles
			_owner.getWorld().tagObstaclesWithinViewRange( _owner, detectBoxLength );

			var curbObj:IGameEntity;
			
			while ( curbObj = obstacles.pop() )
			{
				if ( curbObj.isTagged() )
				{
					//Local position
					var localPos:Vector2D = Geometry2D.pointToLocalSpace( curbObj.getPosition(), _owner.getHeading(), _owner.getSide(), _owner.getPosition());
			
					//If the local position has a negative x calue then it must lay behind th agent
					if ( localPos.x >= 0 )
					{
						//If the distance from the x axis to the objects position is less than its radius plus half the width of the detection box then there is a potential intersection
						var expandedRadius:Number = curbObj.getRadius() + _owner.getRadius();
						
						if (Math.abs(localPos.y) < expandedRadius)
						{
							//Now to do a line/circle intersection test. The center of the circle is represeted by cX,cY.
							//The intersections points are given b the formula x = cX =?-sqrt(r^2-cY^2) for y=0.
							//We only need t look at the smallest positive value of x because that will be th closest poi
							var cX:Number = localPos.x;
							var cY:Number = localPos.y;
							var xZ:Number = localPos.z;//TODO: add to formula for 3d versionings
							
							//Lets square the proper parts of formula
							var sqprts:Number = Math.sqrt((expandedRadius * expandedRadius) - (cY * cY));
							var ip:Number = cX - sqprts;
							
							if ( ip <= 0)
							{
								ip = cX + sqprts;
							}
							
							//Test to see if closest so far
							if ( ip < _distToClosestIP )
							{
								_distToClosestIP = ip;
								_closetObstacle = curbObj;
								_localPosOfClosestObj = localPos;
							}
						}
					}
				}
			}	
			
			if ( _closetObstacle)
			{
				//The closer the entity, the stronger the force
				//Multiplier
				var mult:Number 1 + ( detectBoxLength - _localPosOfClosestObj.x ) / detectBoxLength;
				
				
				//Calculate the lateral force
				_steeringForce.y = ( _closetObstacle.getRadius() - _localPosOfClosestObj().y ) * mult;
				_steeringForce.x = ( _closetObstacle.getRadius() - _localPosOfClosestObj().x ) * _breakingWeight;
			}
			
			//Steering force updated
			_steeringForce = Geometry2D.pointToGlobalSpace(_steeringForce, _owner.getHeading(), _owner.getSide() )
			
			return super.calculate( multiplierModifier );
		}
	}
}