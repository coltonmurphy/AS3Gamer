package formosus.ai.pathfinding 
{
	import formosus.IEquatable;
	import formosus.collections.ILinkedListItem;

	import flash.geom.Point;
	/**
	 * @author Mark
	 */
	public class MapNode implements ILinkedListItem, IEquatable
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		public function get accessible():Boolean
		{
			return _accessible;
		}
		
		public function set accessible(accessible:Boolean):void
		{
			_accessible = accessible;
		}

		public function get next():ILinkedListItem
		{
			return this._next;
		}
		
		public function set next(next:ILinkedListItem):void
		{
			this._next = next;
		}
		
		public function get position():Point
		{
			return _position;
		}
		
		public function set position(position:Point):void
		{
			_position = position;
		}
		public function get weight():Number
		{
			return _weight;
		}
		
		private var _accessible:Boolean = true;
		private var _next:ILinkedListItem;
		private var _position:Point;
		private var _weight:Number;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function MapNode(pos:Point, accessible:Boolean = true, weight:Number = 0) 
		{
			this._position = pos;
			this._accessible = accessible;
			this._weight = weight;
		}
		
		public function equals(other:IEquatable):Boolean
		{
			return MapNode(other).position.x == this.position.x && MapNode(other).position.y == this.position.y;
		}
	}
}
