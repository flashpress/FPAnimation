/**
 * Created by sam on 24.03.16.
 */
package ru.flashpress.animation.modify
{
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function waveVariable(animation:FPInterval, heights:Vector.<Number>, duration:int):FPWave
    {
        use namespace nsFPAnimation;
        var _animation:FPWave;
        if (FPWave.pool && FPWave.pool.length) {
            _animation = FPWave.pool.shift();
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
}
