package formosus.collections 
{
	import formosus.collections.aggregaters.IAggregate;
	import formosus.collections.iterators.IIterator;
	import formosus.collections.iterators.ListIterator;
	import formosus.collections.comparers.IComparer;
	import formosus.specifications.ISpecification;
	import formosus.utils.types.ClassUtils;
	/**
	 * @author Mark
	 * 
	 * @includeExample collections/SpecificationExample.as
	 */
	public class List implements IObservableCollection
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function get length():uint
		{
			return this._storage.length;
		}
		
		public function get onItemAdded():CollectionItemSignal
		{
			return this._dispatcherItemAdded;
		}
		
		public function get onItemRemoved():CollectionItemSignal
		{
			return this._dispatcherItemRemoved;
		}

		protected var _storage:Vector.<Object> = new Vector.<Object>();
		
		protected var _dispatcherItemAdded:CollectionItemSignal;
		protected var _dispatcherItemRemoved:CollectionItemSignal;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * Creates a new instance of List.
		 * 
		 * @see formosus.collections.ICollection
		 * @see Array
		 *  
		 * @param list A list to start with. Can either be a Array or ICollection.
		 */
		public function List(list:* = null)
		{
			this._dispatcherItemAdded = new CollectionItemSignal();
			this._dispatcherItemRemoved = new CollectionItemSignal();
			
			if(list)
			{
				if(list is Array)
				{
					var len:uint = (list as Array).length;
				
					while(--len > -1)
					{
						this.add( list[len] );
					}
				}
				
				if(list is ICollection)
				{
					var iterator:IIterator = ICollection(list).getIterator();
					
					while(iterator.next())
					{
						this.add( iterator.current() );	
					}
				}
			}
		}

		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function add(obj:*):void
		{
			this._storage.push(obj);
			this.onItemAdded.dispatch(obj);
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
		public function clear():void
		{
			var iter:IIterator = this.getIterator();
			
			while(iter.next()) this.onItemRemoved.dispatch(iter.current());
			
			this._storage = new Vector.<Object>();
		}
		
		/**
		 * @inheritDoc
		 */
		public function clone():*
		{
			return ClassUtils.createInstanceFromInstance(this, [this.toArray().slice()]);
		}

		
		/**
		 * @inheritDoc
		 */
		public function contains(obj:*):Boolean
		{
			return this._storage.indexOf( obj ) > -1;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function filterBySpecification(spec:ISpecification):ICollection
		{
			var iterator:IIterator = this.getIterator();
			var list:ICollection = ClassUtils.createInstanceFromInstance(this) as ICollection;
			
			while(iterator.next())
			{
				if(spec.isSatisfiedBy(iterator.current()))
				{
					list.add(spec);
				}
			}
			
			return list;
		}
		
		public function first():*
		{
			return (this.length == 0) ? null : this._storage[0];
		}

		/**
		 * @inheritDoc
		 */
		public function getIterator():IIterator
		{
			return new ListIterator(this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function isEmpty():Boolean
		{
			return this._storage.length == 0;
		}
		
		public function last():*
		{
			return (this.length == 0) ? null : this._storage[this.length - 1];
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
		public function remove(obj:*):void
		{
			var iterator:IIterator = this.getIterator();
			var storage:Vector.<Object> = new Vector.<Object>();
			
			while(iterator.next())
			{
				if(iterator.current() != obj)
				{
					storage.push( iterator.current() );
				}
				else
				{
					this._dispatcherItemRemoved.dispatch(iterator.current());
				}
			}
			
			this._storage = storage;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function reverse():ICollection
		{
			return new List(this.toArray().reverse());
		}
		
		public function select(field:String):ICollection
		{
			var iter:IIterator = this.getIterator();
			var object:Object;
			var list:ICollection = ClassUtils.createInstanceFromInstance(this) as ICollection;
			
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
		 * @inheritDoc
		 */
		public function sort(strategy:IComparer):ICollection
		{
			var sortedList:Vector.<Object> = this._storage.sort( strategy.compare );
			var list:ICollection = ClassUtils.createInstanceFromInstance(this) as ICollection;
			var l:uint = sortedList.length;
				
			while(--l > -1)
			{
				list.add(sortedList[l]);
			}
			
			return list;
		}
		
		public function take(count:uint):ICollection
		{
			var list:ICollection = ClassUtils.createInstanceFromInstance(this) as ICollection;
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
		public function toArray():Array
		{
			var a:Array = [];
			var l:uint = this._storage.length;
			
			while(--l > -1)
			{
				a.push( this._storage[l] );
			}
			
			return a;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toVector():Vector.<Object>
		{
			return this._storage;
		}
	}
}
