package com.cjm.patterns.structural.composite 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import com.cjm.core.IDestroy;
	import com.cjm.core.IComposite;
	import com.cjm.patterns.Abstract;
	import com.cjm.patterns.structural.composite;
	import com.cjm.core.IEntity;
	import appkit.responders.NResponder;
	
	public class ConcreteComponent extends AbstractComponent 
	{

		public function ConcreteComponent(p:AbstractComposite = null ) 
		{
			super(p);
		}
		
		override public function set parent(p:IComposite):void 
		{
			NResponder.dispatch(EventTypes.CHANGE_PARENT, [p]);
			super._parent = p
		}
		
		override public function get parent():IComposite 
		{
			return super._parent;
		}

		override public function destroy():void 
		{
			super._parent = null;
		}
		
	}

}