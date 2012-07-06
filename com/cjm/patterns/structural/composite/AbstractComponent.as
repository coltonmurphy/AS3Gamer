package cjm.patterns.structural.composite 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import cjm.core.IDestroy;
	import cjm.core.IComposite;
	import cjm.patterns.Abstract;
	import cjm.patterns.structural.composite;
	import cjm.core.IEntity;
	import appkit.responders.NResponder;
	
	public class AbstractComponent extends Abstract 
	{
		protected var _parent:IComposite;
		
		public function AbstractComponent(p:AbstractComposite = null ) 
		{
			_parent = p;
		}
		
		public function get parent():IComposite 
		{
			throw new Error("AbstractComponent must override get parent() method");
		}

		override public function destroy():void 
		{
			throw new Error("AbstractComponent must override destroy() method");
		}
		
	}

}