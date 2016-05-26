/**
 * Created by sam on 17.02.16.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.core.nsFPAnimation;

    [Inline]
    public function moveFromTo(fromX:Number, fromY:Number, toX:Number, toY:Number, duration:Number):FPMove
    {
        use namespace nsFPAnimation;
        //
        var animation:FPMove;
        if (FPMove.pool && FPMove.pool.length) {
            animation = FPMove.pool.shift() as FPMove;
        } else {
            animation = new FPMove();
        }
        animation._propertyFlags = 0;
        animation._duration = duration;
        animation.moveFlags = FPMove.FLAG_X | FPMove.FLAG_Y;
        animation.fromX = fromX;
        animation.fromY = fromY;
        animation.toX = toX;
        animation.toY = toY;
        return animation;
    }
}
