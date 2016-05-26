/**
 * Created by sam on 17.02.16.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function scaleFromTo(from:Number, to:Number, duration:Number):FPScale
    {
        use namespace nsFPAnimation;

        var animation:FPScale;
        if (FPScale.pool && FPScale.pool.length) {
            animation = FPScale.pool.shift();
        } else {
            animation = new FPScale();
        }
        animation._propertyFlags = 0;
        animation._duration = duration;
        animation.fromX = from;
        animation.fromY = from;
        animation.toX = to;
        animation.toY = to;
        return animation;
    }
}
