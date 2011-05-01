package chem.environment
{

	import flash.display.MovieClip;
	import chem.objects.Equipment;
	import chem.util.Animation;


	public class Table extends MovieClip
	{
		private var gmin = 10;// smallest gap between two objects

		private var equipments:Array = new Array();

		public function Table()
		{

		}

		public function get equipmentCount():int
		{
			return equipments.length;
		}

		public function getEquipment(i: int):Equipment
		{
			return equipments[i];
		}

		public function addEquipment(e:Equipment):Boolean
		{
			var destY:Number = topY - e.baseLine.y;
			if (e.y > destY)
			{
				e.y = destY;
			}
			else
			{
				Animation.fall(e, destY);
			}

			var index:int = 0,i:int;
			while (index < equipments.length && xx(equipments[index]) < xx(e))
			{
				index++;
			}

			var l:Number = x,r:Number = x + width;
			if (index > 0)
			{
				l = xx(equipments[index - 1]) + ww(equipments[index - 1]);
			}
			if (index < equipments.length)
			{
				r = xx(equipments[index]);
			}

			var totalDelta : Number = ww(e) - (r-l) + 2*gmin;
			var totalGap:Number = 0;
			var g : Array = new Array();
			for (i = 0; i < index; i++)
			{
				g[i] = xx(equipments[i]) - x - gmin;
				if (i > 0)
				{
					g[i] -=  xx(equipments[i - 1]) - x + ww(equipments[i - 1]);
				}
				totalGap +=  g[i];
			}
			for (i = index; i < equipments.length; i++)
			{
				g[i] = x + width - xx(equipments[i]) - ww(equipments[i]) - gmin;
				if (i < equipments.length - 1)
				{
					g[i] -=  x + width - xx(equipments[i + 1]);
				}
				totalGap +=  g[i];
			}


			// case 1: enough space, no need to move existing equipments
			if (totalDelta < 0)
			{
				moveEquipment(e, Math.min(Math.max(xx(e),l + gmin),r - ww(e) - gmin));
			}
			else
			{
				if (totalDelta < totalGap)
				{
					// case 2: enough space, need to move existing equipments
					var k:Number = totalDelta / totalGap;
					var newX = x;
					for (i = 0; i < index; i++)
					{
						newX +=  (1-k) * g[i] + gmin;
						if (i > 0)
						{
							newX +=  ww(equipments[i - 1]);
						}
						moveEquipment(equipments[i], newX);
					}
					newX = x + width;
					for (i = equipments.length-1; i >= index; i--)
					{
						newX -=  ww(equipments[i]) + (1-k) * g[i] + gmin;
						moveEquipment(equipments[i], newX);
					}
					newX -=  ww(e) + gmin;
					moveEquipment(e, newX);
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

		private function xx(e:Equipment):Number {
			return e.x + e.baseLine.x;
		}
		
		private function ww(e:Equipment):Number {
			return e.baseLine.width;
		}

		private function moveEquipment(e:Equipment, newX:Number)
		{
			Animation.move(e, newX-e.baseLine.x, e.y, 200);
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