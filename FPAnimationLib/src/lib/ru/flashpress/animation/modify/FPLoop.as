/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.modify {
    import ru.flashpress.animation.*;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;
    import ru.flashpress.animation.modify.FPModify;

    public class FPLoop extends FPModify
    {
        use namespace nsFPAnimation;

        nsFPAnimation static var pool:FPPool;
        public static function create(animation:FPInterval, count:int=0, duration:int=0):FPLoop
        {
            var _animation:FPLoop;
            if (pool && pool.length) {
                _animation = pool.shift();
            } else {
                _animation = new FPLoop();
            }
            _animation.count = count;
            _animation.initModify(animation, duration);
            return _animation;
        }

        nsFPAnimation var count:int;
        //
        private var repeatCount:int;
        public function FPLoop()
        {
            super();
            _flags |= FPAnimFlags.MODIFY;
        }

        protected override function complete():void
        {
            repeatCount++;
            if (count && repeatCount >= count) {
                super.complete();
            } else {
                updatePosition(0);
                begin(); // что бы сбросить FPInstant.activated
                beginPlay();
            }
        }

        public override function play():void
        {
            repeatCount = 0;
            super.play();
        }

        public override function stop():void
        {
            repeatCount = 0;
            super.stop();
        }

        public override function release():void
        {
            super.release();
            //
            repeatCount = 0;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
