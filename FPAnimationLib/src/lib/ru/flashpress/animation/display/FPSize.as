/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.display {

    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPSize extends FPDisplay
    {
        use namespace nsFPAnimation;

        internal static var pool:FPPool;
        internal static function create(flags:int, duration:Number):FPSize
        {
            var animation:FPSize;
            if (pool && pool.length) {
                animation = pool.shift() as FPSize;
            } else {
                animation = new FPSize();
            }
            animation._propertyFlags = flags;
            animation._duration = duration;
            return animation;
        }

        public static function createToWidth(toWidth:Number, duration:Number=0):FPSize
        {
            var animation:FPSize = create(RELATIVELY, duration);
            animation.moveFlags = FPSize.FLAG_WIDTH;
            animation.toWidth = toWidth;
            return animation;
        }
        public static function createToHeight(toHeight:Number, duration:Number=0):FPSize
        {
            var animation:FPSize = create(RELATIVELY, duration);
            animation.moveFlags = FPSize.FLAG_HEIGHT;
            animation.toHeight = toHeight;
            return animation;
        }

        public static function createTo(toWidth:Number, toHeight:Number, duration:Number=0):FPSize
        {
            var animation:FPSize = create(RELATIVELY, duration);
            animation.moveFlags = FPSize.FLAG_WIDTH | FPSize.FLAG_HEIGHT;
            animation.toWidth = toWidth;
            animation.toHeight = toHeight;
            return animation;
        }
        public static function createFromTo(fromWidth:Number, fromHeight:Number, toWidth:Number, toHeight:Number, duration:Number=0):FPSize
        {
            var animation:FPSize = create(0, duration);
            animation.moveFlags = FPSize.FLAG_WIDTH | FPSize.FLAG_HEIGHT;
            animation.fromWidth = fromWidth;
            animation.fromHeight = fromHeight;
            animation.toWidth = toWidth;
            animation.toHeight = toHeight;
            return animation;
        }
        public static function createFromToWidth(fromWidth:Number, toWidth:Number, duration:Number=0):FPSize
        {
            var animation:FPSize = create(0, duration);
            animation.moveFlags = FPSize.FLAG_WIDTH;
            animation.fromWidth = fromWidth;
            animation.toWidth = toWidth;
            return animation;
        }
        public static function createFromToHeight(fromHeight:Number, toHeight:Number, duration:Number=0):FPSize
        {
            var animation:FPSize = create(0, duration);
            animation.moveFlags = FPSize.FLAG_HEIGHT;
            animation.fromHeight = fromHeight;
            animation.toHeight = toHeight;
            return animation;
        }

        public static function createAddWidth(delta:Number, duration:Number=0):FPSize
        {
            var animation:FPSize = create(RELATIVELY | ADDITIONAL, duration);
            animation.moveFlags = FPSize.FLAG_WIDTH;
            animation.deltaX = delta;
            return animation;
        }
        public static function createAddHeight(delta:Number, duration:Number=0):FPSize
        {
            var animation:FPSize = create(RELATIVELY | ADDITIONAL, duration);
            animation.moveFlags = FPSize.FLAG_HEIGHT;
            animation.deltaY = delta;
            return animation;
        }
        public static function createAdd(deltaWidth:Number, deltaHeight:Number, duration:Number=0):FPSize
        {
            var animation:FPSize = create(RELATIVELY | ADDITIONAL, duration);
            animation.moveFlags = FPSize.FLAG_WIDTH | FPSize.FLAG_HEIGHT;
            animation.deltaX = deltaWidth;
            animation.deltaY = deltaHeight;
            return animation;
        }


        internal static const FLAG_WIDTH:int = 0x1;
        internal static const FLAG_HEIGHT:int = 0x2;

        nsFPAnimation var moveFlags:uint;

        nsFPAnimation var toWidth:Number = 0;
        nsFPAnimation var toHeight:Number = 0;
        nsFPAnimation var fromWidth:Number = 0;
        nsFPAnimation var fromHeight:Number = 0;
        nsFPAnimation var deltaX:Number = 0;
        nsFPAnimation var deltaY:Number = 0;
        public function FPSize()
        {
            super();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (moveFlags & FLAG_WIDTH) currentTarget["width"] = fromWidth + (toWidth-fromWidth)*position + _wave;
            if (moveFlags & FLAG_HEIGHT) currentTarget["height"] = fromHeight + (toHeight-fromHeight)*position + _wave;
        }

        protected override function initFromValue():void
        {
            if (moveFlags & FLAG_WIDTH) {
                fromWidth = currentTarget["width"];
                if (_propertyFlags & ADDITIONAL) toWidth = fromWidth + deltaX;
            }
            if (moveFlags & FLAG_HEIGHT) {
                fromHeight = currentTarget["height"];
                if (_propertyFlags & ADDITIONAL) toHeight = fromHeight + deltaY;
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
            return '[FPSize name:'+this._name+' from:'+(_propertyFlags&RELATIVELY?'obj':fromWidth+'x'+fromHeight)+', to:'+toWidth+'x'+toHeight+' ]';
        }
    }
}
