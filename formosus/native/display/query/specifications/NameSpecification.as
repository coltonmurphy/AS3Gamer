package formosus.native.display.query.specifications 
{
	import flash.display.DisplayObject;
	import formosus.specifications.CompositeSpecification;
	/**
	 * @author Mark
	 */
	public class NameSpecification extends CompositeSpecification
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		private var _regexp:RegExp;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function NameSpecification(regexp:RegExp) 
		{
			this._regexp = regexp;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		override public function isSatisfiedBy(candidate:*):Boolean 
		{
			return this._regexp.test( DisplayObject(candidate).name );
		}
	}
}
