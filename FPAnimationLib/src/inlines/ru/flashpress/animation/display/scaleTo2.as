/**
 * Created by sam on 17.02.16.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function scaleTo2(toX:Number, toY:Number, duration:Number):FPScale
    {
        use namespace nsFPAnimation;
        var animation:FPScale;
        if (FPScale.pool && FPScale.pool.length) {
            animation = FPScale.pool.shift();
        } else {
            animation = new FPScale();
        }
        animation._propertyFlags = FPProperty.RELATIVELY;
        animation._duration = duration;
        animation.toX = toX;
        animation.toY = toY;
        return animation;
    }
}
