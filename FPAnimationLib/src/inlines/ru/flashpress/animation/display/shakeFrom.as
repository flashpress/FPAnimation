/**
 * Created by sam on 18.04.16.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function shakeFrom(fromValue:Number, property:String, delta:Number, duration:int, ease:Function):FPShake
    {
        use namespace nsFPAnimation;
        //
        var animation:FPShake;
        if (FPShake.pool && FPShake.pool.length) {
            animation = FPShake.pool.shift();
        } else {
            animation = new FPShake();
        }
        animation._delta = delta;
        animation._property = property;
        animation._func = ease ? ease : FPShake.easeAnim;
        animation._duration = duration;
        animation.fromValue = fromValue;
        return animation;
    }
}
