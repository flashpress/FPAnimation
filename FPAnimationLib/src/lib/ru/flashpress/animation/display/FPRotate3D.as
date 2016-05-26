/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPRotate3D extends FPDisplay
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function createTo(toX:Number, toY:Number, toZ:Number, duration:Number=0):FPRotate3D
        {
            var animation:FPRotate3D;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPRotate3D();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation.toX = toX;
            animation.toY = toY;
            animation.toZ = toZ;
            animation._duration = duration;
            return animation;
        }

        public static function createFromTo(fromX:Number, fromY:Number, fromZ:Number,
                                            toX:Number, toY:Number, toZ:Number,
                                            duration:Number=0):FPRotate3D
        {
            var animation:FPRotate3D;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPRotate3D();
            }
            animation._propertyFlags = 0;
            animation.fromX = fromX;
            animation.fromY = fromY;
            animation.fromZ = fromZ;
            animation.toX = toX;
            animation.toY = toY;
            animation.toZ = toZ;
            animation._duration = duration;
            return animation;
        }

        protected var toX:Number;
        protected var toY:Number;
        protected var toZ:Number;
        protected var fromX:Number;
        protected var fromY:Number;
        protected var fromZ:Number;
        public function FPRotate3D()
        {
            super();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            currentTarget["rotationX"] = fromX + (toX-fromX)*position + _wave;
            currentTarget["rotationY"] = fromY + (toY-fromY)*position + _wave;
            currentTarget["rotationZ"] = fromZ + (toZ-fromZ)*position + _wave;
        }

        protected override function initFromValue():void
        {
            fromX = currentTarget["rotationX"];
            fromY = currentTarget["rotationY"];
            fromZ = currentTarget["rotationZ"];
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
