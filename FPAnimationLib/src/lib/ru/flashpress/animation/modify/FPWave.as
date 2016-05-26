/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.modify {
    import ru.flashpress.animation.*;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPWave extends FPModify
    {
        use namespace nsFPAnimation;

        nsFPAnimation static var pool:FPPool;
        public static function createLinear(animation:FPInterval, height:Number=1, count:int=1, duration:int=0):FPWave
        {
            var _animation:FPWave;
            if (pool && pool.length) {
                _animation = pool.shift();
            } else {
                _animation = new FPWave();
            }
            _animation.heights.length = 0;
            var i:int;
            for (i=0; i<count; i++) {
                _animation.heights.push(height);
            }
            _animation.count = count;
            _animation.initModify(animation, duration);
            return _animation;
        }
        public static function createVariable(animation:FPInterval, heights:Vector.<Number>, duration:int=0):FPWave
        {
            var _animation:FPWave;
            if (pool && pool.length) {
                _animation = pool.shift();
            } else {
                _animation = new FPWave();
            }
            _animation.heights.length = 0;
            var i:int;
            for (i=0; i<heights.length; i++) {
                _animation.heights.push(heights[i]);
            }
            _animation.count = heights.length;
            _animation.initModify(animation, duration);
            return _animation;
        }

        nsFPAnimation var heights:Vector.<Number>;
        nsFPAnimation var count:int;
        public function FPWave()
        {
            super();
            this.noApplyToAnim = true;
            heights = new <Number>[];
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            var index:int = 0;
            if (count > 1) {
                var d:Number = 1/count;
                index = Math.floor(position/d);
                position = (position-index*1/count)/(1/count);
            }
            if (index >= count) index = count-1;
            position = Math.sin(position*Math.PI);
            _animation.setWave(heights[index]*position);
            _animation.applyPosition(position);
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
