/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation {
    import flash.display.Stage;
    import flash.events.EventDispatcher;

    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPAnimation extends EventDispatcher
    {
        use namespace nsFPAnimation;
        nsFPAnimation static const E:Number = 0.0001;
        //
        protected static var stage:Stage;
        public static function init(stage:Stage):void
        {
            FPAnimation.stage = stage;
        }

        public static const VERSION:Number = 0.1;

        nsFPAnimation var _parent:FPAnimation;
        nsFPAnimation var _duration:int = 0;
        nsFPAnimation var _flags:int;
        private var _target:Object;
        public var proxy:Object;
        public function FPAnimation()
        {
            super();
            _flags = 0;
            _name = 'instance_'+(++instanceCount);
        }

        private static var instanceCount:int = 0;
        nsFPAnimation var _name:String;
        public function set name(value:String):void {this._name = value;}
        public function get name():String {return this._name;}

        final nsFPAnimation function create():void
        {
            this._wave = 0;
            this._duration = 0;
            this._released = false;
            this._autoreleased = false;
            this._beginForSequence = false;
            //
            reinit();
        }
        protected function reinit():void
        {

        }

        nsFPAnimation var _beginForSequence:Boolean;
        nsFPAnimation function beginForSequence():void
        {
            _beginForSequence = true;
        }

        nsFPAnimation var _wave:Number = 0;
        nsFPAnimation function setWave(wave:Number):void
        {
            this._wave = wave;
        }

        nsFPAnimation function applyPosition(position:Number):void
        {
            this._position = position;
        }

        protected var currentTarget:Object;
        public function get target():Object {return this._target}
        public function set target(value:Object):void
        {
            this._target = value;
        }

        public function get root():FPAnimation
        {
            var r:FPAnimation = this;
            while (r._parent) r = r._parent;
            return r;
        }

        public function begin():void
        {
            this._position = 0;
            /**
             * закоментировал потому что в методе FPProperty.beginForSequence
             * сперва super.beginForSequence() а потом begin()
             * в итоге _beginForSequence всегда = false,
             * и в методе FPSequence.applyPosition в строке кода
             * if (!anim2._beginForSequence) {
             * всегда false.
             *
             * UPD:
             * Надо убрать этот комент, потому что в таком случае
             * не сбрасывается _beginForSequence для анимаций в sequence.
             * Для решения предыдущей проблемы в методе FPProperty.beginForSequence
             * поменят местами строчки begin() и super.beginForSequence();
             */
            this._beginForSequence = false;
            currentTarget = _target;
            var p:FPAnimation = _parent;
            while (!currentTarget && p) {
                currentTarget = p._target;
                p = p._parent;
            }
        }

        public function get duration():int {return _duration;}
        public function set duration(value:int):void
        {
            this._duration = value;
        }

        public function updatePosition(position:Number):void
        {
            //trace('************ updatePercent ************', percent);
            if (position <= 0) {
                position = 0;
                this.applyPosition(E);
            }
            if (position > 1) position = 1;
            this.applyPosition(position);
        }
        public function updateTime(time:int):void
        {
            this._position = time/_duration;
            if (_position <= 0) {
                _position = 0;
                this.applyPosition(E);
            }
            if (_position > 1) _position = 1;
            this.applyPosition(_position);
        }

        nsFPAnimation var _position:Number = 0;
        public function get position():Number {return this._position;}

        public function get parent():FPAnimation {return this._parent;}

        nsFPAnimation var _released:Boolean;
        public function get released():Boolean {return this._released;}

        public function release():void
        {
            this._released = true;
            this._parent = null;
            this._beginForSequence = false;
            this._autoreleased = false;
            this._duration = 0;
            this._position = 0;
            //this._time = 0;
            this._target = null;
        }

        nsFPAnimation var _autoreleased:Boolean;
        public function get autoreleased():Boolean {return this._autoreleased;}

        public function autorelease():void
        {
            _autoreleased = true;
        }

        private var _toString:String;
        public override function toString():String
        {
            if (!_toString) {
                var temp:String = super.toString();
                temp = new RegExp("\\[object\\s([^\\]]+)\\]", 'g').exec(temp)[1];
                _toString = '['+temp+':'+this._name+']';
            }
            return _toString;
        }

    }
}
