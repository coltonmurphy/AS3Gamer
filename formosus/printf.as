package formosus
{
	public function printf(str:String, ...args):String
	{
//		var chunker:RegExp = /%(?!^%)(\((?P<var_name>[\w]+[\w_\d]+)\))?(?P<padding>[0-9]{1,2})?(\.(?P<precision>[0-9]+))?(?P<formater>[sxofaAbBcdHIjmMpSUwWxXyYZ])/ig;
//		var result:Object = chunker.exec(str);
//		
//		while(result)
//		{
//		   //eat more cheese. 	
//		}

		while(str.indexOf("%s") > -1)
		{
			str = str.replace("%s", args.shift());
		}
		
		return str;
	}
}
