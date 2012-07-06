package cjm.patterns.structural.composite  
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import appkit.responders.NResponder;
	import cjm.core.IDestroy;
	import cjm.patterns.structural.core.AbstractComponent;
	import cjm.patterns.Abstract;
	import cjm.events.EventTypes;
	
	public class ConcreteComposite extends AbstractComposite
	{
	
	
		public function ConcreteComposite( id:String ) 
		{
			super( id );
			
			_children = new Vector.<AbstractComponent>
		}
		
		override public function getID():String
		{
			return super._id;
		}	
		
		override public function setID(id:String):void
		{
			super._id; = id;
			
			NResponder.dispatch(EventTypes.CHANGE_ID,[id]);
		}
		
		override public function add( c:AbstractComponent ):Boolean
		{
			if (!_children.contains(c))
				NResponder.dispatch(EventTypes.ADD, [c, true])
				return (Boolean(_children.push(c) >= 0);
				
			return false;
		}
		
		override public function remove( c:AbstractComponent ):Boolean
		{
			if (!_children.contains(c))
				NResponder.dispatch(EventTypes.REMOVE, [c, true]);
				return (Boolean(_children.splice(_children.indexOf(c), 1).length >= 0);
				
			return false;
		}
		
		override public function destroy():void
		{
			for ( i:IDestroy in _children )
				  i.destroy()
				  i = null;
				 
			_children = null;
			
			NResponder.dispatch(EventTypes.DESTROY);
		}
		
		override public function get children():Vector.<AbstractComponent> 
		{
			return _children;
		}
		
		override public function set children(value:Vector.<AbstractComponent>):void 
		{
			for( child:AbstractComponent in value)
				 add(child)
		}
	}

}