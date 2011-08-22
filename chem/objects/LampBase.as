package chem.objects
{

	import flash.display.MovieClip;
	import flash.geom.Point;
	import chem.util.GuiUtils;


	public class LampBase extends MovieClip
	{

		public var _equipment:Equipment = null;

		public function LampBase()
		{
			// constructor code
		}

		public function get equipment()
		{
			return _equipment;
		}
		public function set equipment(e:Equipment)
		{
			if (_equipment != null && _equipment.parent == handle.hmover)
			{
				GuiUtils.changeParent(_equipment, Main.instance);
			}
			if (e != null)
			{
				e.x = 0 - e.baseLine.x;
				e.y =  -  e.height / 2;
				handle.y =  -  e.height - e.y;
				handle.hmover.x =  -  e.baseLine.width / 2;
				//var frontScale:Number = (e.baseLine.width + 2) / handle.hmover.frontRing.width;
				//handle.hmover.frontRing.scaleX = handle.hmover.frontRing.scaleY = frontScale;
				//handle.hmover.frontRing.width *= frontScale;
				//handle.hmover.frontRing.height *= frontScale;
				handle.hmover.frontRing.width = e.baseLine.width + 2;
				handle.hmover.backRing.width = e.baseLine.width + 2;

				e.parent.removeChild(e);
				var index:int = handle.hmover.getChildIndex(handle.hmover.frontRing);
				handle.hmover.addChildAt(e, index);
			}
			_equipment = e;
		}

	}

}