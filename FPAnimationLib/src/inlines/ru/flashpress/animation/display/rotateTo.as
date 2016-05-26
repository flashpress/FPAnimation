/**
 * Created by sam on 17.02.16.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function rotateTo(toRotate:Number, duration:Number):FPRotate
    {
        use namespace nsFPAnimation;
        //
        var animation:FPRotate;
        if (FPRotate.pool && FPRotate.pool.length) {
            animation = FPRotate.pool.shift();
        } else {
            animation = new FPRotate();
        }
        animation._propertyFlags = FPProperty.RELATIVELY;
        animation.toRotate = toRotate;
        animation._duration = duration;
        return animation;
    }
}
