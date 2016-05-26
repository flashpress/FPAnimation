/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.instant {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPVisible extends FPInstant
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(visible:Boolean):FPVisible
        {
            var animation:FPVisible;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPVisible();
            }
            animation.visibleValue = visible;
            return animation;
        }
        public static function hide():FPVisible
        {
            return create(false);
        }
        public static function show():FPVisible
        {
            return create(true);
        }

        public function FPVisible()
        {
            super();
        }

        private var visibleValue:Boolean;
        public override function activate():void
        {
            super.activate();
            //
            currentTarget.visible = visibleValue;
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
