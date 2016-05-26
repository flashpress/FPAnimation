/**
 * Created by sam on 24.03.16.
 */
package ru.flashpress.animation
{
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function timeout(duration:int):FPTimeout
    {
        use namespace nsFPAnimation;

        var _animation:FPTimeout;
        if (FPTimeout.pool && FPTimeout.pool.length) {
            _animation = FPTimeout.pool.shift();
        } else {
            _animation = new FPTimeout();
        }
        _animation._duration = duration;
        //
        return _animation;
    }
}
