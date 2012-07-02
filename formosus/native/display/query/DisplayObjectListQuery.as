package formosus.native.display.query 
{
	import formosus.native.IDisplayObject;
	import formosus.native.display.query.commands.Remove;
	import formosus.native.display.query.commands.Stack;
	import formosus.native.display.query.iterators.IFrameIterator;
	import formosus.native.display.query.specifications.NameSpecification;
	import formosus.native.display.query.specifications.TypeSpecification;
	import formosus.specifications.ISpecification;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	/**
	 * @author Mark
	 */
	public class DisplayObjectListQuery
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		/**
		 * 
		 * @return 
		 */
		public function get items():Vector.<DisplayObject>
		{
			if(this._items == null)
			{
				this._items = new Vector.<DisplayObject>();
				
				this.decorate(Stack, this._items);
			}
			
			return this._items;
		}
		
		private var _displayObject:IDisplayObject;
		private var _specification:ISpecification;
		private var _frameIterator:IFrameIterator;
		private var _items:Vector.<DisplayObject>;
		private var _recursive:Boolean;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * 
		 * @param dispObject
		 * @param children
		 * @param recursive
		 */
		public function DisplayObjectListQuery(displayObject:IDisplayObject, frameIterator:IFrameIterator, specification:ISpecification = null, recursive:Boolean = false) 
		{
			this._frameIterator = frameIterator;
			this._recursive = recursive;
			this._specification = specification;
			this._displayObject = displayObject;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * 
		 * @param command
		 */
		public function decorate(command:Class, ...commandParams:Array):void
		{
			new DisplayObjectIterator( this._displayObject as DisplayObject, this._frameIterator, this._specification, this._recursive, command, commandParams );
			
			if(this._displayObject is MovieClip)
			{
				MovieClip( this._displayObject ).play();
			}
		}

		/**
		 * Removes the selection from the displaylist
		 */
		public function remove():void
		{
			this.decorate(Remove);
		}

		/**
		 * 
		 * @param regexp
		 * @return 
		 */
		public function withName(spec:NameSpecification):DisplayObjectListQuery
		{
			this._specification = this._specification ? this._specification.and(spec) : spec;
									
			return new DisplayObjectListQuery( this._displayObject, this._frameIterator, this._specification, this._recursive );
		}
		
		/**
		 * 
		 * @param type
		 * @return 
		 */
		public function withType(spec:TypeSpecification):DisplayObjectListQuery
		{
			this._specification = this._specification ? this._specification.and(spec) : spec;
			
			return new DisplayObjectListQuery( this._displayObject, this._frameIterator, this._specification, this._recursive );
		}
	}
}
