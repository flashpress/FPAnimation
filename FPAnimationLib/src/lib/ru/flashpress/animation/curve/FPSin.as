/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.curve {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPSin extends FPCurve
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(duration:int, beginX:Number, beginY:Number, radius:Number, maxAngle:Number):FPSin
        {
            var animation:FPSin;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPSin();
            }
            animation._duration = duration;
            animation.beginX = beginX;
            animation.beginY = beginY;
            animation.radius = radius;
            animation.maxAngle = maxAngle;
            return animation;
        }

        private var beginX:Number;
        private var beginY:Number;
        private var radius:Number;
        private var maxAngle:Number;
        public function FPSin()
        {
            super();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            currentTarget.x = beginX;
            currentTarget.y = beginY + radius*Math.sin(position*maxAngle);
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
