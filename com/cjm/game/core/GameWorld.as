package com.cjm.game.core 
{
	import com.cjm.game.ai.agent.AgentSystem;
	import com.cjm.game.trigger.TriggerSystem;
	import com.cjm.utils.math.Vector2D;
	import flash.display.DisplayObject;
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
		protected var _view:DisplayObject;
		protected var _lastUpdateTime:Number;
		
		public function GameWorld(root:DisplayObject) 
		{
			_view = root;
		}
		
		/* INTERFACE com.cjm.game.core.IGameWorld */
		public function initialize():Boolevoid 
		{
			_agentSystem   = new AgentSystem( this );
			_triggerSystem = new TriggerSystem( this );
			
			_agentSystem.createAgents( 50 );
		}
		
		public function getView():DisplayObject
		{
			return _view;
		}
		
		public function render():void 
		{
			_agentSystem.render(_view);
			_triggerSystem.render(_view);
		}
		
		public function tick(...param):void 
		{
			
		}
		
		public function run():Boolean 
		{
			
		}
		
		public function pause():Boolean 
		{
			
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
		

		public function get updateSignal():ISignal 
		{
			return _updateSignal;
		}
		
		public function update( ):void 
		{
			var time  = new Date().getMilliseconds();
			var step = ( time - _lastUpdateTime );
			
			_agentSystem.update( step );
			_triggerSystem.update( step );
			
			_lastUpdateTime = time;
		}

		public function destroy():void 
		{
			
		}
	}
}