package formosus.collections.iterators {
	import formosus.collections.Hashmap;
	

	/**
	 * @author Mark
	 */
	public class HashmapIterator implements IIterator
	{	
		private var _hashmap:Hashmap;
		private var _pointer:int;
		private var _keys:Vector.<String>;
		private var _length : uint;

		/**
		 * Creates a Hashmap iterator.
		 * 
		 * @see formosus.collections.Hashmap
		 * 
		 * @param hashmap A instance of a Hashmap to iterate over
		 */
		public function HashmapIterator(hashmap:Hashmap)
		{
			this._hashmap = hashmap;
			this._pointer = -1;
			this._keys = new Vector.<String>();
			
			for( var k:String in this._hashmap)
			{
				this._length++;
				this._keys.push(k);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function next():Boolean
		{
			return ++this._pointer < this._length;
		}

		/**
		 * The current key of the current value.
		 *  
		 * @return Returns the current key.
		 */
		public function get key():String
		{
			return this._keys[this._pointer];
		}
		
		/**
		 * @inheritDoc 
		 */
		public function current():*
		{
			return this._hashmap[this.key];	
		}
		
		/**
		 * @inheritDoc
		 */
		public function rewind() : void
		{
			this._pointer = -1;
		}
	}
}
