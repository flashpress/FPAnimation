/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.display
{
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPRotate extends FPDisplay
    {
        use namespace nsFPAnimation;

        internal static var pool:FPPool;
        public static function createTo(toRotate:Number, duration:Number=0):FPRotate
        {
            var animation:FPRotate;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPRotate();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation.toRotate = toRotate;
            animation._duration = duration;
            return animation;
        }
        public static function createFromTo(fromRotate:Number, toRotate:Number, duration:Number=0):FPRotate
        {
            var animation:FPRotate;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPRotate();
            }
            animation._propertyFlags = 0;
            animation.fromRotate = fromRotate;
            animation.toRotate = toRotate;
            animation._duration = duration;
            return animation;
        }

        internal var toRotate:Number;
        internal var fromRotate:Number;
        public function FPRotate()
        {
            super();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            currentTarget["rotation"] = fromRotate + (toRotate-fromRotate)*position + _wave;
        }

        protected override function initFromValue():void
        {
            fromRotate = currentTarget["rotation"];
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
