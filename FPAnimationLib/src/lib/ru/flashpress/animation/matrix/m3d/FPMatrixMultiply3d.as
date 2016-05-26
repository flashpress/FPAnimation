/**
 * Created by sam on 21.11.15.
 */
package ru.flashpress.animation.matrix.m3d
{
    import flash.geom.Matrix3D;

    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMatrixMultiply3d extends FPMatrixItem3d
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function createDynamic(fromMatrix:Matrix3D, toMatrix:Matrix3D, append:Boolean=true, duration:Number=0):FPMatrixMultiply3d
        {
            var animation:FPMatrixMultiply3d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixMultiply3d();
            }
            animation._duration = duration;
            animation.fromMatrix = fromMatrix;
            animation.toMatrix = toMatrix;
            animation.isStatic = false;
            animation.isAppend = append;
            return animation;
        }

        public static function createStatic(toMatrix:Matrix3D, append:Boolean=true, duration:Number=0):FPMatrixMultiply3d
        {
            var animation:FPMatrixMultiply3d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixMultiply3d();
            }
            animation._duration = duration;
            animation.toMatrix = toMatrix;
            animation.isStatic = true;
            animation.isAppend = append;
            return animation;
        }

        private var fromMatrix:Matrix3D;
        private var toMatrix:Matrix3D;
        public function FPMatrixMultiply3d()
        {

        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (!isStatic) {
                var res:Matrix3D = Matrix3D.interpolate(fromMatrix, toMatrix, position);
                if (isAppend) {
                    matrix.append(res);
                } else {
                    matrix.prepend(res);
                }
            } else {
                if (isAppend) {
                    matrix.append(toMatrix);
                } else {
                    matrix.prepend(toMatrix);
                }
            }
        }

        public override function release():void
        {
            super.release();
            //
            fromMatrix = null;
            toMatrix = null;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
