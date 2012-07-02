package formosus.native 
{

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import formosus.native.display.query.DisplayObjectQuery;
	/**
	 * @author Mark
	 */
	public class FormoSprite extends Sprite implements ISprite, IFormoDisplayObject 
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function get autoAlpha():Number
		{
			return this._behaviorFormoDisplayObject.autoAlpha;
		}

		/**
		 * @inheritDoc
		 */
		public function set autoAlpha(value:Number):void
		{
			this._behaviorFormoDisplayObject.autoAlpha = value;
		}

		/**
		 * @inheritDoc
		 */
		public function get children():Vector.<DisplayObject>
		{
			return this._behaviorFormoDisplayObject.children;
		}

		/**
		 * @inheritDoc
		 */
		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get lengthListeners():uint
		{
			return this._nativeEventManager.lengthListeners;	
		}

		/**
		 * @inheritDoc
		 */
		public function get position():Point
		{
			return this._behaviorFormoDisplayObject.position;
		}

		/**
		 * @inheritDoc
		 */
		public function set position(value:Point):void
		{
			this._behaviorFormoDisplayObject.position = value;
		}
		private var _behaviorFormoDisplayObject:IFormoDisplayObject;
		private var _isDisposed:Boolean = false;
		private var _nativeEventManager:NativeEventManager;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * Creates a new FormoSprite.
		 */
		public function FormoSprite()
		{
			super();
			
			this._behaviorFormoDisplayObject = new FormoDisplayObjectBehavior(this);
			this._nativeEventManager = new NativeEventManager(this); 
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			if(this._nativeEventManager.addEventListener(type, listener, useCapture, priority, useWeakReference ))
			{
				super.addEventListener( type, listener, useCapture, priority, useWeakReference );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function addEventListenerOnce(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			if(this._nativeEventManager.addEventListener(type, listener, useCapture, priority, useWeakReference, true ))
			{
				super.addEventListener( type, listener, useCapture, priority, useWeakReference );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function childrenByRegexpName(regexp:RegExp, recursive:Boolean = false):Vector.<DisplayObject>
		{
			return this._behaviorFormoDisplayObject.childrenByRegexpName( regexp, recursive  );
		}
		
		/**
		 * @inheritDoc
		 */
		public function childrenByType(type:Class, recursive:Boolean = false):Vector.<DisplayObject>
		{
			return this._behaviorFormoDisplayObject.childrenByType(type, recursive );
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			if(!this.isDisposed)
			{
				this._behaviorFormoDisplayObject = null;
				this._nativeEventManager.dispose();
				this._nativeEventManager = null;
				this._isDisposed = true;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function query(recursive:Boolean = false):DisplayObjectQuery
		{
			return this._behaviorFormoDisplayObject.query( recursive );
		}

		/**
		 * @inheritDoc 
		 */
		public function removeAllEventListeners():void
		{
			this._nativeEventManager.removeAllEventListeners();
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllEventListenersWithType(type:String):void
		{
			this._nativeEventManager.removeAllEventListenersWithType(type);
		}
		
		/**
		 * @inheritDoc 
		 */
		public function removeChildren(recursive:Boolean = false):void
		{
			this._behaviorFormoDisplayObject.removeChildren(recursive);
		}

		/**
		 * @inheritDoc
		 */
		public function removeChildrenByRegexpName(regexp:RegExp, recursive:Boolean = false):void
		{
			this._behaviorFormoDisplayObject.removeChildrenByRegexpName(regexp, recursive );
		}

		/**
		 * @inheritDoc
		 */
		public function removeChildrenByType(type:Class, recursive:Boolean = false):void
		{
			this._behaviorFormoDisplayObject.removeChildrenByType(type, recursive );
		}

		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			this._nativeEventManager.removeEventListener(type, listener, useCapture);
			
			super.removeEventListener( type, listener, useCapture );
		}
	}
}
