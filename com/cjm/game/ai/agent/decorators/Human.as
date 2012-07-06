package cjm.game.ai.agent.decorators
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import cjm.game.ai.agent.Agent;
	
	internal class Human extends Agent 
	{
		//TODO: Externalize properties
		protected var _type:String				= "Human";
		protected var _speed:Number				= 5;
		protected var _velocity:Vector3D		= new Vector3D();
		protected var _mass:Number              = 100;
		protected var _defense:Number			= 5;
		protected var _offense:Number			= 5;
		protected var _life:Number    			= 100;
		protected var _intellegence:Number		= 5;
		protected var _awareness:Number;		= 5//line of sight radius
		protected var _view:Shape;
		
		public function Human( agent:Agent ) 
		{
			super (agent)
		}
		
		override public function update(timeslice:Number):void
		{
			_agent.update( timeslice );
			
			NResponder.dispatch(EventTypes.UPDATE, [this, timeslice])
		}
		
	    public function get speed():Number 
		{
			return  agent.speed + _speed;
		}
		override public function get mass():Number 
		{
			return _agent.mass + _mass;
		}
		override public function get defense():Number 
		{
			return _agent.defense + _defense;
		}
		override public function get offense():Number 
		{
			return  _offense;
		}
		override public function get life():Number 
		{
			return _agent.life + _life;
		}
		override public function get awareness():Number 
		{
			return _agent.awareness + _awareness;
		}
		
		override public function get intellegence():Number 
		{
			return _intellegence;
		}
	}
}