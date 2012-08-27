package com.cjm.game.trigger 
{
	import com.cjm.game.core.IGameEntity;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class CircleTriggerRegion implements ITriggerRegion 
	{
		//center of region
		protected var _position:Vector3D;
		protected var _radius:Number;
		
		public function CircleTriggerRegion( position:Vector3D, radius:Number ) 
		{
			_position = position;
			_radius = radius;
		}
		
		/* INTERFACE com.cjm.game.trigger.ITriggerRegion */
		
		public function isTouching(e:IGameEntity, radius:Number):Boolean 
		{
			var dist = e.getDistance(_position);
			var disSq = dist * dist;
			var radSq = (( radius + _radius ) * ( radius + _radius ));
			
			return  disSq < radSq;
		}
		
	}

}