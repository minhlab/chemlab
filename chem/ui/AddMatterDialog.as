package chem.ui {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	
	
	public class AddMatterDialog extends MovieClip {
		
		private var okCallback;
		private var cancelCallback;
		public function AddMatterDialog() {
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			okBtn.addEventListener(MouseEvent.CLICK, onOkClicked);
			cancelBtn.addEventListener(MouseEvent.CLICK, onCancelClicked);
		}
		
		public function onKeyDown(evt : KeyboardEvent) {
			if (evt.charCode == 13) {
				onOkClicked(null);
			}
		}

		public function onOkClicked(evt: MouseEvent)
		{
			if (parseInt(this.input.text) is Number){
				close();
				okCallback(this);
			}
		}

		public function onCancelClicked(evt: MouseEvent)
		{
			close();
			cancelCallback(this);
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
			input.setFocus();
		}
		
		public function get amount():Number{
			return parseInt(this.input.text);
		}
	}
	
}
