package cjm.patterns.structural.composite  
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import cjm.patterns.structural.core.AbstractComponent;
	import cjm.patterns.Abstract;
	import cjm.core.IDestroy;
	import cjm.core.IComposite;
	
	public class AbstractComposite extends AbstractComponent 
	{
	
		protected var _children:Vector.<AbstractComponent>;
		
		public function AbstractComposite(id:String) 
		{
			super( id );	
		}

		public function add( c:AbstractComposite ):Boolean
		{
			throw new Error("AbstractComposite must override create() method");
		}
		
		public function remove( c:AbstractComposite ):Boolean
		{
			throw new Error("AbstractComposite must override remove() method");
		}

		public function get children():Vector.<AbstractComponent> 
		{
			throw new Error("AbstractComposite must override get children method");
		}
		
		public function set children(value:Vector.<AbstractComponent>):void 
		{
			throw new Error("AbstractComposite must override set children method");
		}
	}

}