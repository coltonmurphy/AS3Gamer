//Original from pzuh package, with minor modifications from myself. 
package com.cjm.game.ai.naivebayes 
{
	import com.cjm.patterns.creational.core.IDestroy;
	import com.cjm.utils.math.MathUtil;
	public final class NaiveBayesPredictor implements IDestroy
	{
		private var attributes:Vector.<Attribute> = new Vector.<Attribute>();
		
		private var maxData:int;
		
		public function NaiveBayesPredictor(maxData:int = 100) 
		{
			this.maxData = maxData;
		}	
		
		public function addAttribute(attribute:Attribute):Boolean
		{
			if (attributes.indexOf(attribute) == -1)
			{
				return (attributes.push(attribute) >= 0);
			}
			
			return false;
		}
		
		public function updateAttributeData(name:String, data:*):void
		{
			if (getAttributeByName(name).getDataArray().length >= maxData) 
			{
				getAttributeByName(name).getDataArray().shift();
			}
			
			getAttributeByName(name).getDataArray().push(data);
		}
		
		private function getAttributeByName(name:String):Attribute
		{
			for (var i:int = 0; i < attributes.length; i++)
			{
				if (attributes[i].getName() == name)
				{
					return attributes[i];
				}
			}
			
			return null;
		}
		
		public function getAttributeDataByName(name:String):Array
		{
			return getAttributeByName(name).getDataArray();
		}
		
		public function predict(attributeName:String):*
		{
			/* Naive-Bayes Classifier:
			 * 
			 * P(A|B) = a P(B|A) P(A)
			 * 
			 * with a = 1/P(B)
			 * 
			 * */

			//if we less than one data in attribute array, prediction is not possible, return null
			if (attributes.length <= 1)
			{
				return null;
			}
			
			//attribute which will predicted
			var predictedAttribute:Attribute;
			
			var uniqueData:Array = new Array();
			var probArray:Array = new Array();
			var a:int   = 0;
			var i:int   = 0;
			var j:int   = 0;
			var k:int   = 0;
			var len:int = 0;
			
			//if no data in each attribute, prediction is not possible, return null
			for (a; a < attributes.length; a++)
			{
				if (attributes[a].getDataArray().length < 0)
				{
					return null;
				}
			}
			
			//set which attribute will be predicted by specifying its name
			len = attributes.length;
			
			for (i; i < len; i++)
			{
				if (attributes[i].getName() == attributeName)
				{
					predictedAttribute = attributes[i];
					
					break;
				}
			}
			
			//get unique data for the predicted attribute			
			uniqueData = MathUtil.getUniqueArray(predictedAttribute.getDataArray());
			
			//calculate tbe probability
			len = uniqueData.length;
			
			for (; j < len; j++)
			{
				var p:Number = 1;
				
				for (var k:int = 0; k < attributes.length; k++)
				{
					if (attributes[k].getName() != attributeName)
					{
						p *= getProbability(getAttributeByName(attributeName), uniqueData[j], attributes[k]);						
					}
				}
				
				p *= getPrior(getAttributeByName(attributeName), uniqueData[j]);
				
				probArray.push(p);
			}
			
			//get highest probability value
	
			return uniqueData[probArray.indexOf(Math.max.apply(null, probArray))];
		}
		
		private function getPrior(attribute:Attribute, data:*):Number
		{
			/*prior = P(A), probablity of an action prior to any knowledge about the current situation
			 * example:
				 * probability of Weather=SUNNY in weather data which contain 3 value: SUNNY, RAINY, CLOUDY
				 * if we have data: SUNNY, SUNNY, RAINY, CLOUDY, CLOUDY, SUNNY, SUNNY
				 * the prior of Weather=SUNNY will be: 4/7 
			 * */
			
			var sampleCountPos:int = 0;
			var sampleCountNeg:int = 0;
			
			for (var i:int = 0; i < attribute.getDataArray().length; i++)
			{
				if (attribute.getDataByIndex(i) == data)
				{
					sampleCountPos += 1;
				}
				else
				{
					sampleCountNeg += 1;
				}
			}
			
			return sampleCountPos / (sampleCountPos + sampleCountNeg);
		}
		
		private function getProbability(attributeA:Attribute, dataA:*, attributeB:Attribute):Number
		{
			/* calculate the probability for P(B|A)
			 * example:
				 * attributeB: Weather[SUNNY, CLOUDY, RAINY]
				 * predicted attribute (attributeA): PlayTennis[YES, NO]
				 * dataA: YES
				 * calculate probability P(Weather|PlayTennis=YES)
			 * */
			
			var sampleCountPos:int = 0;
			var sampleCountNeg:int = 0;
			
			/* we need to loop to previous completed data. 
			 * so the loop must end in last index - 1
			 * */
			var length:int = attributeB.getDataArray().length - 1;
			
			for (var i:int = 0; i < length; i++)
			{
				/* filter data on predicted atrribute that match the specified dataA only
				 * example:
					 * we filter data on predicted attribute (PlayTennis) which have value=YES
				 * */				
				if (attributeA.getIndexByData(attributeA.getDataByIndex(i)) == attributeA.getIndexByData(dataA)) 
				{
					/* check whether attributeB data index [i] is match with attributeB data on last index
					 * example:
						 * assume data on last index is SUNNY. 
						 * we loop through data,
						 * if we got data with value is SUNNY too, sampleCountPos increased,
						 * otherwise sampleCountNeg increased
					 * */
					if (attributeB.getDataByIndex(i) == attributeB.getDataByIndex(length))
					{
						sampleCountPos += 1;
					}
					else
					{
						sampleCountNeg += 1;
					}
				}
			}
			
			return sampleCountPos / (sampleCountPos + sampleCountNeg);
		}
		
		public function destroy():void
		{
			for (var i:int = attributes.length - 1; i > 0; i--)
			{
				attributes[i].destroy();
				attributes.splice(i, 1);
			}
			
			attributes.length = 0;
			attributes = null;
		}
	}
}