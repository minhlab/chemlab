﻿package chem.objects
{

	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	public class Equipment extends MovieClip
	{

		public function Equipment()
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, InteractionProvider.equipmentOnMouseDown);
		}

	}

}