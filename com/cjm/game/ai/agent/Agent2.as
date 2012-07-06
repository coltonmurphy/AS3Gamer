package com.cjm.game.ai.agent
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import com.cjm.core.IContext;

	import com.cjm.core.IEntity;
	import com.cjm.core.IState;
	i
	import com.cjm.game.ai.behaviours.Behaviour;
	import com.cjm.core.IState;
	import com.cjm.patterns.structural.composite.IComposite;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import com.cjm.patterns.core.IUpdate;
	
	public class Agent implements IAgent
	{
		protected var _state:State						= new State(null);
		protected var _speed:Number						= 0;
		protected var _velocity:Vector3D				= new Vector3D();
		protected var _mass:Number              		= 1;
		protected var _defense:Number					= 1;
		protected var _offense:Number					= 1;
		protected var _life:Number    					= 1;
		protected var _intellegence:Number				= 1;
		protected var _awareness:Number;				= 1//line of sight radius
		protected var _view:Shape						= new Rectangle(1,1,1,1);
		protected var _behaviors:Vector.<Behavior>	= new Vector.<Behavior>;
		
		public function Agent( id :String ) 
		{
			super( id )
		}
		
		public function update(timeslice:Number):void
		{
			//Modify view
		}
		
		public function changeState( state:IState ):void
		{
			_state = state;
		}
		
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
		}
		
		public function get velocity():Vector3D 
		{
			return _velocity;
		}
		
		public function set velocity(value:Vector3D):void 
		{
			_velocity = value;
		}
		
		public function get mass():Number 
		{
			return _mass;
		}
		
		public function set mass(value:Number):void 
		{
			_mass = value;
		}
		
		public function get defense():Number 
		{
			return _defense;
		}
		
		public function set defense(value:Number):void 
		{
			_defense = value;
		}
		
		public function get offense():Number 
		{
			return _offense;
		}
		
		public function set offense(value:Number):void 
		{
			_offense = value;
		}
		
		public function get life():Number 
		{
			return _life;
		}
		
		public function set life(value:Number):void 
		{
			_life = value;
		}
		
		public function get awareness():Number 
		{
			return _awareness;
		}
		
		public function set awareness(value:Number):void 
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
		
		public function get intellegence():Number 
		{
			return _intellegence;
		}
		
		public function set intellegence(value:Number):void 
		{
			_intellegence = value;
		}
	}

}