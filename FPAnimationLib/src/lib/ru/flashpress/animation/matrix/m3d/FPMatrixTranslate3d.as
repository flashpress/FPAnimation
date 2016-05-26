/**
 * Created by sam on 21.11.15.
 */
package ru.flashpress.animation.matrix.m3d
{
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMatrixTranslate3d extends FPMatrixItem3d
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function createDynamic(fromX:Number, fromY:Number, fromZ:Number,
                                             toX:Number, toY:Number, toZ:Number,
                                             append:Boolean=true, duration:Number=0):FPMatrixTranslate3d
        {
            var animation:FPMatrixTranslate3d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixTranslate3d();
            }
            animation._duration = duration;
            animation.isStatic = false;
            animation.isAppend = append;
            animation.fromX = fromX;
            animation.fromY = fromY;
            animation.fromZ = fromZ;
            animation.toX = toX;
            animation.toY = toY;
            animation.toZ = toZ;
            return animation;
        }

        public static function createStatic(x:Number, y:Number, z:Number, append:Boolean=true):FPMatrixTranslate3d
        {
            var animation:FPMatrixTranslate3d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixTranslate3d();
            }
            animation._duration = 0;
            animation.isStatic = true;
            animation.isAppend = append;
            animation.toX = x;
            animation.toY = y;
            animation.toZ = z;
            return animation;
        }

        private var fromX:Number;
        private var fromY:Number;
        private var fromZ:Number;
        private var toX:Number;
        private var toY:Number;
        private var toZ:Number;
        public function FPMatrixTranslate3d()
        {

        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (!isStatic) {
                if (isAppend) {
                    matrix.appendTranslation(fromX + (toX - fromX) * position + _wave, fromY + (toY - fromY) * position + _wave, fromZ + (toZ - fromZ) * position + _wave);
                } else {
                    matrix.prependTranslation(fromX + (toX - fromX) * position + _wave, fromY + (toY - fromY) * position + _wave, fromZ + (toZ - fromZ) * position + _wave);
                }
            } else {
                if (isAppend) {
                    matrix.appendTranslation(toX + _wave, toY + _wave, toZ + _wave);
                } else {
                    matrix.prependTranslation(toX + _wave, toY + _wave, toZ + _wave);
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
