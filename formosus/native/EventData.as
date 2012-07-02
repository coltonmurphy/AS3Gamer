package formosus.native 
{
	import formosus.IDispose;
	import formosus.IEquatable;
	/**
	 * @author Mark
	 */
	internal class EventData implements IDispose, IEquatable
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}

		public function get listener():Function
		{
			return _listener;
		}
		
		public function get once():Boolean
		{
			return _once;
		}
		
		public function get priority():int
		{
			return _priority;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function get useCapture():Boolean
		{
			return _useCapture;
		}
		
		public function get useWeakReference():Boolean
		{
			return _useWeakReference;
		}
		private var _isDisposed:Boolean = false;
		private var _listener:Function;
		private var _once:Boolean;
		private var _priority:int;
		private var _type:String;
		private var _useCapture:Boolean;
		private var _useWeakReference:Boolean;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function EventData(type:String, listener:Function, useCapture:Boolean, priority:int = 0, useWeakReference:Boolean = false, once:Boolean = false) 
		{
			this._type = type;
			this._listener = listener;
			this._useCapture = useCapture;
			this._priority = priority;
			this._useWeakReference = useWeakReference;
			this._once = once;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		public function dispose():void
		{
			if(!this.isDisposed)
			{
				this._type = null;
				this._listener = null;
			}
		}

		public function equals(other:IEquatable):Boolean
		{
			return EventData(other).listener == this.listener
				&& EventData(other).type == this.type
				&& EventData(other).useCapture == this.useCapture
				&& EventData(other).priority == this.priority
				&& EventData(other).useWeakReference == this.useWeakReference
				&& EventData(other).once == this.once;
		}
	}
}
