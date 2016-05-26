/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.group
{
    import ru.flashpress.animation.FPAnimation;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;
    import ru.flashpress.animation.instant.FPInstant;

    public class FPSequence extends FPGroup
    {
        use namespace nsFPAnimation;

        nsFPAnimation static var pool:FPPool;
        public static function create(...animationsList):FPSequence
        {
            var animation:FPSequence;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPSequence();
            }
            animation.init(animationsList);
            animation.initDuration = 0;
            return animation;
        }

        public static function createWithDuration(duration:Number, ...animationsList):FPSequence
        {
            var animation:FPSequence;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPSequence();
            }
            animation.init(animationsList);
            animation.initDuration = duration;
            return animation;
        }

        nsFPAnimation var initDuration:Number;
        private var durationsEnd:Vector.<int>;
        public function FPSequence()
        {
            super();
            //
            durationsEnd = new <int>[];
        }

        private var i1:int;
        private var anim1:FPAnimation;
        public override function begin():void
        {
            super.begin();
            //
            durationsEnd.length = 0;
            var dur:int = 0;
            for (i1=0; i1<count; i1++) {
                anim1 = list[i1];
                anim1.begin();
                dur += anim1._duration;
                durationsEnd.push(dur);
            }
            anim1 = null;
            this._duration = initDuration?initDuration:dur;
        }

        private var i2:int;
        private var anim2:FPAnimation;
        private var temp:Number;
        nsFPAnimation override function applyPosition(position:Number):void
        {
            if (this._position == position) return;
            //
            var _time:Number = this._duration*position;
            //
            var end:int;
            var begin:int = 0;
            for (i2=0; i2<count; i2++) {
                end = durationsEnd[i2];
                anim2 = list[i2];
                //
                if (_time >= end) {
                    temp = 1;
                    if (anim2._flags & FPAnimFlags.INSTANT && !(anim2 as FPInstant)._activated) {
                        (anim2 as FPInstant).activate();
                    }
                } else if (_time > begin) {
                    temp = (_time-begin)/(anim2._duration?anim2._duration:super._duration);
                } else {
                    temp = 0;
                }
                //if (Math.abs(anim2._percent-temp) >= E) {
                if (anim2._position != temp) {
                    if (!anim2._beginForSequence) {
                        anim2.beginForSequence();
                    }
                    anim2.applyPosition(temp);
                }
                begin = end;
            }
            anim2 = null;
            //
            super.applyPosition(position);
        }

        public override function release():void
        {
            super.release();
            //
            durationsEnd.length = 0;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
