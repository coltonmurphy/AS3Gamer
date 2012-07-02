package formosus.specifications.string 
{
	/**
	 * @author Mark
	 */
	public class StartsWithAny extends StartsWith 
	{
		private var _startsWithAny:Array;

		public function StartsWithAny(startsWithAny:Array, caseSensitive:Boolean = true)
		{
			this._startsWithAny = startsWithAny;
			this._caseSensitive = caseSensitive;
		}

		override public function isSatisfiedBy(candidate:*):Boolean 
		{
			var l:uint = this._startsWithAny.length;
			
			while(--l > -1)
			{
				this._startsWith = this._startsWithAny[l];
				
				if(super.isSatisfiedBy( candidate ))
				{
					return true;
				}
			}
			
			return false;
		}
	}
}
