package formosus.native.display.query.specifications 
{
	import formosus.specifications.CompositeSpecification;
	/**
	 * @author Mark
	 */
	public class TypeSpecification extends CompositeSpecification 
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		private var _type:Class;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function TypeSpecification(type:Class)
		{
			this._type = type;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		override public function isSatisfiedBy(candidate:*):Boolean 
		{
			return candidate is this._type;
		}
	}
}
