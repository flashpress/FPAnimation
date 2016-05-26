/**
 * Created by sam on 16.11.15.
 */
package ru.flashpress.animation.display {

    import ru.flashpress.animation.FPProperty;

    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;
    import ru.flashpress.animation.modify.FPEase;

    public class FPJump extends FPDisplay
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function createTo(toX:Number, toY:Number, duration:Number=0):FPJump
        {
            var animation:FPJump;
            if (pool && pool.length) {
                animation = pool.shift() as FPJump;
            } else {
                animation = new FPJump();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation.toX = toX;
            animation.toY = toY;
            animation._duration = duration;
            return animation;
        }

        public static function createFromTo(fromX:Number, fromY:Number, toX:Number, toY:Number, duration:Number=0):FPJump
        {
            var animation:FPJump;
            if (pool && pool.length) {
                animation = pool.shift() as FPJump;
            } else {
                animation = new FPJump();
            }
            animation._propertyFlags = 0;
            animation.fromX = fromX;
            animation.fromY = fromY;
            animation.toX = toX;
            animation.toY = toY;
            animation._duration = duration;
            return animation;
        }

        protected var fromX:Number;
        protected var fromY:Number;
        protected var toX:Number;
        protected var toY:Number;
        protected var _easeIn:Function;
        protected var _easeOut:Function;
        public function FPJump()
        {
            super();
            //
            _easeIn = FPEase.strongEaseOut;
            _easeOut = FPEase.strongEaseIn;
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (position < 0.5) {
                position = position/0.5;
                position = _easeIn(position, 0, 1, 1);
                //
                currentTarget["x"] = fromX + (toX-fromX)*position + _wave;
                currentTarget["y"] = fromY + (toY-fromY)*position + _wave;
            } else {
                position = (position-0.5)/0.5;
                position = _easeOut(position, 0, 1, 1);
                //
                currentTarget["x"] = toX + (fromX-toX)*position + _wave;
                currentTarget["y"] = toY + (fromY-toY)*position + _wave;
            }
        }

        protected override function initFromValue():void
        {
            fromX = currentTarget["x"];
            fromY = currentTarget["y"];
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
