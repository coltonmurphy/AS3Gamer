package cjm.game.ai.core 
{
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IMove 
	{
		public function get onMoveTo( ):ISignal
		public function moveTo( v:Vector3D ):Boolean
	}
	
}