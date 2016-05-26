/**
 * Created by sam on 21.11.15.
 */
package ru.flashpress.animation.matrix.m2d {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMatrixRotate2d extends FPMatrixItem2d
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function createDynamic(fromRotate:Number, toRotate:Number, duration:Number=0):FPMatrixRotate2d
        {
            var animation:FPMatrixRotate2d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixRotate2d();
            }
            animation._duration = duration;
            animation.fromRotate = fromRotate;
            animation.toRotate = toRotate;
            animation.isStatic = false;
            return animation;
        }
        public static function createStatic(fromRotate:Number, toRotate:Number, duration:Number=0):FPMatrixRotate2d
        {
            var animation:FPMatrixRotate2d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixRotate2d();
            }
            animation._duration = duration;
            animation.fromRotate = fromRotate;
            animation.toRotate = toRotate;
            animation.isStatic = true;
            return animation;
        }

        private var fromRotate:Number;
        private var toRotate:Number;
        public function FPMatrixRotate2d()
        {

        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (!isStatic) {
                matrix.rotate(fromRotate + (toRotate - fromRotate) * position + _wave);
            } else {
                matrix.rotate(toRotate + _wave);
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
