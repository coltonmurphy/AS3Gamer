package formosus.specifications.string 
{
	/**
	 * @author Mark
	 */
	public class EndsWithAny extends EndsWith 
	{
		private var _endsWithAny:Array;

		public function EndsWithAny(endsWithAny:Array, caseSensitive:Boolean = true)
		{
			this._endsWithAny = endsWithAny;
			this._caseSensitive = caseSensitive;
		}

		override public function isSatisfiedBy(candidate:*):Boolean 
		{
			var l:uint = this._endsWithAny.length;
			
			while(--l > -1)
			{
				this._endsWith = this._endsWithAny[l];
				
				if(super.isSatisfiedBy( candidate ))
				{
					return true;	
				}
			}
			return false;
		}
	}
}
