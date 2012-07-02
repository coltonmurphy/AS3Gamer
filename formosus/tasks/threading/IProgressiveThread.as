package formosus.tasks.threading 
{
	/**
	 * @author Mark
	 */
	public interface IProgressiveThread extends IThread
	{
		/**
		 * Property which indicates how many iterations have done
		 * 
		 * @return Returns how many iterations have been done
		 */
		function get iterationsDone():int;
		/**
		 * Property which indicates how many iterations have done
		 * 
		 * @param value Sets how many iterations there are done
		 */
		function set iterationsDone(value:int):void;
		
		/**
		 * Property which indicates how many iterations there are
		 *  
		 * @return Returns how many iterations should be done
		 */
		function get iterationsTotal():int;
		/**
		 * Property which indicates how many iterations there are
		 *  
		 * @param value Sets how many iterations there will be there total
		 */
		function set iterationsTotal(value:int):void;
	}
}
