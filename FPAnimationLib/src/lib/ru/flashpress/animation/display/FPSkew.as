/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.display {
    import flash.geom.Matrix;

    import ru.flashpress.animation.FPProperty;

    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPSkew extends FPDisplay
    {
        use namespace nsFPAnimation;
        private static var pool:FPPool;
        public static function createTo(toX:Number, toY:Number, duration:Number=0):FPSkew
        {
            var animation:FPSkew;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPSkew();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation._duration = duration;
            animation.toX = toX;
            animation.toY = toY;
            return animation;
        }
        public static function createFromTo(fromX:Number, fromY:Number,
                                            toX:Number, toY:Number,
                                            duration:Number=0):FPSkew
        {
            var animation:FPSkew;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPSkew();
            }
            animation._propertyFlags = 0;
            animation._duration = duration;
            animation.fromX = fromX;
            animation.fromY = fromY;
            animation.toX = toX;
            animation.toY = toY;
            return animation;
        }

        protected var toX:Number;
        protected var toY:Number;
        protected var fromX:Number;
        protected var fromY:Number;
        public function FPSkew()
        {
            super();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            var matrix:Matrix = currentTarget.transform.matrix;
            matrix.c = fromX + (toX-fromX)*position + _wave;
            matrix.b = fromY + (toY-fromY)*position + _wave;
            currentTarget.transform.matrix = matrix;
        }

        protected override function initFromValue():void
        {
            var matrix:Matrix = currentTarget.transform.matrix;
            fromX = matrix.c;
            fromY = matrix.b;
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
