package chem.ui {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import chem.objects.LiquidContainer;
	
	public class PouringDialog extends MovieClip {
		
		private var okCallback;
		private var cancelCallback;
		private var sender:LiquidContainer, receiver:LiquidContainer;
		
		public function PouringDialog(sender:LiquidContainer, receiver:LiquidContainer) {
			this.sender = sender;
			this.receiver = receiver;
			
			x = 30;
			y = 20;
			okBtn.addEventListener(MouseEvent.MOUSE_UP, onOk);
			cancelBtn.addEventListener(MouseEvent.MOUSE_UP, onCancel);
//			percentSlider.addEventListener(MouseEvent.MOUSE_DOWN, sliderOnMouseDown);
//			percentSlider.addEventListener(MouseEvent.MOUSE_UP, sliderOnMouseUp);
//			percentSlider.addEventListener(MouseEvent.MOUSE_MOVE, sliderOnMouseMove);
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			percentTxt.addEventListener(Event.CHANGE, percentTxtOnChange);
			percentSlider.addEventListener(Event.CHANGE, percentSliderOnChange);
			
			errorTxt.visible = false;
		}
		
		public function onKeyDown(evt : KeyboardEvent) {
			if (evt.charCode == 13) {
				onOk(null);
			}
		}
		
		public function percentTxtOnChange(event:Event):void {
			percentSlider.value = int(percentTxt.text);
			validate();
		}
		
		public function percentSliderOnChange(event:Event):void {
			percentTxt.text = percentSlider.value.toString();
			validate();
		}
		
		private function validate():Boolean {
			if (receiver.liquid.nonGasVolume + sender.liquid.nonGasVolume * 
				(percentSlider.value/100) > receiver.volume) {
				errorTxt.visible = true;
				return false;
			}
			errorTxt.visible = false;
			return true;
		}
		
		public function onOk(evt: MouseEvent) {
			if (!validate()) {
				return;
			}
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
			percentTxt.text = percentSlider.value.toString();
			Main.instance.addChild(this);
			percentTxt.setFocus();
		}
		
		public function close() {
			parent.removeChild(this);
		}
		
		public function get percent():int {
			return percentSlider.value;
		}
		
	}
	
}
