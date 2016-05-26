/**
 * Created by sam on 24.03.16.
 */
package ru.flashpress.animation.modify.ease {
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.nsFPAnimation;
    import ru.flashpress.animation.modify.FPEase;

    [Inline]
    public function ease(func:*, animation:FPInterval, duration:int):FPEase
    {
        use namespace nsFPAnimation;
        //
        var _animation:FPEase;
        if (FPEase.pool && FPEase.pool.length) {
            _animation = FPEase.pool.shift();
        } else {
            _animation = new FPEase();
        }
        _animation.ease = func;
        _animation.initModify(animation, duration);
        //
        return _animation;
    }
}
