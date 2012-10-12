package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.game.ai.pathfinding.INode;
	import com.cjm.game.ai.pathfinding.IPath;
	import com.cjm.patterns.behavioral.observer.INotification;
	import com.cjm.patterns.behavioral.state.IState;
	import com.cjm.patterns.structural.core.IContext;
	import com.cjm.utils.math.Vector2D;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class FollowPath extends Behavior
	{
		private var _path:IPath;
		private var _waypointSeekDistanceSq:Number = 25;
		
		override public function start( ...params ) :void
		{
			super.start();
	
			_path  					 = params[0] as IPath;
			_waypointSeekDistanceSq  = params[1] as Number;
		}

		override public function calculate( multiplierModifier:Number = 1 ) :Vector2D
		{
			//Amount of neighbors
			//Move to next target if close enough to current target( using distance squared )
			if ( Vector2D.Vec2DDistanceSq( _path.getCurrentWaypoint(), _owner.getPosition()) < _waypointSeekDistanceSq )
			{
				_path.setNextWaypoint();
			}
			
			if ( !_path.finshed() )
			{
				_steeringForce = new Seek(_owner, true, _path.getCurrentWaypoint() );
			}
			
			_steeringForce = new Arrive( _owner, true, _path.getCurrentWaypoint(), 3)
		
			return super.calculate( multiplierModifier );
		}
	}
}