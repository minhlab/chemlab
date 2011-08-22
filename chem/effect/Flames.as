package chem.effect
	{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Matrix;
	
	import flash.system.LoaderContext;
	import flash.net.SharedObject;
	import flash.net.URLRequest;

	
	public class Flames extends MovieClip {
		
		private static const ZERO_POINT:Point = new Point();

		protected	var _definition:uint;
		protected	var _cooling:Number;
		private		var _scale:Number;
		protected	var _paletteId:uint = 0;
		private		var _fireDy:Number = 3.0;//3
		private		var _fireDx:Number = 0.0;//0
		private		var _fireVy:Number = 3.0;//4
		private		var _fireVx:Number = 0.1;//0.1
		protected	var _isOn:Boolean = true;
		
		private		var _wo:uint;
		private		var _ho:uint;
		
		
		private		var _paletteBmp:BitmapData;
		private		var _greyBmp:BitmapData;
		private		var _fireBmp:BitmapData;
		private		var _coolingBmp:BitmapData;

		private		var _spreadFilter:ConvolutionFilter;
		private		var _toWhiteFilter:ColorTransform;
		private		var _colorFilter:ColorMatrixFilter;
	
		private		var _offset:Array = [new Point(), new Point()];
		private		var _palette:Array;
		private		var _zeroArray:Array;

		protected	var _objToBurn:DisplayObject;


		public function Flames(objToBurn:DisplayObject,cooling:Number,scale:Number,definition:uint,flameColor:uint) {
			_objToBurn	= objToBurn;
			_scale		= scale;
			_cooling	= cooling;
			_definition	= definition;
			_paletteId = flameColor;
			
			setCooling();			// set fire cooling
			loadPalette();			// load fire color palette
		}



		private function loadPalette():void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, paletteLoaded);
			loader.load(new URLRequest("flamesPallete.swf"));
		}


		private function paletteLoaded(e:Event):void {
			var _palette:*	= LoaderInfo(e.target).loader.content;

			_palette.gotoAndStop(2);
			_paletteBmp 	= new BitmapData( _palette.width , _palette.height , false, 0xff000000 );
			_paletteBmp.draw(_palette);

			setPalette();

			createFlames();
		}


		private function createFlames():void {
			_fireDx *= _scale;
			_fireDy *= _scale;

			blendMode		= 'add';

			scaleX 			= 1/_scale;
			scaleY 			= 1/_scale;

			_wo				= _objToBurn.width*2;
			_ho				= _objToBurn.height*3;

			_greyBmp		= new BitmapData( _wo * _scale , _ho * 2 * _scale , true,  0x808080	);
			_coolingBmp		= new BitmapData( _wo * _scale , _ho * 2 * _scale , false, 0x000000	);
			_fireBmp 		= new BitmapData( _wo * _scale , _ho * 2 * _scale , false, 0xff000000	);

			_spreadFilter	= new ConvolutionFilter(3, 3, [0, 1, 0,  1, 1, 1,  0, 1, 0], 5);
			_toWhiteFilter	= new ColorTransform(0, 0, 0, 0.5 , 255, 255, 255, 50 );

			// set fire over the object
			x = _objToBurn.x - _wo/4;
			y = _objToBurn.y - _ho*1.5 + _fireDy;

			// add the object
			addChild( new Bitmap( _fireBmp, 'never', true ) );

			// events
			addEventListener(Event.ENTER_FRAME, update);
		}


		private function setCooling():void {
			var a:Number		= _cooling;
			this._colorFilter	= new ColorMatrixFilter([
														a, 0, 0, 0, 0,
														0, a, 0, 0, 0,
														0, 0, a, 0, 0,
														0, 0, 0, 1, 0
													]);
		}
		
		
		public function setPalette():void {
			var n:uint	= 256;

			_palette	= [];
			_zeroArray	= [];

			while (--n>-1) {
				_palette[n]		= _paletteBmp.getPixel(n, _paletteId * 30);
				_zeroArray[n]	= 0;
			}
		}


		private function update(e:Event):void {
			// falmes source		
			var matrix:Matrix = new Matrix;
			
			matrix.translate( _wo/4 , _ho*1.5 );
			matrix.scale(_scale,_scale)
			
			// fire source
			if (this._isOn) {
				_greyBmp.draw( _objToBurn , matrix , _toWhiteFilter);
				_greyBmp.applyFilter(_greyBmp, _greyBmp.rect, ZERO_POINT, _spreadFilter);
			}

			// perlin noise
			this._coolingBmp.perlinNoise( 30/*30*/ , 80, _definition , 100 , false, false, 0, true, this._offset);
			this._offset[0].x += _fireVx;
			this._offset[1].y += _fireVy;

			// substract perlin noise
			this._coolingBmp.applyFilter(this._coolingBmp, this._coolingBmp.rect, ZERO_POINT, this._colorFilter);
			this._greyBmp.draw(this._coolingBmp, null, null, BlendMode.SUBTRACT);

			// move fire
			this._greyBmp.scroll( _fireDx , - _fireDy );

			// draw fire
			this._fireBmp.paletteMap(this._greyBmp, this._greyBmp.rect, ZERO_POINT, this._palette , this._zeroArray, this._zeroArray, this._zeroArray);
		}


		public function stopFire():void {
			this._isOn = false;
		}


		public function startFire():void {
			this._isOn = true;
		}


		// set / get function
		public function set paletteId(newPalette:uint):void {
			_paletteId = newPalette % (_paletteBmp.height / 30);

			setPalette();
		}

		public function get paletteId():uint {
			return _paletteId;
		}


		public function get cooling():Number {
			return _cooling;
		}

		public function set cooling(newCooling:Number):void {
			_cooling = newCooling;
			setCooling();
		}

		public function get definition():Number {
			return _definition;
		}

		public function set definition(newDefinition:Number):void {
			_definition = newDefinition;
		}			
	}
}