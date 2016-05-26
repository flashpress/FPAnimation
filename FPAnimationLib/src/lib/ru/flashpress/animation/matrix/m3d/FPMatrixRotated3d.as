/**
 * Created by sam on 21.11.15.
 */
package ru.flashpress.animation.matrix.m3d {
    import flash.geom.Vector3D;

    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMatrixRotated3d extends FPMatrixItem3d
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        private static function create(axis:*,  pivot:*,
                                       append:Boolean, duration:Number):FPMatrixRotated3d
        {
            var animation:FPMatrixRotated3d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrixRotated3d();
            }
            animation._duration = duration;
            animation.isAppend = append;
            animation.isStatic = false;
            //
            if (axis is Vector3D) {
                animation.axis = axis;
            } else {
                animation.axisAnimation = axis;
            }
            if (pivot is Vector3D) {
                animation.pivot = pivot;
            } else {
                animation.pivotAnimation = pivot;
            }
            return animation;
        }

        public static function createDynamic(fromRotate:Number, toRotate:Number,
                                             axis:*,  pivot:*,
                                             append:Boolean=true, duration:Number=0):FPMatrixRotated3d
        {
            var animation:FPMatrixRotated3d = create(axis, pivot, append, duration);
            animation.fromRotate = fromRotate;
            animation.toRotate = toRotate;
            animation.isStatic = false;
            return animation;
        }
        public static function createStatic(toRotate:Number,
                                            axis:*,  pivot:*,
                                            append:Boolean=true, duration:Number=0):FPMatrixRotated3d
        {
            var animation:FPMatrixRotated3d = create(axis, pivot, append, duration);
            animation.toRotate = toRotate;
            animation.isStatic = true;
            return animation;
        }

        private var fromRotate:Number;
        private var toRotate:Number;
        private var axis:Vector3D;
        private var axisAnimation:FPVector3D;
        private var pivot:Vector3D;
        private var pivotAnimation:FPVector3D;
        public function FPMatrixRotated3d()
        {

        }

        public override function begin():void
        {
            super.begin();
            //
            if (axisAnimation) axisAnimation.begin();
            if (pivotAnimation) pivotAnimation.begin();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            var a:Vector3D;
            if (axis) {
                a = axis;
            } else {
                axisAnimation.applyPosition(position);
                a = axisAnimation._vector;
            }
            //
            var p:Vector3D;
            if (pivot) {
                p = pivot;
            } else {
                pivotAnimation.applyPosition(position);
                p = pivotAnimation._vector;
            }
            //
            if (!isStatic) {
                if (isAppend) {
                    matrix.appendRotation(fromRotate + (toRotate - fromRotate) * position + _wave, a, p);
                } else {
                    matrix.prependRotation(fromRotate + (toRotate - fromRotate) * position + _wave, a, p);
                }
            } else {
                if (isAppend) {
                    matrix.appendRotation(toRotate  + _wave, a, p);
                } else {
                    matrix.prependRotation(toRotate + _wave, a, p);
                }
            }
        }

        public override function release():void
        {
            super.release();
            //
            axis = null;
            if (axisAnimation) {
                axisAnimation.release();
                axisAnimation = null;
            }
            pivot = null;
            if (pivotAnimation) {
                pivotAnimation.release();
                pivotAnimation = null;
            }
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
