package com.cjm.game.core 
{
	import com.cjm.patterns.core.Entity;
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameEntity extends Entity implements IGameEntity, IUpdate, IRender 
	{
		private var _onUpdate       :ISignal;
		private var _onRender       :ISignal;
		private var _onSetType      :ISignal;
		private var _onSetPosition  :ISignal;
		private var _onSetScale     :ISignal;
		private var _onSetRadius    :ISignal;
		
		protected var _wold:IGameWorld    = null;
		protected var _tagged:Boolean     = false;
		protected var _scale:uint         = 1;
		protected var _position:Vector3D  = new Vector3D();
		protected var _radius:uint        = 1;
		protected var _mass:Number        = 1;
		
		public function GameEntity( world:IGameWorld ) 
		{
			_wold = world;
		}
		
		public function initializeSystems():Boolean
		{
			return false;
		}
		
		public function getGameWorld():IGameWorld
		{
			return _world
		}
		
		public function get onUpdate:ISignal
		{
			return _onUpdate;
		};
		
		public function update( ...params ):void
		{
			onUpdate.dispatch(params);
		}
		
		public function get onRender:ISignal
		{
			return _onRender;
		};
		
		public function render( ...params ):void
		{
			onRender.dispatch(params);
		}
		
		public function setMass(m:uint):Boolean 
		{
			_mass = m;
		}
		
		public function getMass():uint 
		{
			return _mass;
		}
		
		public function get onSetScale():ISignal 
		{
			return _onSetScale;
		}
		
		public function setScale(s:Number):void 
		{
			var t:Number = _scale;
			_scale = s;
			
			onSetScale.dispatch(t, s);//orig scale, changedto scale
		}
		
		public function getScale():Number 
		{
			return _scale
		}
		
		public function get onSetPosition():ISignal 
		{
			return _onSetPosition;
		}
		
		public function setPosition(v:Vector3D):void 
		{
			_position = v;
			
			onSetPosition.dispatch(t, s);//orig scale, changedto scale
		}
		
		public function getPosition():Vector3D 
		{
			return _position;
		}
		
		public function get onSetRadius():ISignal 
		{
			return _onSetRadius;
		}
		
		public function setRadius(r:Number):void 
		{
			var t:Number = _radius;
			_radius = r;
			onSetRadius.dispatch(t, r);
		}
		
		public function getRadius(b):Number 
		{
			return _radius;
		}
		
		override public function getType():String 
		{
			return _type;
		}
		
		override public function setType(t:String):void 
		{
			var tp:Number = super._type;
			super._type = t;
			onSetID.dispatch(tp, t);
		}
		
		override public function getID():String 
		{
			return super._id;
		}
		
		override public function setID(id:String):void 
		{
			var t:Number = super._id;
			super._id = id;
			onSetID.dispatch(t, id);
		}
		
		public function isTagged():Boolean
		{
			return _tagged
		}
		
		public function setTagged(t):void
		{
			 _tagged = t;
		}
		
	}

}