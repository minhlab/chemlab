package chem.environment
{

	import flash.display.MovieClip;
	import chem.objects.Equipment;
	import chem.util.Animation;


	public class Table extends MovieClip
	{
		private var gmin = 5;// smallest gap between to objects

		private var equipments:Array = new Array();

		public function Table()
		{

		}

		public function addEquipment(e:Equipment):Boolean
		{
			var index:int = 0;
			while (index < equipments.length && equipments[index].x < e.x)
			{
				index++;
			}

			var l:Number = x,r:Number = x + width;
			if (index > 0)
			{
				l = equipments[index - 1].x + equipments[index - 1].width;
			}
			if (index < equipments.length)
			{
				r = equipments[index].x;
			}

			var totalDelta : Number = e.width - (r-l) + 2*gmin;
			var totalGap:Number = 0;
			var g : Array = new Array();
			for (var i = 0; i < index; i++)
			{
				g[i] = equipments[i].x - x - gmin;
				if (i > 0)
				{
					g[i] -=  equipments[i - 1].x - x + equipments[i - 1].width;
				}
				totalGap +=  g[i];
			}
			for (var i = index; i < equipments.length; i++)
			{
				g[i] = x + width - equipments[i].x - equipments[i].width - gmin;
				if (i < equipments.length - 1)
				{
					g[i] -=  x + width - equipments[i + 1].x;
				}
				totalGap +=  g[i];
			}


			// case 1: enough space, no need to move existing equipments
			if (totalDelta < 0)
			{
				e.x = Math.min(Math.max(e.x,l + gmin),r - e.width - gmin);
			}
			else
			{
				if (totalDelta < totalGap)
				{
					// case 2: enough space, need to move existing equipments
					var k:Number = totalDelta / totalGap;
					var newX = x;
					for (var i = 0; i < index; i++)
					{
						newX +=  (1-k) * g[i] + gmin;
						if (i > 0)
						{
							newX += equipments[i - 1].width;
						}
						moveEquipment(equipments[i], newX);
					}
					newX = x + width;
					for (var i = equipments.length-1; i >= index; i--)
					{
						newX -=  equipments[i].width + (1-k) * g[i] + gmin;
						moveEquipment(equipments[i], newX);
					}
					newX -=  e.width + gmin;
					moveEquipment(e, newX);
					//e.x = newX;
				}
				else
				{
					// case 3: not enough space
					return false;
				}
			}
			equipments.splice(index,0,e);
			//trace(equipments.length);
			return true;
		}

		private function moveEquipment(e:Equipment, newX:Number) {
			Animation.move(e, newX, e.y, 200);
		}

		public function removeEquipment(e:Equipment)
		{
			var index = equipments.indexOf(e);
			if (index >= 0)
			{
				equipments.splice(index,1);
			}
			//trace(equipments.length);
		}

		public function get topY()
		{
			return y;
		}

	}
}