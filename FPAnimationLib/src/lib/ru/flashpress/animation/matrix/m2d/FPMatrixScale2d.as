/**
 * Created by sam on 21.11.15.
 */
package ru.flashpress.animation.matrix.m2d {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMatrixScale2d extends FPMatrixItem2d
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function createDynamic(fromX:Number, fromY:Number,
                                             toX:Number, toY:Number,
                                             duration:Number=0):FPMatrixScale2d
        {
            var animation:FPMatrixScale2d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixScale2d();
            }
            animation._duration = duration;
            animation.fromX = fromX;
            animation.fromY = fromY;
            animation.toX = toX;
            animation.toY = toY;
            animation.isStatic = false;
            return animation;
        }

        public static function createStatic(toX:Number, toY:Number, duration:Number=0):FPMatrixScale2d
        {
            var animation:FPMatrixScale2d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixScale2d();
            }
            animation._duration = duration;
            animation.toX = toX;
            animation.toY = toY;
            animation.isStatic = true;
            return animation;
        }

        private var fromX:Number;
        private var fromY:Number;
        private var toX:Number;
        private var toY:Number;
        public function FPMatrixScale2d()
        {

        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (!isStatic) {
                matrix.scale(fromX + (toX - fromX) * position + _wave, fromY + (toY - fromY) * position + _wave);
            } else {
                matrix.scale(toX + _wave, toY + _wave);
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
