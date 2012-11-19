package com.cjm.game.core 
{
	import com.cjm.collections.iterators.Iterator;
	import com.cjm.game.ai.agent.AgentSystem;
	import com.cjm.game.map.Wall2D;
	import com.cjm.math.geom.Geometry2D;
	import com.cjm.pathfinding.PathManager;
	import com.cjm.game.trigger.TriggerSystem;
	import com.cjm.math.geom.Matrix2D;
	import com.cjm.math.geom.Vector2D;
	import flash.display.DisplayObject;
	import flash.events.Event;
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

		

		
		//---------------------------- isLOSOkay --------------------------------------
		//
		//  returns true if the ray between A and B is unobstructed.
		//------------------------------------------------------------------------------
		public static function isLOSOkay(Vector2D A, Vector2D B):Boolean
		{
		    //return Wall2D.doWallsObstructLineSegment(A, B, m_pMap->GetWalls());
		}

		//------------------------- isPathObstructed ----------------------------------
		//
		//  returns true if a bot cannot move from A to B without bumping into 
		//  world geometry. It achieves this by stepping from A to B in steps of
		//  size BoundingRadius and testing for intersection with world geometry at
		//  each point.
		//-----------------------------------------------------------------------------
		public static function isPathObstructed( A:Vector2D,
										         B:Vector2D,
										         BoundingRadius:Number):Boolean
		{
		    var ToB:Vector2D = Vector2D.Vec2DNormalize(B.clone().subtract(A));

		    var curPos:Vector2D = A.clone();

		    while (Vector2D.Vec2DDistanceSq(curPos, B) > BoundingRadius*BoundingRadius)
		    {   
			    //advance curPos one step
			    curPos.add(ToB.scaleBy( 0.5 * BoundingRadius ));
			
			    //test all walls against the new position
			    if ( Wall2D.doWallsIntersectCircle(_map.getWalls(), curPos, BoundingRadius))
			    {
			        return true;
			    }
		    }

		    return false;
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