package com.cjm.game.ai.behaviors.steering
{
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.utils.math.MathUtil;
	import com.cjm.utils.math.Vector2D;

	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Wander extends Behavior implements IBehavior
	{
		public static var DEFAULT_RADIUS:Number   = 10;
		public static var DEFAULT_DISTANCE:Number = 5;
		public static var DEFAULT_JITTER:Number   = 1;
		
		private var _radius:Number;
		private var _distance:Number;
		private var _jitter:Number;
		
		private var _target:Vector2D;
		
		/*Constructor method parameters are optional
		  radius   = DEFAULT_RADIUS;
		  distance = DEFAULT_DISTANCE; 
		  jitter   = DEFAULT_JITTER; */
		  
		public function Wander( owner:IGameMovingEntity, 
								autoRun:Boolean = false,
								radius:Number = DEFAULT_RADIUS, 
								distance:Number = DEFAULT_DISTANCE, 
								jitter:Number=DEFAULT_JITTER ) 
		{	_radius   = radius;
			_distance = distance; 
			_jitter   = jitter; 
			
			super(owner, autoRun, radius, distance, jitter)
		}
		
		/*Enter method parameters are optional
		  radius   = DEFAULT_RADIUS;
		  distance = DEFAULT_DISTANCE; 
		  jitter   = DEFAULT_JITTER; */
		override public function start(...params):void 
		{
			super.start();
			
			_target = new Vector2D();
			
			//NOTE: Control variable assignment// Taking advantage of reverse index stack evaluation by not using break statements
			switch( params.length )
			{
				case 3:_jitter   = params[2] as Number;
				case 2:_distance = params[1] as Number;
				case 1:_radius   = params[0] as Number;
			}
		}
		
		override public function calculate( multiplierModifier:Number = 1 ):Vector2D 
		{
			//add small random vector to the targets position
			_target.add(new Vector2D( MathUtil.randomClamped() * _jitter, MathUtil.randomClamped() * _jitter));
			
			//project onto a unit circle
			_target.normalize(1);
			
			//increase the length of the vector to the same as the radius of the circle
			_target.normalize( _radius );
			
			//Update distance from agent
			var targetLocal:Vector2D = _target.add( new Vector2D(_distance));
			
			var targetWorld:Vector2D = _owner.getWorld().pointToWorldSpace( targetLocal, 
																				_owner.getHeading(), 
																				_owner.getSide(), 
																				_owner.getPosition());
																				
			_steeringForce = targetWorld.subtract(_owner.getPosition());
			
			return super.calculate( multiplierModifier );
		}
		
	}

}