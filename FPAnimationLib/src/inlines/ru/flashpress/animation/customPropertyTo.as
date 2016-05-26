/**
 * Created by sam on 20.02.16.
 */
package ru.flashpress.animation {
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function customPropertyTo(property:String, toValue:Number, duration:Number):FPCustomProperty
    {
        use namespace nsFPAnimation;
        //
        var animation:FPCustomProperty;
        if(FPCustomProperty.pool && FPCustomProperty.pool.length) {
            animation = FPCustomProperty.pool.shift();
        } else {
            animation = new FPCustomProperty();
        }
        animation._propertyFlags = FPProperty.RELATIVELY;
        animation._duration = duration;
        animation.property = property;
        animation.toValue = toValue;
        return animation;
    }
}
