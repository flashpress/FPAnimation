/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.display {

    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMove extends FPDisplay
    {
        use namespace nsFPAnimation;

        internal static var pool:FPPool;
        internal static function create(flags:int, duration:Number):FPMove
        {
            var animation:FPMove;
            if (pool && pool.length) {
                animation = pool.shift() as FPMove;
            } else {
                animation = new FPMove();
            }
            animation._propertyFlags = flags;
            animation._duration = duration;
            return animation;
        }

        public static function createToX(toX:Number, duration:Number=0):FPMove
        {
            var animation:FPMove = create(RELATIVELY, duration);
            animation.moveFlags = FPMove.FLAG_X;
            animation.toX = toX;
            return animation;
        }
        public static function createToY(toY:Number, duration:Number=0):FPMove
        {
            var animation:FPMove = create(RELATIVELY, duration);
            animation.moveFlags = FPMove.FLAG_Y;
            animation.toY = toY;
            return animation;
        }

        public static function createTo(toX:Number, toY:Number, duration:Number=0):FPMove
        {
            var animation:FPMove = create(RELATIVELY, duration);
            animation.moveFlags = FPMove.FLAG_X | FPMove.FLAG_Y;
            animation.toX = toX;
            animation.toY = toY;
            return animation;
        }
        public static function createFromTo(fromX:Number, fromY:Number, toX:Number, toY:Number, duration:Number=0):FPMove
        {
            var animation:FPMove = create(0, duration);
            animation.moveFlags = FPMove.FLAG_X | FPMove.FLAG_Y;
            animation.fromX = fromX;
            animation.fromY = fromY;
            animation.toX = toX;
            animation.toY = toY;
            return animation;
        }
        public static function createFromToX(fromX:Number, toX:Number, duration:Number=0):FPMove
        {
            var animation:FPMove = create(0, duration);
            animation.moveFlags = FPMove.FLAG_X;
            animation.fromX = fromX;
            animation.toX = toX;
            return animation;
        }
        public static function createFromToY(fromY:Number, toY:Number, duration:Number=0):FPMove
        {
            var animation:FPMove = create(0, duration);
            animation.moveFlags = FPMove.FLAG_Y;
            animation.fromY = fromY;
            animation.toY = toY;
            return animation;
        }

        public static function createAddX(delta:Number, duration:Number=0):FPMove
        {
            var animation:FPMove = create(RELATIVELY | ADDITIONAL, duration);
            animation.moveFlags = FPMove.FLAG_X;
            animation.deltaX = delta;
            return animation;
        }
        public static function createAddY(delta:Number, duration:Number=0):FPMove
        {
            var animation:FPMove = create(RELATIVELY | ADDITIONAL, duration);
            animation.moveFlags = FPMove.FLAG_Y;
            animation.deltaY = delta;
            return animation;
        }
        public static function createAdd(deltaX:Number, deltaY:Number, duration:Number=0):FPMove
        {
            var animation:FPMove = create(RELATIVELY | ADDITIONAL, duration);
            animation.moveFlags = FPMove.FLAG_X | FPMove.FLAG_Y;
            animation.deltaX = deltaX;
            animation.deltaY = deltaY;
            return animation;
        }


        internal static const FLAG_X:int = 0x1;
        internal static const FLAG_Y:int = 0x2;

        nsFPAnimation var moveFlags:uint;

        nsFPAnimation var toX:Number = 0;
        nsFPAnimation var toY:Number = 0;
        nsFPAnimation var fromX:Number = 0;
        nsFPAnimation var fromY:Number = 0;
        nsFPAnimation var deltaX:Number = 0;
        nsFPAnimation var deltaY:Number = 0;
        public function FPMove()
        {
            super();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (moveFlags & FLAG_X) currentTarget["x"] = fromX + (toX-fromX)*position + _wave;
            if (moveFlags & FLAG_Y) currentTarget["y"] = fromY + (toY-fromY)*position + _wave;
        }

        protected override function initFromValue():void
        {
            if (moveFlags & FLAG_X) {
                fromX = currentTarget["x"];
                if (_propertyFlags & ADDITIONAL) toX = fromX + deltaX;
            }
            if (moveFlags & FLAG_Y) {
                fromY = currentTarget["y"];
                if (_propertyFlags & ADDITIONAL) toY = fromY + deltaY;
            }
        }

        public override function release():void
        {
            super.release();
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }

        public override function toString():String
        {
            return '[FPMove name:'+this._name+' from:'+(_propertyFlags&RELATIVELY?'obj':fromX+'x'+fromY)+', to:'+toX+'x'+toY+' ]';
        }
    }
}
