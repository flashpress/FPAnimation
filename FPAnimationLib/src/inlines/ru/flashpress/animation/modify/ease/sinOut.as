/**
 * Created by sam on 17.02.16.
 */
package ru.flashpress.animation.modify.ease {
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.nsFPAnimation;
    import ru.flashpress.animation.modify.FPEase;

    [Inline]
    public function sinOut(animation:FPInterval, duration:int):FPEase
    {
        use namespace nsFPAnimation;
        //
        var _animation:FPEase;
        if (FPEase.pool && FPEase.pool.length) {
            _animation = FPEase.pool.shift();
        } else {
            _animation = new FPEase();
        }
        _animation.ease = FPEase.sinEaseOut;
        _animation.initModify(animation, duration);
        //
        return _animation;
    }
}
