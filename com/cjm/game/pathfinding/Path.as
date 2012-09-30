package com.cjm.game.pathfinding 
{
	import com.cjm.collections.Iterator;
	import com.cjm.game.core.IRender;
	import com.cjm.math.geom.Vector2D;
	import com.cjm.math.MathUtil;
	import com.cjm.view.Line;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public final class Path implements IPath, IRender
	{		
		private var _nodes:Vector.<INode>;
		private var _visible:Boolean;
		private var _graph:IGraph;
		
		public function Path( g:IGraph ) 
		{
			_visible = false;
			_graph = g;
		}
	
		
		public function render(...context):void
		{
			var parentView:Sprite = _graph.getView();
			
			if ( null != getView() )
			{
				_view.graphics.clear();
			}
			else
			{
				_view = new Shape();
			}
			
			_view.graphics.lineStyle(3, 3);
			
			var it:Iterator = getIterator()
			var line:Line = new Line( _view );
	
			while ( it.hasNext() )
			{
				var node:Node = it.getNext() as Node;
				
				line.to(node.x, node.y);
				
				node.render( _view );
			}
			
			parentView.addChild( _view );
		}
		
		//For cursing the list of nodes
		public function getIterator():Iterator
		{
			return new Iterator(_nodes as Array);
		}
		
		public function addNode( n:INode ):uint
		{
			var i:uint = _nodes.unshift( n );
			
			return i;
		}
		
		public function getNode( i:uint ):INode
		{
			if ( length() > 0 )
			{
				return _nodes[i];
			}
			return null;
		}
		
		public function removeNode( n:INode ):Boolean
		{
			var i:Number;
			if ( -1 !=  (i = _nodes.indexOf(n)))
			{
				_nodes.splice(i, 1);
				return true;
			}
			
			return false;
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
		
		//Just use euclidean distance for now
		public function getCost():Number
		{
			var it:Iterator = getIterator();
			var val:Number = 1;
			var n:INode; var p:INode;
			while (n = it.next() != it.end())
			{
				if ( null != p )
				{
					val += Vector2D.Vec2DDistanceSq(n, p);
				}
				p = n;
			}

			return Math.sqrt(val);
		}
		
		public function reverse():Vector.<INode>
		{
			return _nodes.reverse();
		}
		
		public function clone():Vector.<INode>
		{
			return _nodes.slice(0);
		}
		
		public function get visible():Boolean 
		{
			return _view.visible;
		}
		
		public function set visible(value:Boolean):void 
		{
			_view.visible = value;
			
			draw();
		}
	}
}