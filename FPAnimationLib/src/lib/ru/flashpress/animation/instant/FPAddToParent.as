/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.instant
{

    import ru.flashpress.animation.core.FPPool;

    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPAddToParent extends FPInstant
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(target:*):FPAddToParent
        {
            var animation:FPAddToParent;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPAddToParent();
            }
            animation._target = target;
            return animation;
        }

        private var _target:*;
        public function FPAddToParent()
        {
            super();
        }

        public override function activate():void
        {
            super.activate();
            //
            if (_target) {
                _target.addChild(currentTarget);
            }
        }

        public override function release():void
        {
            super.release();
            _target = null;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
