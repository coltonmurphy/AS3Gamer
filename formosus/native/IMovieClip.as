package formosus.native 
{
	import flash.display.Scene;
	/**
	 * @author Mark
	 */
	public interface IMovieClip extends ISprite
	{
		function addFrameScript(...args:*):void;
		
		function get currentFrame():int;
				
		function get currentLabel():String;
		
		function get currentLabels():Array;
		
		function get currentScene():Scene;
		
		function get enabled():Boolean;
		
		function set enabled(value:Boolean):void;
		
		function get framesLoaded():int;
		
		function gotoAndPlay(frame:Object, scene:String = null):void;
		
		function gotoAndStop(frame:Object, scene:String = null):void;
		
		function nextFrame():void;
		
		function nextScene():void;
		
		function play():void;
		
		function prevFrame():void;
		
		function prevScene():void;
		
		function get scenes():Array;
		
		function stop():void;
		
		function get totalFrames():int;
		
		function get trackAsMenu():Boolean;
		
		function set trackAsMenu(value:Boolean):void;
	}
}
