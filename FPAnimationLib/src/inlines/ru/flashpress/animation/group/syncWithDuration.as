/**
 * Created by sam on 23.03.16.
 */
package ru.flashpress.animation.group
{
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function syncWithDuration(duration:int, animationsList:Array):FPSync
    {
        use namespace nsFPAnimation;
        //
        var animation:FPSync;
        if (FPSync.pool && FPSync.pool.length) {
            animation = FPSync.pool.shift();
        } else {
            animation = new FPSync();
        }
        animation.init(animationsList);
        animation.initDuration = duration;
        return animation;
    }
}
