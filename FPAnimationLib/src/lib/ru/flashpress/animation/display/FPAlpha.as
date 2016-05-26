/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPAlpha extends FPDisplay
    {
        use namespace nsFPAnimation;

        internal static var pool:FPPool;

        public static function createFromTo(fromAlpha:Number, toAlpha:Number, duration:Number=0):FPAlpha
        {
            var animation:FPAlpha;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPAlpha();
            }
            animation._propertyFlags = 0;
            animation.fromAlpha = fromAlpha;
            animation.toAlpha = toAlpha;
            animation._duration = duration;
            return animation;
        }

        public static function createTo(toAlpha:Number, duration:Number):FPAlpha
        {
            var animation:FPAlpha;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPAlpha();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation.toAlpha = toAlpha;
            animation._duration = duration;
            return animation;
        }

        public static function show(duration:Number=0):FPAlpha
        {
            var animation:FPAlpha;
            if (pool && pool.length) {
                animation = pool.shift() as FPAlpha;
            } else {
                animation = new FPAlpha();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation.toAlpha = 1;
            animation._duration = duration;
            return animation;
        }
        public static function hide(duration:Number=0):FPAlpha
        {
            var animation:FPAlpha;
            if (pool && pool.length) {
                animation = pool.shift() as FPAlpha;
            } else {
                animation = new FPAlpha();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation.toAlpha = 0;
            animation._duration = duration;
            return animation;
        }

        internal var fromAlpha:Number;
        internal var toAlpha:Number;
        public function FPAlpha()
        {
            super();
        }

        protected override function initFromValue():void
        {
            fromAlpha = currentTarget["alpha"];
        }

        private var _temp:Number;
        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            _temp = fromAlpha + (toAlpha-fromAlpha)*position + _wave;
            if (_temp < 0) _temp = 0;
            if (_temp > 1) _temp = 1;
            currentTarget["alpha"] = _temp;
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
