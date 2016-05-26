/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPScale3D extends FPDisplay
    {
        use namespace nsFPAnimation;
        private static var pool:FPPool;
        public static function createTo(toX:Number, toY:Number, toZ:Number, duration:Number=0):FPScale3D
        {
            var animation:FPScale3D;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPScale3D();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation._duration = duration;
            animation.toX = toX;
            animation.toY = toY;
            animation.toZ = toZ;
            return animation;
        }
        public static function createFromTo(fromX:Number, fromY:Number, fromZ:Number,
                                            toX:Number, toY:Number, toZ:Number,
                                            duration:Number=0):FPScale3D
        {
            var animation:FPScale3D;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPScale3D();
            }
            animation._propertyFlags = 0;
            animation._duration = duration;
            animation.fromX = fromX;
            animation.fromY = fromY;
            animation.fromZ = fromZ;
            animation.toX = toX;
            animation.toY = toY;
            animation.toZ = toZ;
            return animation;
        }

        protected var toX:Number;
        protected var toY:Number;
        protected var toZ:Number;
        protected var fromX:Number;
        protected var fromY:Number;
        protected var fromZ:Number;
        public function FPScale3D()
        {
            super();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            currentTarget["scaleX"] = fromX + (toX-fromX)*position + _wave;
            currentTarget["scaleY"] = fromY + (toY-fromY)*position + _wave;
            currentTarget["scaleZ"] = fromZ + (toZ-fromZ)*position + _wave;
        }

        protected override function initFromValue():void
        {
            fromX = currentTarget["scaleX"];
            fromY = currentTarget["scaleY"];
            fromZ = currentTarget["scaleZ"];
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
