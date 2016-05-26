/**
 * Created by sam on 21.11.15.
 */
package ru.flashpress.animation.matrix.m3d
{
    import flash.geom.Vector3D;

    import ru.flashpress.animation.FPInterval;

    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPVector3D extends FPInterval
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(fromX:Number, fromY:Number, fromZ:Number,
                                      toX:Number, toY:Number, toZ:Number,
                                      duration:Number=0):FPVector3D
        {
            var animation:FPVector3D;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPVector3D();
            }
            animation._duration = duration;
            animation.fromX = fromX;
            animation.fromY = fromY;
            animation.fromZ = fromZ;
            animation.toX = toX;
            animation.toY = toY;
            animation.toZ = toZ;
            return animation;
        }

        private var fromX:Number;
        private var fromY:Number;
        private var fromZ:Number;
        private var toX:Number;
        private var toY:Number;
        private var toZ:Number;
        nsFPAnimation var _vector:Vector3D;
        public function FPVector3D()
        {
            _vector = new Vector3D();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            _vector.x = fromX + (toX - fromX) * position + _wave;
            _vector.y = fromY + (toY - fromY) * position + _wave;
            _vector.z = fromZ + (toZ - fromZ) * position + _wave;
        }

        public function get vector():Vector3D {return _vector;}

        public override function release():void
        {
            super.release();
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
