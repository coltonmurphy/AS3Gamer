package formosus.native 
{

	import flash.display.DisplayObject;
	import flash.geom.Point;
	import formosus.native.display.query.DisplayObjectQuery;
	import formosus.native.display.query.specifications.NameSpecification;
	import formosus.native.display.query.specifications.TypeSpecification;
	/**
	 * @author Mark
	 */
	internal class FormoDisplayObjectBehavior implements IFormoDisplayObject
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		public function get autoAlpha():Number
		{
			return this._displayObject.alpha;
		}
		
		public function set autoAlpha(value:Number):void
		{
			this._displayObject.alpha = value;
			this._displayObject.visible = value > 0;
		}
		
		public function get children():Vector.<DisplayObject>
		{
			return this.query().specificFrame( this._displayObject is IMovieClip ? IMovieClip(this._displayObject).currentFrame : 1 ).items;
		}

		public function get position():Point
		{
			return new Point( this._displayObject.x, this._displayObject.y );
		}

		public function set position(value:Point):void
		{
			this._displayObject.x = value.x;
			this._displayObject.y = value.y;
		}
		private var _displayObject:ISprite;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function FormoDisplayObjectBehavior(displayObject:ISprite) 
		{
			this._displayObject = displayObject;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		public function childrenByRegexpName(regexp:RegExp, recursive:Boolean = false):Vector.<DisplayObject>
		{
			return this.query(recursive)
				.specificFrame( this._displayObject is IMovieClip ? IMovieClip(this._displayObject).currentFrame : 1 )
				.withName(new NameSpecification( regexp ) )
				.items;
		}
		
		public function childrenByType(type:Class, recursive:Boolean = false):Vector.<DisplayObject>
		{
			return this.query(recursive)
				.specificFrame( this._displayObject is IMovieClip ? IMovieClip(this._displayObject).currentFrame : 1 )
				.withType(new TypeSpecification(type))
				.items;
		}
		
		public function query(recursive:Boolean = false):DisplayObjectQuery
		{
			return new DisplayObjectQuery( this._displayObject, recursive );
		}
		
		public function removeChildren(recursive:Boolean = false):void
		{
			this.query(recursive).specificFrame( this._displayObject is IMovieClip ? IMovieClip(this._displayObject).currentFrame : 1 ).remove();	
		}
		
		public function removeChildrenByRegexpName(regexp:RegExp, recursive:Boolean = false):void
		{
			this.query(recursive)
				.specificFrame( this._displayObject is IMovieClip ? IMovieClip(this._displayObject).currentFrame : 1 )
				.withName(new NameSpecification( regexp ) )
				.remove();
		}
		
		public function removeChildrenByType(type:Class, recursive:Boolean = false):void
		{
			this.query(recursive)
				.specificFrame( this._displayObject is IMovieClip ? IMovieClip(this._displayObject).currentFrame : 1 )
				.withType(new TypeSpecification(type))
				.remove();		
		}
	}
}
