/**
 * Created by sam on 21.11.15.
 */
package ru.flashpress.animation.matrix.m2d {
    import flash.geom.Matrix;

    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMatrixSkew2d extends FPMatrixItem2d
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function createDynamic(fromX:Number, fromY:Number,
                                             toX:Number, toY:Number,
                                             duration:Number=0):FPMatrixSkew2d
        {
            var animation:FPMatrixSkew2d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixSkew2d();
            }
            animation._duration = duration;
            animation.fromX = fromX;
            animation.fromY = fromY;
            animation.toX = toX;
            animation.toY = toY;
            animation.isStatic = false;
            return animation;
        }

        public static function createStatic(toX:Number, toY:Number, duration:Number=0):FPMatrixSkew2d
        {
            var animation:FPMatrixSkew2d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixSkew2d();
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
        private var skewMatrix:Matrix;
        public function FPMatrixSkew2d()
        {
            skewMatrix = new Matrix();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (!isStatic) {
                skewMatrix.c = fromX + (toX-fromX)*position + _wave;
                skewMatrix.b = fromY + (toY-fromY)*position + _wave;
            } else {
                skewMatrix.c = toX + _wave;
                skewMatrix.b = toY + _wave;
            }
            matrix.concat(skewMatrix);
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
