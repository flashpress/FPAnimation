/**
 * Created by sam on 30.03.16.
 */
package ru.flashpress.animation.instant
{
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function removeFromParentInst():FPRemoveFromParent
    {
        use namespace nsFPAnimation;
        var animation:FPRemoveFromParent;
        if (FPRemoveFromParent.pool && FPRemoveFromParent.pool.length) {
            animation = FPRemoveFromParent.pool.shift();
        } else {
            animation = new FPRemoveFromParent();
        }
        return animation;
    }
}
