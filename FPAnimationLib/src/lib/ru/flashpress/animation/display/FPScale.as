/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.display
{
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPScale extends FPDisplay
    {
        use namespace nsFPAnimation;
        internal static var pool:FPPool;
        public static function createTo(toScale:Number, duration:Number=0):FPScale
        {
            var animation:FPScale;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPScale();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation._duration = duration;
            animation.toX = toScale;
            animation.toY = toScale;
            return animation;
        }
        public static function createTo2(toX:Number, toY:Number, duration:Number=0):FPScale
        {
            var animation:FPScale;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPScale();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation._duration = duration;
            animation.toX = toX;
            animation.toY = toY;
            return animation;
        }
        public static function createFromTo2(fromX:Number, fromY:Number,
                                            toX:Number, toY:Number,
                                            duration:Number=0):FPScale
        {
            var animation:FPScale;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPScale();
            }
            animation._propertyFlags = 0;
            animation._duration = duration;
            animation.fromX = fromX;
            animation.fromY = fromY;
            animation.toX = toX;
            animation.toY = toY;
            return animation;
        }

        internal var toX:Number;
        internal var toY:Number;
        internal var fromX:Number;
        internal var fromY:Number;
        public function FPScale()
        {
            super();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            if (this.name == 'scaleIn') {
                //trace('applyPosition:', fromX, toX, position);
            }
            currentTarget["scaleX"] = fromX + (toX-fromX)*position+_wave + _wave;
            currentTarget["scaleY"] = fromY + (toY-fromY)*position+_wave + _wave;
            //
            super.applyPosition(position);
        }

        protected override function initFromValue():void
        {
            if (this.name == 'scaleIn') trace('------------------------- initFromValue:', currentTarget["scaleX"]);
            fromX = currentTarget["scaleX"];
            fromY = currentTarget["scaleY"];
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
