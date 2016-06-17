/**
 * Created by sam on 17.02.16.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function sizeToH(toHeight:Number, duration:Number):FPSize
    {
        use namespace nsFPAnimation;
        //
        var animation:FPSize;
        if (FPSize.pool && FPSize.pool.length) {
            animation = FPSize.pool.shift() as FPSize;
        } else {
            animation = new FPSize();
        }
        animation._propertyFlags = FPProperty.RELATIVELY;
        animation._duration = duration;

        animation.moveFlags = FPSize.FLAG_HEIGHT;
        animation.toHeight = toHeight;
        return animation;
    }
}
