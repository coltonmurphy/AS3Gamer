package formosus.native 
{
	import formosus.native.display.query.DisplayObjectQuery;

	import flash.display.DisplayObject;
	import flash.geom.Point;
	/**
	 * @author Mark
	 */
	public interface IFormoDisplayObject 
	{
		/**
		 * The alpha of the current object.
		 * 
		 * @return The alpha of the current object.
		 */
		function get autoAlpha():Number;
		/**
		 * Sets the alpha of the current object. When the alpha is set 0 the visible property will be set to false.
		 * 
		 * @param value The alpha of the displayobject.
		 */
		function set autoAlpha(value:Number):void;
		
		/**
		 * Gets the position of the displayobject as a Point
		 * 
		 * @return An instance of Point
		 */
		function get position():Point;
		/**
		 * Sets the position of the displayobject via a Point
		 * 
		 * @param value An instance of Point
		 */
		function set position(value:Point):void;
		
		/**
		 * Gets a Vector of DisplayObjects
		 * 
		 * @return A Vector with DisplayObjects 
		 */
		function get children():Vector.<DisplayObject>;
		/**
		 * Get childs by the given type.
		 * 
		 * @param type The type to match on
		 * @param recursive Determines if we should get the childs recursive
		 * @return A Vector with DisplayObjects 
		 */
		function childrenByType(type:Class, recursive:Boolean = false):Vector.<DisplayObject>;
		/**
		 * Get childs by the given regular expression. The regexp matches on the instance-name 
		 * 
		 * @param regexp The pattern to match the name on
		 * @param recursive Determines if we should get the childs recursive
		 * @return A Vector with DisplayObjects 
		 */
		function childrenByRegexpName(regexp:RegExp, recursive:Boolean = false):Vector.<DisplayObject>;
		

		/**
		 * Removes all the children within the displayobject
		 * 
		 * @param recursive Determines if we should remove the childs recursive 
		 */
		function removeChildren(recursive:Boolean = false):void;
		
		/**
		 * Removes all the children which match the given type.
		 *  
		 * @param type The type to match on
		 * @param recursive Determines if we should remove the childs recursive 
		 */
		function removeChildrenByType(type:Class, recursive:Boolean = false):void;
		/**
		 * Removes all the children which match the given regular expression. The regexp matches on the instance-name
		 * 
		 * @param regexp The pattern to match the name on
		 * @param recursive Determines if we should remove the childs recursive 
		 */
		function removeChildrenByRegexpName(regexp:RegExp, recursive:Boolean = false):void;
		
		/**
		 * Instantiates a new DisplayObjectQuery
		 * 
		 * @param recursive Determines if the query should be recursive
		 * @return A concrete instance of DisplayObjectQuery
		 * @see formosus.native.display.query.DisplayObjectQuery
		 */
		function query(recursive:Boolean = false):DisplayObjectQuery;
	}
}
