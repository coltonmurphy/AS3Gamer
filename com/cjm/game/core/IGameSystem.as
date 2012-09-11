package com.cjm.game.core 
{
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGameSystem extends IUpdate implements IRender, IDestroy
	{
		protected function initialize( ):void;
		public function getEntities():Vector.<IGameEntity>;
		public function addEntity( e:IGameEntity );
		public function setActive(b:Boolean):void;
		public function getActive( ):Boolean;
		public function destroy( ):void;
		public function render( ...params ):void;
	}
	
}