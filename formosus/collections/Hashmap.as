package formosus.collections 
{
	import formosus.collections.aggregaters.IAggregate;
	import formosus.collections.comparers.IComparer;
	import formosus.collections.iterators.HashmapIterator;
	import formosus.collections.iterators.IIterator;
	import formosus.specifications.ISpecification;

	import flash.utils.Dictionary;
	/**
	 * @author Mark
	 */
	public dynamic class Hashmap extends Dictionary implements ICollection
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function get length():uint
		{
			var len:uint = 0;
			
			for( var k:String in this) len++;
			
			return len;
		}

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * Creates a new Hashmap object. To remove a key from a Hashmap object, use the delete operator.
		 * 
		 * Extension from the flash.utils.Dictionary
		 * 
		 * @see flash.utils.Dictionary
		 *  
		 * @param weakKeys Instructs the Hashmap object to use "weak" references on object keys. If the only reference to an object is in the specified Hashmap object, the key is eligible for garbage collection and is removed from the table when the object is collected. 
		 */
		public function Hashmap(weakKeys:Boolean = false)
		{
			super(weakKeys);
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * @private
		 */
		public function add(obj : *) : void
		{
			throw new Error("You cannot add items to the hashmap through add");
		}
		
		public function aggregate(aggregater:IAggregate):*
		{
			var iter:IIterator = this.getIterator();
			var length:uint = this.length;
			var result:*;
			
			while(iter.next())
			{
				aggregater.aggregate(result, iter.current(), length);
			}
			
			return result;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear() : void
		{
			var iterater:IIterator = this.getIterator();
			
			while(iterater.next())
			{				
				delete this[HashmapIterator(iterater).key];
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function clone():*
		{
			var hashmap:Hashmap = new Hashmap();
			var iterator:IIterator = this.getIterator();
			
			while(iterator.next())
			{
				hashmap[ HashmapIterator( iterator ).key ] = iterator.current();
			}
			
			return hashmap;
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains(obj : *) : Boolean
		{
			var iterater:IIterator = this.getIterator();
			
			while(iterater.next())
			{
				if(iterater.current() == obj)
				{
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function filterBySpecification(spec : ISpecification):ICollection
		{
			var iterator:IIterator = this.getIterator();
			var list:ICollection = new Hashmap();
			
			while(iterator.next())
			{
				if(spec.isSatisfiedBy(iterator.current()))
				{
					list[HashmapIterator(iterator).key] = iterator.current();
				}
			}
			
			return list;
		}
		
		/**
		 * @private
		 */
		public function first():*
		{
			throw new Error("Cannot get the first item, since this ain't an ordered list");
		}
		
		/**
		 * @inheritDoc 
		 */
		public function getIterator():IIterator
		{
			return new HashmapIterator(this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function isEmpty():Boolean
		{
			return !this.getIterator().next();
		}
		
		/**
		 * @private
		 */
		public function last():*
		{
			throw new Error("Cannot get the last item, since this ain't an ordered list");
		}
		
		public function map(command:ICollectionCommand):void
		{
			var iter:IIterator = this.getIterator();
			
			while(iter.next())
			{
				command.item = iter.current();
				command.execute();	
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(obj : *):void
		{
			var iterator:IIterator = this.getIterator();
			
			while(iterator.next())
			{
				if(iterator.current() == obj)
				{
					delete this[HashmapIterator(iterator).key]; 
				}
			}
		}
		
		/**
		 * @private
		 */
		public function reverse():ICollection
		{
			throw new Error("You cannot reverse a hashmap, since it's order is not relevant");
			
			return this;
		}
		
		public function select(field:String):ICollection
		{
			var iter:IIterator = this.getIterator();
			var object:Object;
			var list:ICollection = new Hashmap();
			
			while(iter.next())
			{
				object = Object(iter.current());
				
				if(object.hasOwnProperty(field))
				{
					list.add(object[field]);		
				}
			}
			
			return list;
		}
		
		public function selectMany(...fields:Array):Vector.<ICollection>
		{
			var l:uint = fields.length;
			var lists:Vector.<ICollection> = new Vector.<ICollection>();
			
			while(--l > -1)
			{
				lists.push(this.select(fields[l]));
			}
			
			return lists;
		}
		
		/**
		 * @private
		 */
		public function sort(strategy : IComparer) : ICollection
		{
			throw new Error("Hashmap cannot be sorted");
		}
		
		public function take(count:uint):ICollection
		{
			var list:ICollection = new Hashmap();
			var iter:IIterator = this.getIterator();
			
			while(iter.next() && --count > -1)
			{
				list.add(iter.current());	
			}
			
			return list;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function toArray() : Array
		{
			var array:Array = [];
			var iterator:IIterator = this.getIterator();
			
			while(iterator.next())
			{
				array.push(iterator.current());
			}
			
			return array;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toVector() : Vector.<Object>
		{
			var vec:Vector.<Object> = new Vector.<Object>();
			var iterator:IIterator = this.getIterator();
			
			while(iterator.next())
			{
				vec.push(iterator.current());
			}
			
			return vec;
		}
	}
}
