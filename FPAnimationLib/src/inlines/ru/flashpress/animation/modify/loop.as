/**
 * Created by sam on 24.03.16.
 */
package ru.flashpress.animation.modify
{
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function loop(animation:FPInterval, count:int, duration:int):FPLoop
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
