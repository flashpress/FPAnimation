/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.instant
{

    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPRemoveFromParent extends FPInstant
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create():FPRemoveFromParent
        {
            var animation:FPRemoveFromParent;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPRemoveFromParent();
            }
            return animation;
        }

        public function FPRemoveFromParent()
        {
            super();
        }

        public override function activate():void
        {
            super.activate();
            //
            if (currentTarget.parent) {
                currentTarget.parent.removeChild(currentTarget);
            }
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
