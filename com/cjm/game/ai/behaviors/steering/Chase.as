package cjm.game.ai.behaviors.steering 
{
	import cjm.game.ai.behaviors.Behavior;
	import cjm.patterns.behavioral.observer.INotification;
	import cjm.patterns.behavioral.state.IState;
	import cjm.patterns.structural.core.IContext;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Chase extends Behavior implements IState 
	{
		
		public function Chase(state:String) 
		{
			super(state);
			
		}
		
		/* INTERFACE cjm.patterns.behavioral.state.IState */
		//Calling supers for signal sending
		public function enter(...params):Boolean 
		{
			super.enter(params);
		}
		
		public function exit(...params):Boolean 
		{
			super.exit(params);
		}

		public function execute(c:IContext, n:INotification):void 
		{
			super.execute(params);
		}
		
		public function undo():void 
		{
			super.undo(params);
		}
	
		public function destroy():void 
		{
			super.destroy(params);
		}
		
	}

}