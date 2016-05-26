/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.filters {
    import flash.filters.BlurFilter;

    import ru.flashpress.animation.core.FPPool;

    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPBlur extends FPFilter
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(blurX:Number, blurY:Number, duration:Number=0):FPBlur
        {
            var animation:FPBlur;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPBlur();
            }
            animation._duration = duration;
            //
            animation.init();
            animation.beginX = 0;
            animation.beginY = 0;
            animation.finishX = blurX;
            animation.finishY = blurY;
            return animation;
        }

        private var beginX:Number = 0;
        private var beginY:Number = 0;
        private var finishX:Number = 0;
        private var finishY:Number = 0;
        private var blur:BlurFilter;
        public function FPBlur()
        {
            super();
            //
            blur = new BlurFilter();
            init();
        }
        private function init():void
        {
            blur.blurX = 0;
            blur.blurY = 0;
            blur.quality = 3;
        }

        nsFPAnimation override function addToList(list:Array):void
        {
            list.push(blur);
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            blur.blurX = beginX + (finishX-beginX)*position + _wave;
            blur.blurY = beginY + (finishY-beginY)*position + _wave;
            //
            if (currentTarget) {
                currentTarget.filters = [blur];
            }
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
