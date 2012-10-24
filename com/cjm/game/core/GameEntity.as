package com.cjm.game.core 
{
	import com.cjm.game.event.GameSignal;
	import com.cjm.game.event.IGameSignal;
	import com.cjm.math.geom.Vector2D;
	import com.cjm.patterns.core.Entity;
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameEntity extends Entity implements IGameEntity, IUpdate, IRender 
	{

		protected var _world:IGameWorld   		   = null;
		protected var _tagged:Boolean     		   = false;
		
		protected var _removeNextUpdate:Boolean    = false;//For managing systems to check for entity destruction
		protected var _readyForNextUpdate:Boolean  = false; // depends on update frequency
		protected var _scale:uint        	       = 1;
		protected var _position:Vector3D           = new Vector3D();
		protected var _radius:uint                 = 1;
		protected var _mass:Number                 = 1;
		protected var _facing:Vector2D;
		
		public function GameEntity( world:IGameWorld ) 
		{
			_world = world;
			
			initialize();
		}
		
		public function initialize():void
		{
			throw new GameError("GameEntity initialize() must be overridden.");
		}
		
		public function getWorld():IGameWorld
		{
			return _world
		}
		

		//Evaluate and set _alive and other internal states
		public function update( time:Number ):void
		{
			
			
		}
		
		
		
		//Mediate view location to stage
		public function render( ...params ):void
		{

		}
		
		//For physics systems
	
		public function setMass(m:uint):Boolean 
		{
			var t:Number = _mass;
			_mass = m;
			

		}
		
		public function getMass():uint 
		{
			return _mass;
		}
		

		public function setScale(s:Number):void 
		{
			var t:Number = _scale;
			_scale = s;
			

		}
		
		public function getScale():Number 
		{
			return _scale
		}
		
}
		public function setPosition(v:Vector3D):void 
		{
			
			_position = v;
		}
		
		public function getPosition():Vector3D 
		{
			return _position;
		}
		

		public function setRadius(r:Number):void 
		{
			var t:Number = _radius;
			_radius = r;
		}
		
		public function getRadius(b):Number 
		{
			return _radius;
		}

		public function isTagged():Boolean
		{
			return _tagged
		}
		
		public function setTagged(t):void
		{
			 _tagged = t;
		}
		
		public function isToBeRemoved():Boolean
		{
			return _removeNextUpdate;
		};
		
		public function remove( ):void
		{
			_removeNextUpdate = true;
			_readyForNextUpdate = false;
		};
		
		public function destroy( ):void
		{
			_updateSignal.removeAll();
			_updateSignal = null;
		    _renderSignal.removeAll();
			_renderSignal = null;
		    _typeSignal.removeAll();
			_typeSignal = null;
		    _positionSignal.removeAll();
			_positionSignal = null;
		    _scaleSignal.removeAll();
			_scaleSignal = null;
		    _radiusSignal.removeAll();
			_radiusSignal = null;
			
			_world   		       = null;
			_tagged     		   = null;
			_alive                 = false;
			_removeNextUpdate      = false;//For managing systems to check for entity destruction
			_readyForNextUpdate    = false; // depends on update frequency
			_scale        	       = Number.NaN;
			_position              = null;
			_radius                = Number.NaN;
			_mass                  = Number.NaN;
		};

		public function intersects(ge:IGameEntity):Boolean
        {
			var radius:Number   =  (getRadius() + ge.getRadius()) * (getRadius() + ge.getRadius())
            var distance:Number = Vector2D.Vec2DDistance( getPosition(), ge.getPosition() );
			return Boolean(radius > distance);     
        }
	}

}