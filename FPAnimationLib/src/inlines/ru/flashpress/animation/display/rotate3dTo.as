/**
 * Created by sam on 17.02.16.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function rotate3dTo(toX:Number, toY:Number, toZ:Number, duration:Number):FPRotate3D
    {
        use namespace nsFPAnimation;
        //
        var animation:FPRotate3D;
        if (FPRotate3D.pool && FPRotate3D.pool.length) {
            animation = FPRotate3D.pool.shift();
        } else {
            animation = new FPRotate3D();
        }
        animation._propertyFlags = FPProperty.RELATIVELY;
        animation.toX = toX;
        animation.toY = toY;
        animation.toZ = toZ;
        animation._duration = duration;
        return animation;
    }
}
