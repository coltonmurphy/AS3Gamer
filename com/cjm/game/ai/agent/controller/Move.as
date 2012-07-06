package cjm.game.ai.agent.controller 
{
	import cjm.patterns.behavioral.command.Command;
	import cjm.patterns.behavioral.command.ICommand;
	import cjm.patterns.behavioral.observer.INotification;
	import cjm.patterns.structural.core.IContext;
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Move extends Command implements ICommand 
	{
		private var _to:Vector3D;//Usually pointing to agent.location
		private var _from:Vector3D;
		
		override public function execute(c:IContext, n:INotification):void 
		{
			super.execute(c, n);

			_from = n.getBody().from as Vector3D;
			_to = n.getBody().to as Vector3D;
			//TODO:Define 'to' and 'from', so undo can use info retained in 'execute' to and from
		}
		override public function undo():void 
		{
			super.undo(c, n);
			var temp = _from;
			_from = _to;
			_to = temp;
		}
		
		override public function destroy():void 
		{
			super.undo()
			
			_to   = null;
			_from = null
		}
	}

}