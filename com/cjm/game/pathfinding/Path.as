package com.cjm.game.pathfinding 
{
	import com.cjm.game.core.IRender;
	import com.cjm.game.signals.GameAction;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public final class Path implements IPath, IRender
	{
		private var _renderSignal:GameAction = new GameAction();
		private var _nodes:Vector.<INode>;
		private var _cursor:int;
		private var _visible:Boolean;
		
		public function Path( sv:Vector.<INode> = null ) 
		{
			setNodes( sv || new Vector.<INode> );
			_cursor = -1;
			_visible = false;
		}
		
		public function render(...payLoad):void
		{
			if ( _visible )
			{
				while ( var node:IRender = next() != end() )
				{
					node.render(payLoad);
				}
				//TODO: Draw line
				
			}
			
			renderSignal.dispatch(payLoad)
		}
		
		public function end():INode
		{
			return _nodes[_nodes.length - 1];
		}
		
		public function front():INode
		{
			return _nodes[0];
		}
		
		public function next():INode
		{
			if ( _cursor++ > length() )
				_cursor = 0;
		   
			return _nodes[_cursor];
		}
		
		public function length():uint
		{
			return _nodes.length;
		}
		
		public function addNode( n:INode ):uint
		{
			var i:uint = _nodes.unshift( n );
			
			return i;
		}
		
		public function getNode( i:uint ):INode
		{
			return _nodes[i] || null;
		}
		
		public function removeNode( n:INode ):uint
		{
			return _nodes.unshift( n )
		}
		
		public function setNodes(sv:Vector.<INode>):Boolean
		{
			_nodes = sv;
			return null != _nodes;
		}
		
		public function getNodes():Vector.<INode> 
		{
			return _nodes;
		}
		
		public function getCost():Number
		{
			var val:Number;
			
			while (next() != end())
			{
				
			}
			if(_nodes[fromNode] != null)
			{
				if(_nodes[fromNode].neighbours[toNode] != null)
				{
					val = _nodes[fromNode].neighbours[toNode];
				}
			}
			return val;
		}
		
		public function reverse():Vector.<INode>
		{
			return _nodes.reverse();:Vector.<INode>
		}
		
		public function clone()
		{
			return _nodes.slice(0);
		}
		
		public function get visible():Boolean 
		{
			return _visible;
		}
		
		public function set visible(value:Boolean):void 
		{
			_visible = value;
		}
	}

}