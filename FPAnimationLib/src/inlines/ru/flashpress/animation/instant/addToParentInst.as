/**
 * Created by sam on 30.03.16.
 */
package ru.flashpress.animation.instant
{
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function addToParentInst(target:*):FPAddToParent
    {
        use namespace nsFPAnimation;
        var animation:FPAddToParent;
        if (FPAddToParent.pool && FPAddToParent.pool.length) {
            animation = FPAddToParent.pool.shift();
        } else {
            animation = new FPAddToParent();
        }
        animation._target = target;
        return animation;
    }
}
