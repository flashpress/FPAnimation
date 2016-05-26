/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.filters
{
    import flash.filters.GlowFilter;

    import ru.flashpress.animation.core.FPPool;

    import ru.flashpress.animation.core.FPrgbaUtils;

    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPGlow extends FPFilter
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        private static function _create(flags:int, initGlow:GlowFilter, duration:Number):FPGlow
        {
            var animation:FPGlow;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPGlow();
            }
            animation._duration = duration;
            //
            animation.init(initGlow, flags);
            return animation;
        }

        public static function create(color:uint, alpha:Number, blurX:Number, blurY:Number, initGlow:GlowFilter=null, duration:Number=0):FPGlow
        {
            var animation:FPGlow = _create(FLAG_XY|FLAG_ALPHA|FLAG_COLOR, initGlow, duration);
            animation.finishColor.update(color);
            animation.finishAlpha = alpha;
            animation.finishX = blurX;
            animation.finishY = blurY;
            return animation;
        }

        public static function createXY(blurX:Number, blurY:Number, initGlow:GlowFilter=null, duration:Number=0):FPGlow
        {
            var animation:FPGlow = _create(FLAG_XY, initGlow, duration);
            animation.finishX = blurX;
            animation.finishY = blurY;
            return animation;
        }

        public static function createColor(color:uint, initGlow:GlowFilter=null, duration:Number=0):FPGlow
        {
            var animation:FPGlow = _create(FLAG_COLOR, initGlow, duration);
            animation.finishColor.update(color);
            return animation;
        }

        public static function createAlpha(alpha:Number, initGlow:GlowFilter=null, duration:Number=0):FPGlow
        {
            var animation:FPGlow = _create( FLAG_ALPHA, initGlow, duration);
            animation.finishAlpha = alpha;
            return animation;
        }

        private static const FLAG_XY:int = 0x1;
        private static const FLAG_COLOR:int = 0x2;
        private static const FLAG_ALPHA:int = 0x4;

        private var flags:int;
        private var glow:GlowFilter;

        private var beginX:Number = 0;
        private var beginY:Number = 0;
        private var finishX:Number = 0;
        private var finishY:Number = 0;
        //
        private var beginColor:FPrgbaUtils;
        private var finishColor:FPrgbaUtils;
        //
        private var beginAlpha:Number;
        private var finishAlpha:Number;
        //
        public function FPGlow()
        {
            super();
        }

        private function init(initGlow:GlowFilter, flags:int):void
        {
            this.flags = flags;
            this.glow = initGlow ? initGlow : new GlowFilter(0x0, 1, 0, 0);
            this.beginX = glow.blurX;
            this.beginY = glow.blurY;
            //
            beginColor = new FPrgbaUtils(glow.color);
            finishColor = new FPrgbaUtils(glow.color);
            //
            beginAlpha = glow.alpha;
            finishAlpha = glow.alpha;
        }

        nsFPAnimation override function addToList(list:Array):void
        {
            list.push(glow);
        }

        private var applyColor:FPrgbaUtils = new FPrgbaUtils();
        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            if (flags & FLAG_XY) {
                glow.blurX = beginX + (finishX - beginX) * position + _wave;
                glow.blurY = beginY + (finishY - beginY) * position + _wave;
            }
            if (flags & FLAG_COLOR) {
                applyColor.interpolate(beginColor, finishColor, position, _wave);
                glow.color = applyColor.getColor();
            }
            if (flags & FLAG_ALPHA) {
                glow.alpha = beginAlpha + (finishAlpha - beginAlpha) * position + _wave;
            }
            //
            if (currentTarget) {
                currentTarget.filters = [glow];
            }
        }

        public override function release():void
        {
            super.release();
            glow = null;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
