/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.curve {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPLineStrip extends FPCurve
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(duration:int, points:Vector.<Number>, begin:int=-1, end:int=-1):FPLineStrip
        {
            var animation:FPLineStrip;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPLineStrip();
            }
            var pointsCount:int = Math.floor(points.length/2);
            //
            animation._duration = duration;
            animation.points.length = 0;
            animation.positions.length = 0;
            animation.positions.push(0);
            animation._length = 0;
            animation._begin = begin != -1 ? begin : 0;
            animation._end = end != -1 ? end : pointsCount;
            //
            var i:int;
            var currX:Number;
            var currY:Number;
            var prevX:Number = 0;
            var prevY:Number = 0;
            var d:Number;
            for (i=0; i<pointsCount*2; i+=2) {
                currX = points[i];
                currY = points[i+1];
                animation.points.push(currX);
                animation.points.push(currY);
                if (i > 0) {
                    d = Math.sqrt((prevX - currX) * (prevX - currX) + (prevY - currY) * (prevY - currY));
                    if (i>=animation._begin && i<=2*animation._end) {
                        animation._length += d;
                    }
                    animation.positions.push(d);
                }
                prevX = currX;
                prevY = currY;
            }
            animation.init();
            return animation;
        }

        private var points:Vector.<Number>;
        private var positions:Vector.<Number>;
        private var _length:Number;
        private var _begin:int;
        private var _end:int;
        public function FPLineStrip()
        {
            super();
            //
            points = new <Number>[];
            positions = new <Number>[];
        }

        private function init():void
        {
            var i:int;
            var temp:Number = 0;
            var count:int = positions.length;
            for (i=0; i<count; i++) {
                temp += positions[i]/_length;
                positions[i] = temp;
            }
        }

        private var i1:int;
        private var index:int;
        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            for (i1=_begin; i1<_end; i1++) {
                if (positions[i1] >= position) {
                    index = i1-1;
                    break;
                }
            }
            if (index > positions.length-2) index = positions.length-2;
            if (index < 0) index = 0;
            position = (position-positions[index])/(positions[index+1]-positions[index]);
            //
            index *= 2;
            var x1:Number = points[index];
            var y1:Number = points[index+1];
            var x2:Number = points[index+2];
            var y2:Number = points[index+3];
            //
            currentTarget.x = x1+(x2-x1)*position;
            currentTarget.y = y1+(y2-y1)*position;
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
