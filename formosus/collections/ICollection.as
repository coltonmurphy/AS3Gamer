package formosus.collections 
{
	import formosus.collections.aggregaters.IAggregate;
	import formosus.ICloneable;
	import formosus.collections.comparers.IComparer;
	import formosus.collections.iterators.IIterator;
	import formosus.specifications.ISpecification;
	/**
	 * @author Mark
	 */
	public interface ICollection extends ICloneable
	{
		/**
		 * Adds an object to the collection.
		 * 
		 * @param obj The object to add to the collection
		 */
		function add(obj:*):void;
		/**
		 * Clears the collection.
		 */
		function clear():void;
		/**
		 * Checks if the given objects is in the collection.
		 * 
		 * @param obj The object to search for
		 * @return True if the object is found, false if it isn't.
		 */
		function contains(obj:*):Boolean;
		/**
		 * Returns a new instance of ICollection filtered by the given ISpecification.
		 * 
		 * @see formosus.specifications.ISpecification
		 * @see formosus.collections.ICollection
		 * 
		 * @param spec A concrete instance of ISpecification
		 * @return A new instance of ICollection filtered by the given ISpecification
		 */
		function filterBySpecification(spec:ISpecification):ICollection;
		/**
		 * Returns a new IIterator object.
		 * 
		 * @see formosus.collections.IIterator
		 * 
		 * @return A concrete IIterator;
		 */
		function getIterator():IIterator;
		/**
		 * Returns if the collection is empty.
		 * 
		 * @return True if the collection is empty, false if it isn't.
		 */
		function isEmpty():Boolean;
		/**
		 * Returns how many objects reside in the collection.
		 * 
		 * @return Returns how many objects reside in the collection.
		 */
		function get length():uint;
		/**
		 * Removes the specified object from the collection.
		 * 
		 * @param obj The object which should be removed from the collection.
		 */
		function remove(obj:*):void;
		/**
		 * 
		 * @param command
		 */
		function map(command:ICollectionCommand):void;
		/**
		 * 
		 * @param aggregater
		 * @return 
		 */
		function aggregate(aggregater:IAggregate):*;
		/**
		 * 
		 * @return 
		 */
		function first():*;
		/**
		 * 
		 * @return 
		 */
		function last():*;
		/**
		 * 
		 * @param count
		 * @return 
		 */
		function take(count:uint):ICollection;
		/**
		 * 
		 * @param field
		 * @return 
		 */
		function select(field:String):ICollection;
		/**
		 * 
		 * @param fields
		 * @return 
		 */
		function selectMany(...fields:Array):Vector.<ICollection>;
		/**
		 * Returns a new instance of ICollection sorted by the sorting strategy specified.
		 * 
		 * @see formosus.collections.IComparer
		 * @see formosus.collections.ICollection
		 * 
		 * @param strategy A concrete instance of IComparer which defines the comparing strategy to use.
		 * @return Returns a new instance of ICollection sorted by the sorting strategy specified.
		 */
		function sort(strategy:IComparer):ICollection;
		/**
		 * Converts the collection to an array.
		 * 
		 * @return An array of all the items which reside in the collection.
		 */
		function toArray():Array;
		/**
		 * Converts the collection to a vector.
		 * 
		 * @return A vector of all the items which reside in the collection.
		 */
		function toVector():Vector.<Object>;
		/**
		 * Returns a reversed collection.
		 * 
		 * @return Returns a reversed collection.
		 */
		function reverse():ICollection;
	}
}
