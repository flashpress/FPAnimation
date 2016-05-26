/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.colorTransform {
    import flash.display.DisplayObject;
    import flash.geom.ColorTransform;

    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.FPrgbaUtils;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPColorTransform extends FPInterval
    {

        use namespace nsFPAnimation;

        private static var pool:FPPool;
        private static function create(duration:Number):FPColorTransform
        {
            var animation:FPColorTransform;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPColorTransform();
            }
            animation._duration = duration;
            return animation;
        }


        public static function offsetRGBi(red:int, green:int, blue:int, alpha:int, duration:Number):FPColorTransform
        {
            var animation:FPColorTransform = create(duration);
            animation._duration = duration;
            animation.offsetTo.red = red;
            animation.offsetTo.green = green;
            animation.offsetTo.blue = blue;
            animation.offsetTo.alpha = alpha;
            //
            animation.multiplyTo.clear(1);
            return animation;
        }
        private static var rgb:FPrgbaUtils = new FPrgbaUtils();
        public static function offsetColor(color:uint, duration:Number):FPColorTransform
        {
            var animation:FPColorTransform = create(duration);
            //
            rgb.update(color);
            animation.offsetTo.red = rgb.red;
            animation.offsetTo.green = rgb.green;
            animation.offsetTo.blue = rgb.blue;
            animation.offsetTo.alpha = rgb.alpha;
            //
            animation.multiplyTo.clear(1);
            //
            return animation;
        }

        public static function multiplyColor(color:uint, duration:Number):FPColorTransform
        {
            var animation:FPColorTransform = create(duration);
            //
            animation.offsetTo.clear(0);
            //
            rgb.update(color);
            animation.multiplyTo.red = rgb.red/255;
            animation.multiplyTo.green = rgb.green/255;
            animation.multiplyTo.blue = rgb.blue/255;
            animation.multiplyTo.alpha = rgb.alpha/255;
            return animation;
        }

        public static function multiplyAndOffsetColor(multiplyColor:uint, offsetColor:uint, duration:Number):FPColorTransform
        {
            var animation:FPColorTransform = create(duration);
            //
            rgb.update(offsetColor);
            animation.offsetTo.red = rgb.red;
            animation.offsetTo.green = rgb.green;
            animation.offsetTo.blue = rgb.blue;
            animation.offsetTo.alpha = rgb.alpha;
            //
            rgb.update(multiplyColor);
            animation.multiplyTo.red = rgb.red/255;
            animation.multiplyTo.green = rgb.green/255;
            animation.multiplyTo.blue = rgb.blue/255;
            animation.multiplyTo.alpha = rgb.alpha/255;
            return animation;
        }


        private var applyTransform:ColorTransform;
        private var offsetTo:FPrgbaUtils;
        private var multiplyTo:FPrgbaUtils;
        protected var offsetBegin:FPrgbaUtils;
        protected var multiplyBegin:FPrgbaUtils;
        public function FPColorTransform()
        {
            super();
            _flags |= FPAnimFlags.TRANSFORM;
            //
            applyTransform = new ColorTransform();
            offsetTo = new FPrgbaUtils();
            multiplyTo = new FPrgbaUtils();
            offsetBegin = new FPrgbaUtils();
            multiplyBegin = new FPrgbaUtils();
        }

        public override function begin():void
        {
            super.begin();
            //
            var targetDo:DisplayObject = currentTarget as DisplayObject;
            var color:ColorTransform = targetDo.transform.colorTransform;
            offsetBegin.red = color.redOffset;
            offsetBegin.green = color.greenOffset;
            offsetBegin.blue = color.blueOffset;
            offsetBegin.alpha = color.alphaOffset;
            //
            multiplyBegin.red = color.redMultiplier;
            multiplyBegin.green = color.greenMultiplier;
            multiplyBegin.blue = color.blueMultiplier;
            multiplyBegin.alpha = color.alphaMultiplier;
        }

        nsFPAnimation override function beginForSequence():void
        {
            super.beginForSequence();
            this.begin();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            applyTransform.redOffset = offsetBegin.red + (offsetTo.red-offsetBegin.red)*position + _wave;
            applyTransform.greenOffset = offsetBegin.green + (offsetTo.green-offsetBegin.green)*position + _wave;
            applyTransform.blueOffset = offsetBegin.blue + (offsetTo.blue-offsetBegin.blue)*position + _wave;
            applyTransform.alphaOffset = offsetBegin.alpha + (offsetTo.alpha-offsetBegin.alpha)*position + _wave;
            //
            applyTransform.redMultiplier = multiplyBegin.red + (multiplyTo.red-multiplyBegin.red)*position + _wave;
            applyTransform.greenMultiplier = multiplyBegin.green + (multiplyTo.green-multiplyBegin.green)*position + _wave;
            applyTransform.blueMultiplier = multiplyBegin.blue + (multiplyTo.blue-multiplyBegin.blue)*position + _wave;
            applyTransform.alphaMultiplier = multiplyBegin.alpha + (multiplyTo.alpha-multiplyBegin.alpha)*position + _wave;
            //
            currentTarget.transform.colorTransform = applyTransform;
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
