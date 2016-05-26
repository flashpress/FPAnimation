/**
 * Created by sam on 08.11.15.
 */
package ru.flashpress.animation.text {
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPTextStr extends FPInterval
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(text:String, duration:Number=0):FPTextStr
        {
            var animation:FPTextStr;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPTextStr();
            }
            animation._duration = duration;
            animation.text = text;
            return animation;
        }


        private var text:String;
        public function FPTextStr()
        {
            super();
            _flags |= FPAnimFlags.TEXT;
        }

        public override function begin():void
        {
            super.begin();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            currentTarget.text = text.slice(0, text.length*position);
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
