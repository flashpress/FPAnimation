/**
 * Created by sam on 20.02.16.
 */
package ru.flashpress.animation {
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function customPropertyFromTo(property:String, fromValue:Number, toValue:Number, duration:Number):FPCustomProperty
    {
        use namespace nsFPAnimation;
        //
        var animation:FPCustomProperty;
        if (FPCustomProperty.pool && FPCustomProperty.pool.length) {
            animation = FPCustomProperty.pool.shift();
        } else {
            animation = new FPCustomProperty();
        }
        animation._propertyFlags = 0;
        animation._duration = duration;
        animation.property = property;
        animation.fromValue = fromValue;
        animation.toValue = toValue;
        return animation;
    }
}
