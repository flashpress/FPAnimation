/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.curve {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPEllipse extends FPCurve
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(duration:int, centerX:Number, centerY:Number, radiusX:Number, radiusY:Number, beginRotate:Number=0, direction:int=1):FPEllipse
        {
            var animation:FPEllipse;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPEllipse();
            }
            animation._duration = duration;
            animation.centerX = centerX;
            animation.centerY = centerY;
            animation.radiusX = radiusX;
            animation.radiusY = radiusY;
            animation.beginRotate = beginRotate;
            animation.direction = direction;
            return animation;
        }

        private var centerX:Number;
        private var centerY:Number;
        private var radiusX:Number;
        private var radiusY:Number;
        private var beginRotate:Number;
        private var direction:int;
        public function FPEllipse()
        {
            super();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            currentTarget.x = centerX + radiusX*Math.cos(position*Math.PI*2+beginRotate*direction);
            currentTarget.y = centerY + radiusY*Math.sin(position*Math.PI*2+beginRotate);
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
