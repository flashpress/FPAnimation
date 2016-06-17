/**
 * Created by sam on 24.03.16.
 */
package ru.flashpress.animation.instant
{
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function callbackInst(func:Function, ...parameters):FPCallback
    {
        use namespace nsFPAnimation;
        var animation:FPCallback;
        if (FPCallback.pool && FPCallback.pool.length) {
            animation = FPCallback.pool.shift();
        } else {
            animation = new FPCallback();
        }
        animation.func = func;
        animation.parameters = parameters;
        return animation;
    }
}
