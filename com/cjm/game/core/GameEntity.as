package com.cjm.game.core 
{

	import com.cjm.math.geom.Vector2D;
	import com.cjm.core.Entity;

	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameEntity extends Entity implements IGameEntity, IUpdate, IRender 
	{
		//Members responsible for world interaction
		protected var _world:IGameWorld;
		protected var _position:Vector2D;
		protected var _scale:uint;
		protected var _radius:uint;
		protected var _mass:Number;
		protected var _tagged:Boolean;
		
		//Update control variables
		protected var _removeNextUpdate:Boolean;//For managing systems to check for entity destruction
		protected var _readyForNextUpdate:Boolean ; // depends on update frequency
	
		public function GameEntity( world:IGameWorld, 
									position:Vector2D, 
									scale:uint = 1, 
									radius:uint = 1, 
									mass:uint = 1,
									type:String = "GameEntity",
									id  :uint   = 0,
									name:String = '') 
		{
			super( type, id, name );
			
			_world = world;
			
			_position = position;
			_scale    = scale;
			_radius   = radius;
			_mass     = mass;
			
			_removeNextUpdate   = false;
			_readyForNextUpdate = false;
			_tagged             = false;
		}
		
		
		public function getWorld():IGameWorld
		{
			return _world
		}
		
		public function isAtPosition( pos:Vector2D):Boolean
		{
		    var tolerance:Number = 10;
		  
		    return Vector2D.Vec2DDistanceSq(_position, pos) < _radius;
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
			_mass = m;
		}
		
		public function getMass():uint 
		{
			return _mass;
		}
		

		public function setScale(s:Number):void 
		{
			_scale = s;
		}
		
		public function getScale():Number 
		{
			return _scale
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
		
		public function remove():void
		{
			_removeNextUpdate = true;
			_readyForNextUpdate = false;
		};
		
		public function destroy( ):void
		{	
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