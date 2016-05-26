/**
 * Created by sam on 20.02.16.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function alphaFromTo(fromAlpha:Number, toAlpha:Number, duration:Number):FPAlpha
    {
        use namespace nsFPAnimation;
        //
        var animation:FPAlpha;
        if (FPAlpha.pool && FPAlpha.pool.length) {
            animation = FPAlpha.pool.shift();
        } else {
            animation = new FPAlpha();
        }
        animation._propertyFlags = 0;
        animation.fromAlpha = fromAlpha;
        animation.toAlpha = toAlpha;
        animation._duration = duration;
        return animation;
    }
}
