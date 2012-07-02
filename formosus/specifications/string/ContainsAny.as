package formosus.specifications.string 
{
	/**
	 * @author Mark
	 */
	public class ContainsAny extends Contains 
	{
		private var _containsAny:Array;

		public function ContainsAny(containsAny:Array, caseSensitive:Boolean = true)
		{
			this._containsAny = containsAny;
			this._caseSensitive = caseSensitive;
		}

		override public function isSatisfiedBy(candidate:*):Boolean 
		{
			var l:uint = this._containsAny.length;
			
			while(--l > -1)
			{
				this._contains = this._containsAny[l];
				
				if(super.isSatisfiedBy( candidate ))
				{
					return true;
				}
			}
			
			return false;
		}
	}
}
