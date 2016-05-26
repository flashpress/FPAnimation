/**
 * Created by sam on 24.03.16.
 */
package ru.flashpress.animation
{
    import ru.flashpress.animation.core.nsFPAnimation;
    import ru.flashpress.animation.modify.FPReverse;

    [Inline]
    public function reverse(animation:FPInterval, duration:int=0):FPReverse
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
