/**
 * Created by sam on 09.11.15.
 */
package ru.flashpress.animation {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPTimeout extends FPInterval
    {
        use namespace nsFPAnimation;
        nsFPAnimation static var pool:FPPool;
        public static function create(duration:int):FPTimeout
        {
            var _animation:FPTimeout;
            if (pool && pool.length) {
                _animation = pool.shift();
            } else {
                _animation = new FPTimeout();
            }
            _animation._duration = duration;
            //
            return _animation;
        }
        public function FPTimeout()
        {
            super();
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
