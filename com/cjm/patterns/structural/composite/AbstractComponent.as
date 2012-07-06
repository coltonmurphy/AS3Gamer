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