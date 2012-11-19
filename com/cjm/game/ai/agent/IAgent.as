package com.cjm.game.ai.agent 
{

	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.game.core.IGameWorld;
	import com.cjm.graph.NavGraphEdge;
	import com.cjm.math.geom.Vector2D;
	import com.cjm.patterns.behavioral.state.IStateMachine;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IAgent extends IGameMovingEntity 
	{
		function setAwarenessRadius(ar:uint):Boolean;
		function getAwarenessRadius():uint;
		
		function setNavPath( path:Vector.<NavGraphEdge>):Boolean;
		function getNavPath():Vector.<NavGraphEdge>;
		
		
		function isAtPosition( pos:Vector2D ):Boolean
		function reduceHealth( val:uint ):void
		
		
		
		function setLife(ar:uint):Boolean;
		function getLife():uint;
		
		function get onDie:ISignal;
		function die(ar:uint):Boolean;
	}
}