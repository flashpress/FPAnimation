/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.filters {
    import flash.filters.ColorMatrixFilter;

    import ru.flashpress.animation.core.FPPool;

    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPGrayScale extends FPFilter
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(gray:Number, duration:Number=0):FPGrayScale
        {
            var animation:FPGrayScale;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPGrayScale();
            }
            animation._duration = duration;
            animation.grayValue = gray;
            //
            animation.init();
            return animation;
        }

        private var gray:ColorMatrixFilter;
        private var matrix:Array;
        private var grayValue:Number;
        public function FPGrayScale()
        {
            super();
            //
            gray = new ColorMatrixFilter();
            matrix = [];
            var d:int = 0;
            for (var i:int=0; i<20; i++) {
                matrix.push(i == d ? 1 : 0);
                if (i == d) {
                    d += 6;
                }
            }
            init();
        }
        private function init():void
        {
        }

        nsFPAnimation override function addToList(list:Array):void
        {
            list.push(gray);
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            matrix[0] = matrix[6] = matrix[12] = 1-(1-grayValue)*position + _wave;
            matrix[1] = matrix[2] = matrix[5] = matrix[7] = matrix[10] = matrix[11] = grayValue*position + _wave;
            gray.matrix = matrix;
            //
            if (currentTarget) {
                currentTarget.filters = [gray];
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
