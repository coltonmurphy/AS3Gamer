package com.cjm.game.core 
{
	import com.cjm.game.ai.agent.AgentSystem;
	import com.cjm.game.ai.pathfinding.PathManager;
	import com.cjm.game.trigger.TriggerSystem;
	import com.cjm.math.geom.Matrix2D;
	import com.cjm.math.geom.Vector2D;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameWorld implements IGameWorld 
	{
		protected var _agentSystem:AgentSystem;
		protected var _triggerSystem:TriggerSystem;
		protected var _pathSystem:PathManager;
		protected var _view:DisplayObject;
		protected var _lastUpdateTime:Number;
		
		public function GameWorld(root:DisplayObject) 
		{
			_view = root;
		}
		
		public function getView():DisplayObject { return _view; }
		
		/* INTERFACE com.cjm.game.core.IGameWorld */
		public function initialize():Boolean
		{
			_agentSystem   = new AgentSystem( this );
			_triggerSystem = new TriggerSystem( this );
			
			//TODO: create graph
			//TODO: path planner and assign to other systems
			
			
			_agentSystem.createAgents( 50 );
		}
		
		public function run():Boolean 
		{
			if (_view )
			{
				_view.addEventListener(Event.ENTER_FRAME, onFrameUpdate)
			}
		}
		
		public function pause():Boolean 
		{
			if (null != _view  )
			{
				if( _view.hasEventListener( Event.ENTER_FRAME )
				    _view.removeEventListener(Event.ENTER_FRAME, onFrameUpdate )
			}
		}
		
		private function onFrameUpdate(e:Event = null):void 
		{
			var time  = new Date().getMilliseconds();
			var step = ( time - _lastUpdateTime );
			update( step );
			render( _view )
		}
		
		public function update( time:Number ):void 
		{
			_agentSystem.update( step );
			_triggerSystem.update( step );
			_pathSystem.update()
			//TODO:Physics system
			
			//TODO:Collision detection
			
			//TODO:Post processing
			_lastUpdateTime = time;
		}
		
		public function render():void 
		{
			_agentSystem.render(_view);
			_triggerSystem.render(_view);
		}

		public function tagObstaclesWithinViewRange(ige:IGameEntity, range:Number):void
		{
			var entities:Vector.<IGameEntity> = queryRadiusByEntityType( ige.getPosition(), range );
			
			for each( e:IGameEntity in entities )
					  e.setTagged( true );

		}
		
		public function queryRadiusByEntityType(fromPosition:Vector2D, radius:int = 5, type:Class = null):Vector.<IAgent>
		{
			var entities:Vector.<IGameEntity> = _agentSystem.getEntities();
			
			for each( e:IGameEntity in entities )
			{
				if ( null == type || ( e is type ))
				{
					if ( fromPosition.getDistance( e.getPosition() ) <= radius )
					{
						entities.push(e)
					}
				}
			}
			
			return entities;
		}

		

		//--------------------------- WorldTransform -----------------------------
		//
		//  given a std::vector of 2D vectors, a position, orientation and scale,
		//  this function transforms the 2D vectors into the object's world space
		//------------------------------------------------------------------------
		public static function WorldTransform(points:Vector<Vector2D>, pos:Vector2D,forward:Vector2D, side:Vector2D,scale:Vector2D):Vector<Vector2D>
		{
			//copy the original vertices into the buffer about to be transformed
		    var tranVector2Ds:Vector.<Vector2D> = points.slice();
		  
		    //create a transformation matrix
		    var m :Matrix2D = new Matrix2D();
			
			//scale
		    if ( (scale.x != 1.0) || (scale.y != 1.0) )
		    {
				m.scale(scale.x, scale.y);
		    }

			//rotate
			m.rotateVec2D(forward, side);

			//and translate
			m.translate(pos.x, pos.y);
			
		    //now transform the object's vertices
		    m.transformVector2Ds(tranVector2Ds);

		    return tranVector2Ds;
		}
		
		//--------------------- PointToWorldSpace --------------------------------
		//
		//  Transforms a point from the agent's local space into world space
		//------------------------------------------------------------------------
		public static function PointToWorldSpace( point:Vector2D,
										          entityHeading:Vector2D,
										          entitySide:Vector2D,
										          entityPosition:Vector2D):Vector2D
		{
			//make a copy of the point
		    var p:Vector2D = point.clone();
		  
		    //create a transformation matrix
			var m :Matrix2D = new Matrix2D();

			//rotate
			m.rotateVec2D(entityHeading, entitySide);

			//and translate
			m.translate(entityPosition.x, entityPosition.y);
			
		    //now transform the vertices
		    m.transformVector2D(p);

		   return p;
		}
		
		//--------------------- VectorToWorldSpace --------------------------------
		//
		//  Transforms a vector from the agent's local space into world space
		//------------------------------------------------------------------------
		public static function VectorToWorldSpace( v:Vector2D,
										            entityHeading:Vector2D,
										            entitySide:Vector2D,):Vector2D
		{
			//make a copy of the point
			var vec = v.clone();
		  
		    //create a transformation matrix
			var m :Matrix2D = new Matrix2D();

			//rotate
			m.rotateVec2D(entityHeading, entitySide);

		    //now transform the vertices
		    m.transformVector2D(vec);

		    return vec;
		}
		
		//--------------------- PointToLocalSpace --------------------------------
		//
		//------------------------------------------------------------------------
		public function pointToLocalSpace( p:Vector2D,
												  entityHeading:Vector2D, 
												  entitySide:Vector2D, 
												  entityPosition:Vector2D):Vector2D
		{
			//make a copy of the point
		    var tp = p.clone();
		  
		    //create a transformation matrix
			var m:Matrix2D = new Matrix2D();

		    var tx:Number = -entityPosition.getDot(entityHeading);
		    var ty:Number = -entityPosition.Dot(entitySide);

		    //create the transformation matrix
		    m._11(entityHeading.x); 
			m._12(entitySide.x);
		    m._21(entityHeading.y); 
			m._22(entitySide.y);
		    m._31(tx);           
			m._32(ty);
			
		    //now transform the vertices
		    m.tTransformVector2D(tp);

		    return tp;
		}

		//--------------------- VectorToLocalSpace --------------------------------
		//
		//------------------------------------------------------------------------
		public function vectorToLocalSpace(vec:Vector2D,
												  entityHeading:Vector2D, 
												  entitySide:Vector2D )
		{ 
			//make a copy of the point
		    var tp:Vector2D = vec.clone();
		  
		    //create a transformation matrix
			var m:Matrix2D = new Matrix2D();

		    //create the transformation matrix
		    m._11(entityHeading.x);
			m._12(entitySide.x);
		    m._21(entityHeading.y);
			m._22(entitySide.y);
			
		    //now transform the vertices
		    m.transformVector2D(tp);

		    return tp;
		}

		//-------------------------- Vec2DRotateAroundOrigin --------------------------
		//
		//  rotates a vector ang rads around the origin
		//-----------------------------------------------------------------------------
		public function vec2DRotateAroundOrigin( v:Vector2D, ang:Number):void
		{
		  //create a transformation matrix
		  var m:Matrix2D = new Matrix2D();

		  //rotate
		  m.rotate(ang);
			
		  //now transform the object's vertices
		  mat.transformVector2Ds(v);
		}

		//------------------------ Create Whiskers -----------------------------------
		//
		//  given an origin, a facing direction, a 'field of view' describing the 
		//  limit of the outer whiskers, a whisker length and the number of whiskers
		//  this method returns a vector containing the end positions of a series
		//  of whiskers radiating away from the origin and with equal distance between
		//  them. (like the spokes of a wheel clipped to a specific segment size)
		//----------------------------------------------------------------------------
		public function createWhiskers( amount:uint, length:Number,fov:Number,
													      facing:Vector2D,
													      origin:Vector2D):Vector.<Vector2D>
		{
		  //this is the magnitude of the angle separating each whisker
		  var sectorSize:Number = fov/Number(amount-1);

		  var whiskers:Vector<Vector2D> = new Vector.<Vector2D>();
		  var temp:Vector2D = new Vector2D;
		  var angle:Number = -fov*0.5; 
		
		  for ( var w=0:uint; w<amount; ++w)
		  {
			//create the whisker extending outwards at this angle
			temp = facing;
			vec2DRotateAroundOrigin(temp, angle);
			whiskers.push(origin.addBy( length) .multiply( temp ));

			angle+=sectorSize;
		  }

		  return whiskers;
		}
		
		public function getPathManager():PathManager
		{
			return _pathSystem;
		}
		public function destroy():void 
		{
			
		}
	}
}