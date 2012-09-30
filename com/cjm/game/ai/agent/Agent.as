package com.cjm.game.ai.agent
{
	/**
	 * ...
	 * @author Colton Murphy
	 */

	import com.cjm.game.ai.agent.state.AgentState;
	import com.cjm.game.ai.agent.state.AgentStateMachine;
	import com.cjm.game.ai.behaviors.steering.SteeringSystem;
	import com.cjm.game.core.GameMovingEntity;
	import com.cjm.game.weapon.WeaponSystem;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;

	
	public class Agent extends GameMovingEntity implements IAgent
	{
		//systems
		protected var _steeringSystem:SteeringSystem;
		
		protected var _alive:Boolean                    = false;
		protected var _stateMachine:AgentStateMachine					= new AgentState(null);
		protected var _defense:Number					= 1;
		protected var _offense:Number					= 1;
		protected var _life:Number    					= 1;
		protected var _intellegence:Number				= 1;
		protected var _awareness:Number;				= 1//line of sight radius
		protected var _view:Shape						= new Rectangle(1,1,1,1);
	
		
		public function Agent( id :String ) 
		{
			super( id );
			new AgentStateMachine
		}
		
		override public function initialize():void
		{
			//Initialize systems
			_steeringSystem = new SteeringSystem( this );
			
			_stateMachine = AgentStateMachine.getInstance();
			_weaponeSystem = new WeaponSystem( this );
		}
		
		public function update(timeElapsed:Number):void
		{
			//Get steering force
			///Force = Mass*Acceleration
			var steeringForce:Vector3D = _steeringSystem.calculate();
			
			///Acceleration = Force / Mass
			var acceleration: Vector2D = steeringForce.scaleBy( getMass() );
			
			getVelocity().add( acceleration.scaleBy( timeElapsed ) );
			
			//TODO: Truncate to max speed
			
			//Update coordinate location
			_position.add( getVelocity().scaleBy( timeElapsed ) );
			
			//Update heading if moving
			if ( getVelocity().lengthSquared > 0.00000001 )
			{
				setHeading( _velocity.normalize() );
			}
		}
		
		override public function render(...context):void
		{
			if ( _visible && null == _view)
			{
				var parentView:DisplayObject = context[0] as DisplayObject;
				_view = getView();
				_view.graphics.lineStyle(1, 1);
				_view.graphics.beginFill(0xC4FB89);
				_view.graphics.drawCircle(0, 0, 1);
				_view.graphics.endFill();
				_view.x = _position.x;
				_view.y = _position.y;
				parentView.addChild(_view);
			}	
		}
		
		public function changeState( state:IState ):void
		{
			_state = state;
		}
		
		
		public function getDefense():Number 
		{
			return _defense;
		}
		
		public function setDefense(value:Number):void 
		{
			_defense = value;
		}
		
		public function getOffense():Number 
		{
			return _offense;
		}
		
		public function setOffense(value:Number):void 
		{
			_offense = value;
		}
		
		public function getLife():Number 
		{
			return _life;
		}
		
		public function setLife(value:Number):void 
		{
			_life = value;
		}
		
		public function getAwareness():Number 
		{
			return _awareness;
		}
		
		public function setAwareness(value:Number):void 
		{
			_awareness = value;
		}
		
		public function get view():* 
		{
			return _view;
		}
		
		public function set view(value:*):void 
		{
			_view = value;
		}
		
		public function getIntellegence():Number 
		{
			return _intellegence;
		}
		
		public function setIntellegence(value:Number):void 
		{
			_intellegence = value;
		}
		
		// If health > damage we are still kicking
		public function isAlive( ):Boolean
		{
			return _alive;
		};
	}

}