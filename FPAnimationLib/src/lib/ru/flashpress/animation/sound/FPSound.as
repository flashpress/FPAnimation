/**
 * Created by sam on 08.11.15.
 */
package ru.flashpress.animation.sound
{
    import flash.media.SoundChannel;
    import flash.media.SoundMixer;
    import flash.media.SoundTransform;
    import flash.utils.getTimer;

    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPSound extends FPInterval
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        private static function create(duration:int=0):FPSound
        {
            var animation:FPSound;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPSound();
            }
            animation._duration = duration;
            animation.chanel = null;
            return animation;
        }

        public static function createVolumeTo(to:Number, duration:int=0):FPSound
        {
            var animation:FPSound = create(duration);
            animation.toVolume = to;
            animation.soundFlags = VOLUME;
            animation._relatively = true;
            return animation;
        }

        public static function createVolumeFromTo(from:Number=0, to:Number=1, duration:int=0):FPSound
        {
            var animation:FPSound = create(duration);
            animation.fromVolume = from;
            animation.toVolume = to;
            animation.soundFlags = VOLUME;
            return animation;
        }

        public static function createPanFromTo(from:Number=-1, to:Number=1, duration:int=0):FPSound
        {
            var animation:FPSound = create(duration);
            animation.fromPan = from;
            animation.toPan = to;
            animation.soundFlags = PAN;
            return animation;
        }
        public static function createPanTo(to:Number, duration:int=0):FPSound
        {
            var animation:FPSound = create(duration);
            animation.toPan = to;
            animation.soundFlags = PAN;
            animation._relatively = true;
            return animation;
        }

        private static var VOLUME:int = 0x1;
        private static var PAN:int = 0x2;

        private var soundFlags:int;

        protected var chanel:SoundChannel;
        protected var toVolume:Number;
        protected var fromVolume:Number;
        protected var toPan:Number;
        protected var fromPan:Number;
        //
        protected var _transform:SoundTransform;
        nsFPAnimation var _relatively:Boolean;
        public function FPSound()
        {
            super();
            _flags |= FPAnimFlags.SOUND;
            _transform = new SoundTransform();
        }

        protected override function reinit():void
        {
            _relatively = false;
            _pan = 0;
            _volume = 0;
        }

        public function get transform():SoundTransform {return this._transform;}

        private var _pan:Number = 0;
        public function set pan(value:Number):void
        {
            _pan = value;
            _transform.pan = _pan;
        }
        private var _volume:Number = 1;
        public function set volume(value:Number):void
        {
            _volume = value;
            _transform.volume = _volume;
        }

        public override function begin():void
        {
            super.begin();
            //
            _transform.pan = _pan;
            _transform.volume = _volume;
            chanel = target ? target as SoundChannel : null;
            //
            if (this._relatively) {
                if (chanel) {
                    fromVolume = chanel.soundTransform.volume;
                    fromPan = chanel.soundTransform.pan;
                } else {
                    fromVolume = SoundMixer.soundTransform.volume;
                    fromPan = SoundMixer.soundTransform.pan;
                }
            }
        }


        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (soundFlags & VOLUME) _transform.volume = fromVolume + (toVolume-fromVolume)*position + _wave;
            if (soundFlags & PAN) _transform.pan = fromPan + (toPan-fromPan)*position + _wave;
            if (chanel) {
                chanel.soundTransform = _transform;
            } else {
                SoundMixer.soundTransform = _transform;
            }
        }

        public override function release():void
        {
            super.release();
            //
            chanel = null;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
