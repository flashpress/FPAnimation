/**
 * Created by sam on 24.03.16.
 */
package ru.flashpress.animation.instant
{
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function setVisible(visible:Boolean):FPVisible
    {
        use namespace nsFPAnimation;
        var animation:FPVisible;
        if (FPVisible.pool && FPVisible.pool.length) {
            animation = FPVisible.pool.shift();
        } else {
            animation = new FPVisible();
        }
        animation.visibleValue = visible;
        return animation;
    }
}
