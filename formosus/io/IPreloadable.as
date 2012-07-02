package formosus.io 
{

	/**
	 * @author Mark
	 */
	public interface IPreloadable 
	{
		/**
		 * Templete method. Invoked on initialization
		 */
		function onInit():void;
		
		/**
		 * Templete method. Invoked on progress
		 *  
		 * @param percentage The percentage how far the task has progressed from 0 to 1
		 */
		function onProgress(percentage:Number):void;
		
		/**
		 * Templete method. Invoked on completion 
		 */
		function onComplete():void;
	}
}
