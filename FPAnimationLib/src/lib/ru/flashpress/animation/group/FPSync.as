/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.group {
    import ru.flashpress.animation.FPAnimation;
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;
    import ru.flashpress.animation.instant.FPInstant;

    public class FPSync extends FPGroup
    {
        use namespace nsFPAnimation;

        internal static var pool:FPPool;
        public static function create(...animationsList):FPSync
        {
            var animation:FPSync;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPSync();
            }
            animation.init(animationsList);
            animation.initDuration = 0;
            return animation;
        }
        public static function createWithDuration(duration:Number, ...animationsList):FPSync
        {
            var animation:FPSync;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPSync();
            }
            animation.init(animationsList);
            animation.initDuration = duration;
            return animation;
        }

        internal var initDuration:Number;
        public function FPSync()
        {
            super();
        }

        private var i1:int;
        private var anim1:FPAnimation;
        public override function begin():void
        {
            super.begin();
            //
            var dur:int = 0;
            for (i1=0; i1<count; i1++) {
                anim1 = list[i1];
                anim1.begin();
                dur = Math.max(dur, anim1._duration);
            }
            anim1 = null;
            this._duration = initDuration?initDuration:dur;
        }

        private var i2:int;
        private var anim2:FPAnimation;
        nsFPAnimation override function applyPosition(position:Number):void
        {
            var _time:Number = this._duration*position;
            //
            for (i2=0; i2<count; i2++) {
                anim2 = list[i2];
                if (anim2._flags & FPAnimFlags.INTERVAL) {
                    //anim2.applyPosition(_time/(anim2._duration?anim2._duration:super._duration));
                    (anim2 as FPInterval).updatePercent(_time / (anim2._duration ? anim2._duration : super._duration));
                } else if (anim2._flags & FPAnimFlags.INSTANT) {
                    if (!(anim2 as FPInstant)._activated) {
                        (anim2 as FPInstant).activate();
                    }
                }
            }
            anim2 = null;
            //
            super.applyPosition(position);
        }

        public override function release():void
        {
            super.release();
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
