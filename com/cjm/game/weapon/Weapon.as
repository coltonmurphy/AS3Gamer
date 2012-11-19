package com.cjm.game.weapon
{
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.core.IUpdate;
	import com.cjm.math.geom.Vector2D;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Weapon implements IUpdate
	{
		private var _owner:IAgent;
		private var _type:uint;
		private var _defaultNumRounds:uint;
		private var _maxRoundsCarried:uint;
		private var _rateOfFire:uint;
		private var _idealRange:uint;
		private var _projectileSpeed:uint;
		
		public function Weapon( ownerOfGun:IAgent, 
								typeOfGun:uint, 
								defaultNumRounds:uint,
                                maxRoundsCarried:uint,
                                rateOfFire:Number,
                                idealRange:Number,
                                projectileSpeed:Number) 
		{
			_owner            = ownerOfGun;
			_type             = typeOfGun;
			_defaultNumRounds = defaultNumRounds;
			_maxRoundsCarried = maxRoundsCarried
			_rateOfFire       = rateOfFire;
			_idealRange       = idealRange;
			_projectileSpeed  = projectileSpeed;
		}
		
		
		public function aimAt( location:Vector2D ):Boolean
		{
			return _owner.rotateFacingTowardPosition( location );
		}
	}

}