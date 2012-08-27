package com.cjm.game.trigger 
{
	import com.cjm.game.core.GameEntity;
	import com.cjm.game.core.IGameWorld;
	import com.cjm.game.event.IGameSignal;
	import flash.display.DisplayObject;
	import org.osflash.signals.ISignal;
	import flash.geom.Vector3D;
	import com.cjm.game.pathfinding.INode;
	import com.cjm.game.core.IGameEntity;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Trigger extends GameEntity implements ITrigger 
	{
		protected var _dispatcher:IGameSignal;//Bridged
		
		protected var _region:ITriggerRegion;
		protected var _active:Boolean;
		protected var _region:ITriggerRegion;
		protected var _graphNode:INode;
		
		public function Trigger() 
		{
			
		}
		
		/* INTERFACE com.cjm.game.trigger.ITrigger */
		public function doTry(tr:IGameEntity):void 
		{
			if ( eval(tr) )
			{
				_dispatcher.dispatch( tr );
			}
		}
		
		//Wrappers/////////////////////////////////
		public function addListener( callBack:Function ):void
		{
			_dispatcher.add( callBack );
		}
		
		public function removeListener( callBack:Function ):void
		{
			_dispatcher.remove( callBack );
		}
		
		//Region Data//////////////
		public function setRegion(tr:ITriggerRegion):void 
		{
			_region = tr;
		}
		
		public function getRegion():ITriggerRegion 
		{
			return _region;
		}
		
		
		
		public function removeFromGame(tr:ITriggerRegion):void 
		{
			_active = false;
			_region = null;
			_dispatcher.removeAll();
			_dispatcher = null;
			_graphNode = null;
		}
		
		public function setActive(bool:Boolean):void 
		{
			_active = bool;
		}
		
		public function getActive():Boolean 
		{
			return _active;
		}
		
		public function setGraphNode(node:INode):void 
		{
			_graphNode = node;
		}
		
		public function getGraphNode():INode 
		{
			return _graphNode;
		}
		
		public function addCircularRegion(position:Vector3D, radius:Number):ITriggerRegion//TODO: convert 2d math to 3d 
		{
			return _region = new CircleTriggerRegion( position, radius );
		}
		
		public function addRectangleRegion(positionTopLeft:Vector3D, positionBottomRight:Number):ITriggerRegion 
		{
			
		}
	}
}