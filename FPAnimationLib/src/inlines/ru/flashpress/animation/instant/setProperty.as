/**
 * Created by sam on 24.03.16.
 */
package ru.flashpress.animation.instant
{
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function setProperty(property:String, value:*):FPSetProperty
    {
        use namespace nsFPAnimation;

        var animation:FPSetProperty;
        if (FPSetProperty.pool && FPSetProperty.pool.length) {
            animation = FPSetProperty.pool.shift();
        } else {
            animation = new FPSetProperty();
        }
        animation.property = property;
        animation.value = value;
        return animation;
    }
}
