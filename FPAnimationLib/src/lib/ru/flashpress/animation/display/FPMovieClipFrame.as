/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMovieClipFrame extends FPDisplay
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function createTo(frameTo:int, duration:Number=0):FPMovieClipFrame
        {
            var animation:FPMovieClipFrame;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMovieClipFrame();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation.toFrame = frameTo;
            animation._duration = duration;
            return animation;
        }
        public static function createFromTo(fromFrame:int, toFrame:int, duration:Number=0):FPMovieClipFrame
        {
            var animation:FPMovieClipFrame;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMovieClipFrame();
            }
            animation._propertyFlags = 0;
            animation.fromFrame = fromFrame;
            animation.toFrame = toFrame;
            animation._duration = duration;
            return animation;
        }

        private var toFrame:int;
        protected var fromFrame:Number;
        public function FPMovieClipFrame()
        {
            super();
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
            currentTarget.gotoAndStop(fromFrame + (toFrame-fromFrame)*position + _wave);
        }

        protected override function initFromValue():void
        {
            fromFrame = currentTarget.currentFrame;
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
