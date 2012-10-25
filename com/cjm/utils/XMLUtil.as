package org.openPyro.utils{
	
	/**
	 * A collection of Utility methods for working with XML
	 */
	public class XMLUtil
	{
		/**
		 * Returns a boolean whether the newNode exists 
		 * anywhere deeper in the item node. For example
		 * to find node  
		 * 
		 * <pre>
		 * <deepNode>one</deepNode> 
		 * </pre>
		 * 
		 * in something like 
		 * 
		 * <pre>
		 * <parent>
		 * 			<node1>
		 * 				<node2>
		 * 	`				<node3>
		 * 						<deepNode>one</deepNode>
		 * 					</node3>
		 *				</node2>
		 * 			</node1>
		 *		</parent>
		 * </pre>
		 */ 
		public static function isItemParentOf(item:XML, newNode:XML):Boolean{
			if(item.contains(newNode)) return true;
			var foundAsChild:Boolean = false
 			for(var i:int=0; i<item.children().length(); i++){
				foundAsChild = isItemParentOf(item.children()[i],newNode)
				if(foundAsChild){
					break;
				}
			}
			return foundAsChild;
		}
		
		// Source:http://www.nuff-respec.com/technology/sort-xml-by-attribute-in-actionscript-3
		public static function sortXMLByAttribute(
				$xml		:	XML,
				$attribute	:	String,
				$options	:	Object	=	null,
				$copy		:	Boolean	=	false
			)
			:XML
		 {
			//store in array to sort on
			var xmlArray:Array	= new Array();
			var item:XML;
			for each(item in $xml.children())
			{
				var object:Object = {
					data	: item, 
					order	: item.attribute($attribute)
				};
				xmlArray.push(object);
			}
		
			//sort using the power of Array.sortOn()
			xmlArray.sortOn('order',$options);
		
			//create a new XMLList with sorted XML
			var sortedXmlList:XMLList = new XMLList();
			var xmlObject:Object;
			for each(xmlObject in xmlArray )
			{
				sortedXmlList += xmlObject.data;
			}
			
			if($copy)
			{
				//don't modify original
				return	$xml.copy().setChildren(sortedXmlList);
			}
			else
			{
				//original modified
				return $xml.setChildren(sortedXmlList);
			}
		 }

	}
}