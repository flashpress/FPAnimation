/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.modify {
    import ru.flashpress.animation.*;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPReverse extends FPModify
    {
        use namespace nsFPAnimation;

        nsFPAnimation static var pool:FPPool;
        public static function create(animation:FPInterval, duration:int=0):FPReverse
        {
            var _animation:FPReverse;
            if (pool && pool.length) {
                _animation = pool.shift();
            } else {
                _animation = new FPReverse();
            }
            _animation.initModify(animation, duration);
            return _animation;
        }

        public function FPReverse()
        {
            super();
            this.noApplyToAnim = true;
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(1-position);
            _animation.applyPosition(1-position);
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
