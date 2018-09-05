package com.cjm.ui 
{
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IButton
	{
		public function set label( value:String ):void
		public function set enabled( value:Boolean ):void
		
		protected function onClickEvent( event:MouseEvent ):void
		protected function onPressEvent( event:MouseEvent ):void
		protected function onReleaseEvent( event:MouseEvent ):void
		protected function onReleaseOutsideEvent( event:MouseEvent ):void
		protected function onRollOverEvent( event:MouseEvent ):void
		protected function onRollOutEvent( event:MouseEvent ):void
		protected function onMouseOverEvent( event:MouseEvent ):void
		protected function onMouseOutEvent( event:MouseEvent ):void
	}
	
}