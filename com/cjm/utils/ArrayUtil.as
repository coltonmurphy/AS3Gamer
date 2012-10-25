package com.cjm.utils{
	
	
	
	public class ArrayUtil{
		
		/**
		 * Inserts the data at the specified index of the array.
		 * The operation is carried out on the source array and not
		 * on a copy.
		 * 
		 * @param	src		The source Array
		 * @param	idx		The index at which data needs to be inserted.
		 * 					The index can be greater than the length of the 
		 * 					array, in which case, all intermediate values are
		 * 					initialized to undefined.
		 * @param	data 	The data to be inserted into the Array.

		 * 
		 */ 
		public static function insertAt(src:Array, idx:Number, data:*):void
		{
			if (idx < src.length)
			{
				var spliced:Array = src.splice(idx);
				src.push(data);
				for (var i:Number = 0; i < spliced.length; i++)
				{
					src.push(spliced[i]);
				}
			}
			else{
				src[idx] = (data)
			}
		}
		
		/**
		 * Removes the FIRST instance of the item passed in as a parameter
		 */ 
		public static function remove(src:Array, item:*):Boolean
		{
			var index:Number = src.indexOf(item);
			if (index == -1)
			{
				return false;
				//throw new Error("Could not remove item from Array, item doesnt exist in the Array");
			}
			src.splice(index, 1);
			
			return true;
		}
		
		
		
		/**
		 * Swaps the positions of two items if they are found in the 
		 * source array.
		 */ 
		public static function swapByValue(src:Array, item1:*, item2:*):void{
			var idx1:Number = src.indexOf(item1);
			var idx2:Number = src.indexOf(item2);
			swapByIndex(src, idx1, idx2);
		}
		
		public static function swapByIndex(src:Array, idx1:Number, idx2:Number):void{
			var temp:* = src[idx1];
			src[idx1] = src[idx2];
			src[idx2] = temp;
		}
		
		public static function createRepeatingArray(n:Number, v:Number):Array {
			var result:Array = new Array(n);
			for (var i:Number = 0; i<n; i++) result[i] = v;
			
			return result;
		}
		
		public static function createProgressiveArray(n:Number, s:Number, e:Number):Array 
		{
			var result:Array = new Array(n);
			for (var i:Number = 0; i < n; i++) 
				result[i] = s + i*(e-s)/(n-1);
			return result;
		}
		
		/**
		 * Inserts all the elements of the arrayToInsert Array into the sourceArray.
		 * The elements are inserted at the end of the sourceArray.
		 * 
		 * TODO: This isnt the most efficient way to do it. There is a way using splice or something.
		 */ 
		public static function insertArrayAtEnd(sourceArray:Array, arrayToInsert:Array):Array
		{
			for each(var o:* in arrayToInsert)
			{
				sourceArray.push(o);
			}
			return sourceArray;
		}
		
		public static function insertArrayAtIndex(sourceArray:Array, arrayToInsert:Array, idx:int):Array
		{
			for (var i:int = arrayToInsert.length - 1; i >= 0; i--)
			{
				insertAt(sourceArray, idx, arrayToInsert[i])
			}
			return sourceArray;
		}
		
		
		
		public static function removeItemAt(src:Array, idx:uint):void
		{
			src.splice(idx,1);
		}
		
		public static function removeDuplicates(arr:Array):Array
		{
			var uniques:Array = new Array()	
			var i:uint = 0;
			while(i < arr.length){
				var searchElement:* = arr[i];
				if(uniques.indexOf(searchElement) != -1){
					removeItemAt(arr, i);
					
				}
				else{
					uniques.push(searchElement);
					i++;
				}
			}
			return arr;
		}
		
		public static function createUniqueCopy(a:Array):Array
		{
			var newArray:Array = new Array();
			
			var len:Number = a.length;
			var item:Object;
			
			for (var i:uint = 0; i < len; ++i)
			{
				item = a[i];
				
				if(ArrayUtil.arrayContainsValue(newArray, item))
				{
					continue;
				}
				
				newArray.push(item);
			}
			
			return newArray;
		}
		
		public static function assign(arr:Array, size:Number, char:* = "0"):Array
		{
			var diff:Number = size - arr.length;
			for (var i:int = 0; i < diff; i++)
			{
				arr.push(char);
			}
			return arr;
		}
		
	}
}