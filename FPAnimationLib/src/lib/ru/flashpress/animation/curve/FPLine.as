/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.curve {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPLine extends FPCurve
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(duration:int, startPoint:Object, finishPoint:Object):FPLine
        {
            var animation:FPLine;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPLine();
            }
            animation._duration = duration;
            animation.startX = startPoint["x"];
            animation.startY = startPoint["y"];
            animation.finishX = finishPoint["x"];
            animation.finishY = finishPoint["y"];
            return animation;
        }
        public static function createXY(duration:int, startX:Number, startY:Number, finishX:Number, finishY:Number):FPLine
        {
            var animation:FPLine;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPLine();
            }
            animation._duration = duration;
            animation.startX = startX;
            animation.startY = startY;
            animation.finishX = finishX;
            animation.finishY = finishY;
            return animation;
        }

        private var startX:Number;
        private var startY:Number;
        private var finishX:Number;
        private var finishY:Number;
        public function FPLine()
        {
            super();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            currentTarget.x = startX + (finishX-startX)*position;
            currentTarget.x = startY + (finishY-startY)*position;
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
