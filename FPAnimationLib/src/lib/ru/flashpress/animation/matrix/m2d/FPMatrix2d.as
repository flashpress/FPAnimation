/**
 * Created by sam on 21.11.15.
 */
package ru.flashpress.animation.matrix.m2d {
    import flash.geom.Matrix;

    import ru.flashpress.animation.FPAnimation;

    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMatrix2d extends FPInterval
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(duration:Number, ...items):FPMatrix2d
        {
            var animation:FPMatrix2d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrix2d();
            }
            animation._duration = duration;
            animation.anchorX = 0;
            animation.anchorY = 0;
            animation.items.length = 0;
            animation.init(items);
            //
            return animation;
        }

        public static function createWithAnchor(anchorX:Number, anchorY:Number, duration:Number, ...items):FPMatrix2d
        {
            var animation:FPMatrix2d;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPMatrix2d();
            }
            animation._duration = duration;
            animation.anchorX = anchorX;
            animation.anchorY = anchorY;
            animation.items.length = 0;
            animation.init(items);
            //
            return animation;
        }

        private var matrix:Matrix;
        private var items:Vector.<FPAnimation>;
        private var anchorX:Number;
        private var anchorY:Number;
        public function FPMatrix2d()
        {
            super();
            //
            matrix = new Matrix();
            items = new <FPAnimation>[];
        }

        private function init(items:Array):void
        {
            var temp:FPAnimation;
            for (var i:int=0; i<items.length; i++) {
                temp = items[i];
                this.items.push(temp);
                /*
                if (temp._flags & FPAnimFlags.MATRIX) {
                    this.items.push(temp as FPMatrixItem);
                }
                */
            }
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            matrix.identity();
            matrix.translate(-anchorX, -anchorY);
            //
            var item:FPAnimation;
            for (var i:int=0; i<items.length; i++) {
                item = items[i];
                item.target = matrix;
                item.applyPosition(position);
            }
            matrix.translate(anchorX, anchorY);
            currentTarget.transform.matrix = matrix;
            //
            super.applyPosition(position);
        }

        public override function begin():void
        {
            super.begin();
            //
            var item:FPAnimation;
            for (var i:int=0; i<items.length; i++) {
                item = items[i];
                item.target = matrix;
                item.begin();
            }
        }

        public override function release():void
        {
            super.release();
            //
            var i:int;
            for (i=0; i<items.length; i++) {
                items[i].release();
            }
            items.length = 0;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
