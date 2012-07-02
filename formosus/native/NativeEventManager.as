package formosus.native 
{
	import formosus.IDispose;
	import formosus.collections.ICollection;
	import formosus.collections.List;
	import formosus.collections.iterators.IIterator;

	import flash.events.Event;
	/**
	 * @author Mark
	 */
	internal class NativeEventManager implements IDispose
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
		
		public function get lengthListeners():uint
		{
			return this._isDisposed ? 0 : this._events.length;
		}

		private var _eventDispatcher:IDisposableEventDispatcher;
		private var _events:ICollection;
		private var _isDisposed:Boolean = false;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function NativeEventManager(eventDispatcher:IDisposableEventDispatcher) 
		{
			this._eventDispatcher = eventDispatcher;
			this._events = new List();
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false, once:Boolean = false):Boolean
		{
			var eventData:EventData = new EventData(type, listener, useCapture, priority, useWeakReference, once);
			var iterator:IIterator = this._events.getIterator();
			
			while(iterator.next())
			{
				if( EventData( iterator.current() ).equals( eventData ) )
				{					
					return false;
				}
			}
			
			if(once)
			{
				this._eventDispatcher.addEventListener(type, this.handleOnce, useCapture, int.MIN_VALUE, useWeakReference );
			}
				
			this._events.add( eventData );
			
			return true;
		}

		private function handleOnce(event:Event):void 
		{
			var iterator:IIterator = this._events.getIterator();
			var ed:EventData;
			
			while(iterator.next())
			{
				ed = EventData( iterator.current() );
				
				if(ed.type == event.type && ed.once && this._eventDispatcher == event.target)
				{
					this._eventDispatcher.removeEventListener(event.type, this.handleOnce, ed.useCapture);
					this._eventDispatcher.removeEventListener(event.type, ed.listener, ed.useCapture);
				}
			}
		}

		public function dispose():void
		{
			if(!this.isDisposed)
			{
				this.removeAllEventListeners();
				this._events = null;
				this._isDisposed = true;
			}
		}

		public function removeAllEventListeners():void
		{
			if(this._events)
			{
				var iterator:IIterator = this._events.getIterator();
				var ed:EventData;

				while(iterator.next())
				{
					ed = EventData( iterator.current() );
					
					this._eventDispatcher.removeEventListener(ed.type, ed.listener, ed.useCapture);
				}
			}
		}
		
		public function removeAllEventListenersWithType(type:String):void
		{
			if(this._events)
			{
				var iterator:IIterator = this._events.getIterator();
				var ed:EventData;
				
				while(iterator.next())
				{
					ed = EventData( iterator.current() );
					
					if(ed.type == type)
					{
						this._eventDispatcher.removeEventListener(ed.type, ed.listener, ed.useCapture);
					}
				}
			}
		}

		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			if(this._events)
			{
				var iterator:IIterator = this._events.getIterator();
				var ed:EventData;
				
				while(iterator.next())
				{
					ed = EventData( iterator.current() );
					
					if(ed.type == type && ed.listener == listener && ed.useCapture == useCapture)
					{
						this._events.remove(ed);
						ed.dispose();
						ed = null;
					}
					
					return;
				}
			}
		}
	}
}
