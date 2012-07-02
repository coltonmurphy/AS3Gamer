package formosus.utils.types 
{
	/**
	 * @author Mark
	 */
	public class StringUtils 
	{
		public static function endsWith(haystack:String, needle:String):Boolean 
		{
			return haystack.indexOf( needle ) == (haystack.length - needle.length);
		}

		public static function contains(haystack:String, needle:String):Boolean 
		{
			return haystack.indexOf( needle ) > -1;
		}

		public static function startsWith(haystack:String, needle:String):Boolean 
		{
			return haystack.indexOf( needle ) == 0;
		}

		public static function endsWithAny(haystack:String, needle:Array):Boolean 
		{
			var len:uint = needle.length;
			
			while(--len > -1)
			{
				if(StringUtils.endsWith( haystack, needle[len]))
				{
					return true;
				}
			}
			
			return false;
		}

		public static function containsAny(haystack:String, needle:Array):Boolean 
		{
			var len:uint = needle.length;
			
			while(--len > -1)
			{
				if(StringUtils.contains( haystack, needle[len]))
				{
					return true;
				}
			}
			
			return false;
		}

		public static function startsWithAny(haystack:String, needle:Array):Boolean 
		{
			var len:uint = needle.length;
			
			while(--len > -1)
			{
				if(StringUtils.startsWith( haystack, needle[len]))
				{
					return true;
				}
			}
			
			return false;
		}
	}
}
