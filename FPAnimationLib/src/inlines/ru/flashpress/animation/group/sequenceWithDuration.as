/**
 * Created by sam on 23.03.16.
 */
package ru.flashpress.animation.group {
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function sequenceWithDuration(duration:int, animationsList:Array):FPSequence
    {
        use namespace nsFPAnimation;
        //
        var animation:FPSequence;
        if (FPSequence.pool && FPSequence.pool.length) {
            animation = FPSequence.pool.shift();
        } else {
            animation = new FPSequence();
        }
        animation.init(animationsList);
        animation.initDuration = duration;
        return animation;
    }
}
