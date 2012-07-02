package formosus.ai.pathfinding 
{
	import flash.geom.Point;
	/**
	 * @author Mark
	 */
	public class Map 
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------
		
		public function get width():int
		{
			return (this._nodes.length);
		}
		
		public function get height():int
		{
			return (this._nodes.length > 0 && this._nodes[0]) ? this._nodes[0].length : 0;	
		}

		private var _nodes:Array = [];

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function Map() 
		{
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		public function add(pos:Point, accessible:Boolean = true):void
		{
			if(this._nodes[pos.x] == null)
			{
				this._nodes[pos.x] = [];
			}
			
			this._nodes[pos.x][pos.y] = new MapNode(pos, accessible);
		}
		
		public function createRectangle(rows:uint, columns:uint):void
		{
			for(var x:uint = 0; x <= rows; x++)
			{
				for(var y:uint = 0; y <= columns; y++)
				{
					this.add(new Point(x, y));
				}
			}
		}

		public function getNeighbors(node:MapNode, diagonal:Boolean):Vector.<MapNode> 
		{
			var neighbors:Vector.<MapNode> = new Vector.<MapNode>();
			
			if(diagonal)
			{	
				//upper left
				if ((node.position.x - 1 >= 0) && ( node.position.y - 1 >= 0) && (this._nodes[node.position.x - 1][node.position.y - 1].accessible == true))
				{
					neighbors.push(this._nodes[node.position.x - 1][node.position.y - 1]);
				}
					
				//upper right
				if ((node.position.x + 1 < width)&&(node.position.y-1>=0)&& (this._nodes[node.position.x + 1][node.position.y - 1].accessible == true))
				{
					neighbors.push(this._nodes[node.position.x + 1][node.position.y - 1]);
				}
					
				//bottom left
				if ((node.position.x - 1 >= 0) && (node.position.y + 1 < height) && (this._nodes[node.position.x - 1][node.position.y + 1].accessible == true))
				{
					neighbors.push(this._nodes[node.position.x - 1][node.position.y + 1]);
				}
					
				//bottom right
				if ((node.position.x + 1 < width) && (node.position.y + 1 < height) && (this._nodes[node.position.x + 1][node.position.y + 1].accessible == true))
				{
					neighbors.push(this._nodes[node.position.x + 1][node.position.y + 1]);
				}
			}
				
			//left
			if ((node.position.x - 1 >= 0) && (this._nodes[node.position.x - 1][node.position.y].accessible == true))
			{
				neighbors.push(this._nodes[node.position.x - 1][node.position.y]);
			}
				
			//bottom
			if ((node.position.y + 1 < height) && (this._nodes[node.position.x][node.position.y + 1].accessible == true))
			{
				neighbors.push(this._nodes[node.position.x][node.position.y + 1]);	
			}
				
			//right
			if ((node.position.x + 1 < width) && (this._nodes[node.position.x + 1][node.position.y].accessible == true))
			{
				neighbors.push(this._nodes[node.position.x + 1][node.position.y]);
			}
				
			//top
			if ((node.position.y - 1 >= 0) && (this._nodes[node.position.x][node.position.y - 1].accessible == true))
			{
				neighbors.push(this._nodes[node.position.x][node.position.y - 1]);
			}
			
			return neighbors;
		}
	}
}
