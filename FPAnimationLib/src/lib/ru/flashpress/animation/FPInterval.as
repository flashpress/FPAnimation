/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation
{
    import flash.events.Event;
    import flash.utils.getTimer;

    import ru.flashpress.animation.core.FPPool;

    import ru.flashpress.animation.core.constants.FPAnimFlags;

    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPInterval extends FPAnimation
    {
        use namespace nsFPAnimation;
        //
        public function FPInterval()
        {
            super();
            _flags |= FPAnimFlags.INTERVAL;
            //
            completeCallbacks = new <CallbackInfo>[];
            changeCallbacks = new <CallbackInfo>[];
        }


        protected var _previousTime:Number;
        protected var _elapsed:Number;
        private var tempPercent:Number;
        private function frameHandler(event:Event=null):void
        {
            if (_released) {
                return;
            }
            _elapsed += getTimer()-_previousTime;
            _previousTime = getTimer();
            if (_elapsed > _duration) _elapsed = _duration;
            tempPercent = _elapsed/_duration;
            applyPosition(tempPercent);
            //
            if (_elapsed == _duration) {
                complete();
            }
        }

        nsFPAnimation function updatePercent(percent:Number):void
        {
            if (percent < 0) percent = 0;
            if (percent > 1) percent = 1;
            //
            applyPosition(percent);
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (changeCallbacks.length) {
                var i:int;
                var callback:CallbackInfo;
                for (i=0; i<changeCallbacks.length; i++) {
                    callback = changeCallbacks[i];
                    switch (callback.paramsCount) {
                        case 0:
                            callback.call();
                            break;
                        case 1:
                            callback.call(_position);
                            break;
                        case 2:
                            callback.call(_position, _elapsed);
                            break;
                        case 3:
                            callback.call(this, _position, _elapsed);
                            break;
                    }
                }
            }
        }

        protected function beginPlay():void
        {
            _previousTime = getTimer();
            _elapsed = 0;
        }

        protected function complete():void
        {
            if (completeCallbacks.length) {
                var i:int;
                var callback:CallbackInfo;
                for (i=0; i<completeCallbacks.length; i++) {
                    callback = completeCallbacks[i];
                    switch (callback.paramsCount) {
                        case 0:
                            callback.call();
                            break;
                        case 1:
                            callback.call(this);
                            break;
                    }
                }
            }
            //
            _played = false;
            stage.removeEventListener(Event.ENTER_FRAME, frameHandler);
            //
            if (this._autoreleased) {
                this.release();
            }
        }

        public override function begin():void
        {
            super.begin();
        }

        protected var changeCallbacks:Vector.<CallbackInfo>;
        public function registerChangeCallback(callback:Function, thisTarget:*=null):void
        {
            changeCallbacks.push(CallbackInfo.create(callback, thisTarget));
        }
        private var completeCallbacks:Vector.<CallbackInfo>;
        public function registerCompleteCallback(callback:Function, thisTarget:*=null):void
        {
            completeCallbacks.push(CallbackInfo.create(callback, thisTarget));
        }

        public override function set duration(value:int):void
        {
            super.duration = value;
            _elapsed = _duration*_position;
            _previousTime = getTimer();
        }

        private var _played:Boolean;
        public function get played():Boolean {return this._played;}

        public function play():void
        {
            this.begin();
            this.beginPlay();
            this._played = true;
            stage.addEventListener(Event.ENTER_FRAME, frameHandler);
            this.applyPosition(0);
            this.frameHandler();
        }

        public function stop():void
        {
            _played = false;
            stage.removeEventListener(Event.ENTER_FRAME, frameHandler);
        }

        private var _paused:Boolean;
        public function get paused():Boolean {return this._paused;}

        public function pause():void
        {
            if (_played) {
                _paused = true;
                stage.removeEventListener(Event.ENTER_FRAME, frameHandler);
            }
        }
        public function resume():void
        {
            _paused = false;
            if (_played) {
                _previousTime = getTimer();
                stage.addEventListener(Event.ENTER_FRAME, frameHandler);
                frameHandler();
            }
        }

        public function togglePause():void
        {
            if (_paused) {
                resume();
            } else {
                pause();
            }
        }

        public function updatePercentAndStop(percent:Number):void
        {
            if (percent < 0) percent = 0;
            if (percent > 1) percent = 1;
            //
            _elapsed = _duration*percent;
            _previousTime = getTimer();
            _played = true;
            _paused = false;
            applyPosition(percent+E);
            //
            stop();
        }

        public function updatePercentAndPlay(percent:Number):void
        {
            if (percent < 0) percent = 0;
            if (percent > 1) percent = 1;
            //
            _elapsed = _duration*percent;
            _previousTime = getTimer();
            _played = true;
            _paused = false;
            stage.addEventListener(Event.ENTER_FRAME, frameHandler);
            applyPosition(percent+E);
            frameHandler();
        }
        public function updateTimeAndPlay(time:int):void
        {
            if (time < 0) time = 0;
            if (time > _duration) time = _duration;
            _elapsed = time;
            _previousTime = getTimer();
            _played = true;
            stage.addEventListener(Event.ENTER_FRAME, frameHandler);
            applyPosition(_elapsed/_duration+E);
            frameHandler();
        }

        public override function release():void
        {
            super.release();
            //
            if (changeCallbacks.length) for (var i:int=0; i <changeCallbacks.length; i++) changeCallbacks[i].release();
            changeCallbacks.length = 0;
            //
            if (completeCallbacks.length) for (i=0; i <completeCallbacks.length; i++) completeCallbacks[i].release();
            completeCallbacks.length = 0;
            //
            _played = false;
            _previousTime = 0;
            _elapsed = 0;
            stage.removeEventListener(Event.ENTER_FRAME, frameHandler);
        }
    }
}


class CallbackInfo
{
    private static var pool:Vector.<CallbackInfo> = new <CallbackInfo>[];
    public static function create(func:Function, thisTarget:*):CallbackInfo
    {
        var info:CallbackInfo;
        if (pool.length) {
            info = pool.shift();
        } else {
            info = new CallbackInfo();
        }
        info.func = func;
        info.thisTarget = thisTarget;
        info.paramsCount = func.length;
        return info;
    }

    public var func:Function;
    public var thisTarget:*;
    public var paramsCount:int;
    public function CallbackInfo()
    {
    }

    public function call(...args):void
    {
        func.apply(thisTarget, args);
    }

    public function release():void
    {
        this.func = null;
        this.thisTarget = null;
        pool.push(this);
    }
}