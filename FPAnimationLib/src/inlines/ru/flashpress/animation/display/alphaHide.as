/**
 * Created by sam on 24.03.16.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function alphaHide(duration:Number):FPAlpha
    {
        use namespace nsFPAnimation;
        //
        var animation:FPAlpha;
        if (FPAlpha.pool && FPAlpha.pool.length) {
            animation = FPAlpha.pool.shift() as FPAlpha;
        } else {
            animation = new FPAlpha();
        }
        animation._propertyFlags = FPProperty.RELATIVELY;
        animation.toAlpha = 0;
        animation._duration = duration;
        return animation;
    }
}
