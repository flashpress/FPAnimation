/**
 * Created by sam on 24.03.16.
 */
package ru.flashpress.animation
{
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function loop(animation:FPInterval, count:int=0, duration:int=0):FPLoop
    {
        use namespace nsFPAnimation;
        var _animation:FPLoop;
        if (FPLoop.pool && FPLoop.pool.length) {
            _animation = FPLoop.pool.shift();
        } else {
            _animation = new FPLoop();
        }
        _animation.count = count;
        _animation.initModify(animation, duration);
        return _animation;
    }
}
