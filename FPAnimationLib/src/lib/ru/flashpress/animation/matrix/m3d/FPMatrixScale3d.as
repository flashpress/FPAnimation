/**
 * Created by sam on 21.11.15.
 */
package ru.flashpress.animation.matrix.m3d
{
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMatrixScale3d extends FPMatrixItem3d
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function createDynamic(fromX:Number, fromY:Number, fromZ:Number,
                                             toX:Number, toY:Number, toZ:Number,
                                             append:Boolean=true, duration:Number=0):FPMatrixScale3d
        {
            var animation:FPMatrixScale3d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixScale3d();
            }
            animation._duration = duration;
            animation.fromX = fromX;
            animation.fromY = fromY;
            animation.fromZ = fromZ;
            animation.toX = toX;
            animation.toY = toY;
            animation.toX = toZ;
            animation.isStatic = false;
            animation.isAppend = append;
            return animation;
        }

        public static function createStatic(toX:Number, toY:Number, toZ:Number, append:Boolean=true, duration:Number=0):FPMatrixScale3d
        {
            var animation:FPMatrixScale3d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixScale3d();
            }
            animation._duration = duration;
            animation.toX = toX;
            animation.toY = toY;
            animation.toZ = toZ;
            animation.isStatic = true;
            animation.isAppend = append;
            return animation;
        }

        private var fromX:Number;
        private var fromY:Number;
        private var fromZ:Number;
        private var toX:Number;
        private var toY:Number;
        private var toZ:Number;
        public function FPMatrixScale3d()
        {

        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (!isStatic) {
                if (isAppend) {
                    matrix.appendScale(fromX + (toX - fromX) * position + _wave, fromY + (toY - fromY) * position + _wave, fromZ + (toZ - fromZ) * position + _wave);
                } else {
                    matrix.prependScale(fromX + (toX - fromX) * position + _wave, fromY + (toY - fromY) * position + _wave, fromZ + (toZ - fromZ) * position + _wave);
                }
            } else {
                if (isAppend) {
                    matrix.appendScale(toX + _wave, toY + _wave, toZ + _wave);
                } else {
                    matrix.prependScale(toX + _wave, toY + _wave, toZ + _wave);
                }
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
