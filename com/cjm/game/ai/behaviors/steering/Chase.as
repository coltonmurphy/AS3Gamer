package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.patterns.behavioral.observer.INotification;
	import com.cjm.patterns.behavioral.state.IState;
	import com.cjm.patterns.structural.core.IContext;
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
		
		/* INTERFACE com.cjm.patterns.behavioral.state.IState */
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