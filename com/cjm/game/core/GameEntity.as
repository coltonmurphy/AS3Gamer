package com.cjm.game.core 
{
	import com.cjm.game.event.GameSignal;
	import com.cjm.game.event.IGameSignal;
	import com.cjm.patterns.core.Entity;
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameEntity extends Entity implements IGameEntity, IUpdate, IRender 
	{
		private var _updateSignal    :GameSignal;
		private var _renderSignal    :GameSignal;
		private var _typeSignal      :GameSignal;
		private var _positionSignal  :GameSignal;
		private var _scaleSignal     :GameSignal;
		private var _radiusSignal    :GameSignal;
		
		protected var _world:IGameWorld   		   = null;
		protected var _tagged:Boolean     		   = false;
		protected var _alive:Boolean               = false;
		protected var _removeNextUpdate:Boolean    = false;//For managing systems to check for entity destruction
		protected var _readyForNextUpdate:Boolean  = false; // depends on update frequency
		protected var _scale:uint        	       = 1;
		protected var _position:Vector3D           = new Vector3D();
		protected var _radius:uint                 = 1;
		protected var _mass:Number                 = 1;
		
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
		
		public function get updateSignal:IGameSignal {return _updateSignal;};
		//Evaluate and set _alive and other internal states
		public function update( time:Number ):void
		{
			
			_updateSignal.dispatch(params);
		}
		
		
		public function get renderSignal:IGameSignal{return _renderSignal;};
		//Mediate view location to stage
		public function render( ...params ):void
		{
			renderSignal.dispatch(params);
		}
		
		//For physics systems
		public function get massSignal:IGameSignal{return _massSignal;};
		public function setMass(m:uint):Boolean 
		{
			var t:Number = _mass;
			_mass = m;
			
			_massSignal.dispatch(t, m);//orig scale, changedto scale
		}
		
		public function getMass():uint 
		{
			return _mass;
		}
		
		public function get scaleSignal():IGameSignal {return _scaleSignal;}
		public function setScale(s:Number):void 
		{
			var t:Number = _scale;
			_scale = s;
			
			scaleSignal.dispatch(t, s);//orig scale, changedto scale
		}
		
		public function getScale():Number 
		{
			return _scale
		}
		
		public function get positionSignal():IGameSignal {return _positionSignal;}
		public function setPosition(v:Vector3D):void 
		{
			_positionSignal.dispatch(_position, v);//orig scale, changedto scale
			
			_position = v;
		}
		
		public function getPosition():Vector3D 
		{
			return _position;
		}
		
		public function get radiusSignal():IGameSignal {return _radiusSignal;}
		public function setRadius(r:Number):void 
		{
			var t:Number = _radius;
			_radius = r;
			radiusSignal.dispatch(t, r);
		}
		
		public function getRadius(b):Number 
		{
			return _radius;
		}

		public function isTagged():Boolean
		{
			return _tagged
		}
		
		public function get taggedSignal():IGameSignal {return _taggedSignal;}
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
		
		// If health > damage we are still kicking
		public function isAlive( ):Boolean
		{
			return _alive;
		};
	}

}