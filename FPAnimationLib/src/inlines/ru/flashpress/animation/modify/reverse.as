/**
 * Created by sam on 24.03.16.
 */
package ru.flashpress.animation.modify
{
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function reverse(animation:FPInterval, duration:int):FPReverse
    {
        use namespace nsFPAnimation;
        var _animation:FPReverse;
        if (FPReverse.pool && FPReverse.pool.length) {
            _animation = FPReverse.pool.shift();
        } else {
            _animation = new FPReverse();
        }
        _animation.initModify(animation, duration);
        return _animation;
    }
}
