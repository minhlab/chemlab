﻿package chem.objects
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.MovieClip;

	public class SpiritLamp extends Equipment
	{

		private var _covered:Boolean = true;
		private var startPosition:Point;

		public function SpiritLamp()
		{
			removeChild(upperMarker);
			removeChild(lowerMarker);
			hideBase();

			frontCover.addEventListener(MouseEvent.MOUSE_DOWN, onFrontCoverMouseDown);
			frontCover.addEventListener(Event.ADDED_TO_STAGE, function(evt:Event) {
			stage.addEventListener(MouseEvent.MOUSE_UP, onFrontCoverMouseUp);
			stage.addEventListener(Event.ENTER_FRAME, onFrontCoverEnterFrame);
			});
		}

		public function onFrontCoverMouseDown(evt:MouseEvent)
		{
			evt.stopImmediatePropagation();
			if (startPosition != null)
			{
				return;
			}
			startPosition = new Point(stage.mouseX - frontCover.x,stage.mouseY - frontCover.y);
		}

		public function onFrontCoverMouseUp(evt:MouseEvent)
		{
			if (startPosition == null)
			{
				return;
			}
			startPosition = null;
			if (! testCoverGesture())
			{
				uncover();
			}
		}

		public function onFrontCoverEnterFrame(evt:Event)
		{
			if (startPosition == null)
			{
				return;
			}
			frontCover.x = backCover.x = stage.mouseX - startPosition.x;
			frontCover.y = backCover.y = stage.mouseY - startPosition.y;
			if (testCoverGesture())
			{
				cover();
			}
		}

		private function testCoverGesture():Boolean
		{
			var dx:Number = frontCover.x - body.neck.x;
			var dy:Number = (body.neck.y + body.neck.height) - (frontCover.y+frontCover.height);
			return dx > -frontCover.width && dx < body.neck.width && dy > -20 && dy < body.neck.height;
		}

		public function showBase():void
		{
			addChildAt(base, 0);
		}

		public function hideBase():void
		{
			removeChild(base);
		}

		public function get baseShown():Boolean
		{
			return base.parent == this;
		}

		public function cover():void
		{
			frontCover.x = backCover.x = upperMarker.x;
			frontCover.y = backCover.y = upperMarker.y;
			_covered = true;
			stopBurning();
		}

		public function uncover():void
		{
			frontCover.x = backCover.x = lowerMarker.x;
			frontCover.y = backCover.y = lowerMarker.y + lowerMarker.height - frontCover.height;
			_covered = false;
			startBurning();
		}

		public override function get baseLine():MovieClip
		{
			return _baseLine;
		}

		private function startBurning():void
		{

		}

		private function stopBurning():void
		{

		}

	}

}