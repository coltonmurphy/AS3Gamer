package com.cjm.game.trigger 
{
	import com.cjm.game.core.IGameEntity;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class RectangleTriggerRegion implements ITriggerRegion 
	{
		protected var _topLeftPos:Vector3D;
		protected var _btmRightPos:Vector3D;
		
		public function RectangleTriggerRegion( tlp:Vector3D, btmp:Vector3D ) 
		{
			_topLeftPos  = tlp;
			_btmRightPos = btm
		}
		
		/* INTERFACE com.cjm.game.trigger.ITriggerRegion */
		
		public function isTouching(e:IGameEntity, radius:Number):Boolean 
		{
			
		}
		
	}

}