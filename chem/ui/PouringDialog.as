package chem.ui {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class PouringDialog extends MovieClip {
		
		private var okCallback;
		private var cancelCallback;
		
		public function PouringDialog() {
			x = 30;
			y = 20;
			okBtn.addEventListener(MouseEvent.MOUSE_UP, onOk);
			cancelBtn.addEventListener(MouseEvent.MOUSE_UP, onCancel);
//			percentSlider.addEventListener(MouseEvent.MOUSE_DOWN, sliderOnMouseDown);
		//	percentSlider.addEventListener(MouseEvent.MOUSE_UP, sliderOnMouseUp);
			//percentSlider.addEventListener(MouseEvent.MOUSE_MOVE, sliderOnMouseMove);
			percentTxt.addEventListener(Event.CHANGE, percentTxtOnChange);
			percentSlider.addEventListener(Event.CHANGE, percentSliderOnChange);
		}
		
		public function percentTxtOnChange(event:Event):void {
			percentSlider.value = int(percentTxt.text);
		}
		
		public function percentSliderOnChange(event:Event):void {
			percentTxt.text = percentSlider.value.toString();
		}
		
		public function onOk(evt: MouseEvent) {
			trace("ok");
			close();
			okCallback(this);
		}
		
		public function onCancel(evt: MouseEvent) {
			trace("cancel");
			close();
			cancelCallback(this);
		}
		
		public function show(okCallback, cancelCallback) {
			this.okCallback = okCallback;
			this.cancelCallback = cancelCallback;
			Main.instance.addChild(this);
		}
		
		public function close() {
			parent.removeChild(this);
		}
		
	}
	
}
