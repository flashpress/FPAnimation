/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMove3D extends FPDisplay
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        private static function create(propertyFlags:int, duration:Number):FPMove3D
        {
            var animation:FPMove3D;
            if (pool && pool.length) {
                animation = pool.shift() as FPMove3D;
            } else {
                animation = new FPMove3D();
            }
            animation._propertyFlags = propertyFlags;
            animation._duration = duration;
            return animation;
        }

        public static function createFromTo(fromX:Number, fromY:Number, fromZ:Number,
                                            toX:Number, toY:Number, toZ:Number,
                                            duration:Number=0):FPMove3D
        {
            var animation:FPMove3D = create(0, duration);
            animation.fromX = fromX;
            animation.fromY = fromY;
            animation.fromZ = fromZ;
            animation.toX = toX;
            animation.toY = toY;
            animation.toZ = toZ;
            animation.moveFlags = FLAG_X|FLAG_Y|FLAG_Z;
            return animation;
        }
        public static function createFromToX(fromX:Number, toX:Number, duration:Number=0):FPMove3D
        {
            var animation:FPMove3D = create(0, duration);
            animation.fromX = fromX;
            animation.toX = toX;
            animation.moveFlags = FLAG_X;
            return animation;
        }
        public static function createFromToY(fromY:Number, toY:Number, duration:Number=0):FPMove3D
        {
            var animation:FPMove3D = create(0, duration);
            animation.fromY = fromY;
            animation.toY = toY;
            animation.moveFlags = FLAG_Y;
            return animation;
        }
        public static function createFromToZ(fromZ:Number, toZ:Number, duration:Number=0):FPMove3D
        {
            var animation:FPMove3D = create(0, duration);
            animation.fromZ = fromZ;
            animation.toZ = toZ;
            animation.moveFlags = FLAG_Z;
            return animation;
        }


        public static function createTo(toX:Number, toY:Number, toZ:Number, duration:Number=0):FPMove3D
        {
            var animation:FPMove3D = create(FPProperty.RELATIVELY, duration);
            animation.toX = toX;
            animation.toY = toY;
            animation.toZ = toZ;
            animation.moveFlags = FLAG_X|FLAG_Y|FLAG_Z;
            return animation;
        }
        public static function createToX(toX:Number, duration:Number=0):FPMove3D
        {
            var animation:FPMove3D = create(FPProperty.RELATIVELY, duration);
            animation.toX = toX;
            animation.moveFlags = FLAG_X;
            return animation;
        }
        public static function createToY(toY:Number, duration:Number=0):FPMove3D
        {
            var animation:FPMove3D = create(FPProperty.RELATIVELY, duration);
            animation.toY = toY;
            animation.moveFlags = FLAG_Y;
            return animation;
        }
        public static function createToZ(toZ:Number, duration:Number=0):FPMove3D
        {
            var animation:FPMove3D = create(FPProperty.RELATIVELY, duration);
            animation.toZ = toZ;
            animation.moveFlags = FLAG_Z;
            return animation;
        }

        private static var FLAG_X:int = 0x1;
        private static var FLAG_Y:int = 0x2;
        private static var FLAG_Z:int = 0x4;

        private var moveFlags:int;

        protected var toX:Number;
        protected var toY:Number;
        protected var toZ:Number;
        protected var fromX:Number;
        protected var fromY:Number;
        protected var fromZ:Number;
        public function FPMove3D()
        {
            super();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (moveFlags | FLAG_X) currentTarget["x"] = fromX + (toX-fromX)*position + _wave;
            if (moveFlags | FLAG_Y) currentTarget["y"] = fromY + (toY-fromY)*position + _wave;
            if (moveFlags | FLAG_Z) currentTarget["z"] = fromZ + (toZ-fromZ)*position + _wave;
        }

        protected override function initFromValue():void
        {
            fromX = currentTarget["x"];
            fromY = currentTarget["y"];
            fromZ = currentTarget["z"];
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
