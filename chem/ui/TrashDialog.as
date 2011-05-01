package chem.ui
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;


	public class TrashDialog extends MovieClip
	{

		private var okCallback;
		private var cancelCallback;

		public function TrashDialog()
		{
			okBtn.addEventListener(MouseEvent.CLICK, onOkClicked);
			cancelBtn.addEventListener(MouseEvent.CLICK, onCancelClicked);
		}

		public function onOkClicked(evt: MouseEvent)
		{
			close();
			okCallback();
		}

		public function onCancelClicked(evt: MouseEvent)
		{
			close();
			cancelCallback();
		}

		public function close() {
			parent.removeChild(this);
		}
	
		public function show(okCallback, cancelCallback)
		{
			this.okCallback = okCallback;
			this.cancelCallback = cancelCallback;
			x = 200;
			y = 100;
			Main.instance.addChild(this);
		}
	}

}