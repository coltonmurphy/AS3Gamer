package formosus
{
	/**
	 * @author Mark
	 */
	public function vprintf(string:String, args:Array):String 
	{
		return printf.apply(null, arguments);	
	}
}
