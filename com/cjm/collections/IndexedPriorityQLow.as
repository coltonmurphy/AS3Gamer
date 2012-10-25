
/*Original from Matt Buckland. Modified to suit AS3 compiler.*/

//----------------------- IndexedPriorityQLow ---------------------------
//
//  Priority queue based on an index into a set of keys. The queue is
//  maintained as a 2-way heap.
//
//  The priority in this implementation is the lowest valued key
//------------------------------------------------------------------------
package com.cjm.collections
{	
	import adobe.utils.CustomActions;
	import com.cjm.utils.VectorUtil;
	public class IndexedPriorityQLow
	{
	    private var _keys:Vector.<Number>;
	    private var _data:Vector.<int>;
	    private var _invdata:Vector.<int>; 
        private var _size:int; 
		private var _maxSize:int;

		//you must pass the constructor a reference to the std::vector the PQ
	    //will be indexing into and the maximum size of the queue.
	    public function IndexedPriorityQLow(keys:Vector.<Number>, maxSize:int)
	    {
		    _keys = keys;
		    _maxSize = maxSize;
		    
			assign();
		}
		
		//Initializes data vectors with a predefined priority of 0
		private function assign():void
		{
			_size = 0;
			_data    = new Vector.<int>(_maxSize+1, true);
			_invdata = new Vector.<int>(_maxSize+1, true);
			VectorUtil.assign(_data, 0 );
			VectorUtil.assign(_invdata, 0 );
		}
		
		private function swap( a:int, b:int):void
		{
			var temp:int = _data[a];
			_data[a] = _data[b]; 
			_data[b] = temp;

			_invdata[_data[a]] = a; 
			_invdata[_data[b]] = b;
		}

		//bubbles value up to where it finds correct priority element, taking advantage of int's rounding assignment
	    private function reorderUpwards(nd:int):void
	    {
			//move up the heap swapping the elements until the heap is ordered
			while ( (nd>1) && (_keys[_data[nd/2]] > _keys[_data[nd]]) )
			{      
			  swap(nd/2, nd);

			  nd /= 2;
			}
	    }

		private function reorderDownwards( nd:int,  size:int):void
		{
			//move down the heap from node nd swapping the elements until
			//the heap is reordered
			while (2*nd <= size)
			{
				var child:int = 2 * nd;

				//set child to smaller of nd's two children
				if ((child < _size) && (_keys[_data[child]] > _keys[_data[child+1]]))
				{
					++child;
				}

				//if this nd is larger than its child, swap
				if (_keys[_data[nd]] > _keys[_data[child]])
				{
					swap(child, nd);

					//move the current node down the tree
					nd = child;
				}
				else
			    {
					break;
				 }
			}
		  }

	    public function isEmpty():Boolean
		{
			return (_size == 0);
		}

	    //to insert an item into the queue it gets added to the end of the heap
	    //and then the heap is reordered from the bottom up.
	    public function insert( idx:int ):void
	    {
			++_size;

			_data[_size] = idx;

			_invdata[idx] = _size;

			reorderUpwards(_size);
	    }

	    //to get the min item the first element is exchanged with the lowest
	    //in the heap and then the heap is reordered from the top down. 
	    public function pop():int
	    {
			swap(1, _size);

			reorderDownwards(1, _size-1);

			return _data[_size--];
	    }

	    //if a value changes, update its location by it's priority/value
	    public function changePriority(idx:int):void
	    {
		   reorderUpwards(_invdata[idx]);
	    }
	};
}