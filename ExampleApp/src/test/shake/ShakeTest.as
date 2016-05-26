/**
 * Created by sam on 18.04.16.
 */
package test.shake
{
    import flash.display.Shape;
    import flash.display.Sprite;

    import ru.flashpress.animation.FPAnimation;
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.modify.FPLoop;
    import ru.flashpress.animation.display.alphaFromTo;
    import ru.flashpress.animation.display.moveFromToY;
    import ru.flashpress.animation.display.shakeOn;
    import ru.flashpress.animation.group.sequence;
    import ru.flashpress.animation.group.sync;
    import ru.flashpress.animation.instant.setProperty;
    import ru.flashpress.animation.modify.FPReverse;
    import ru.flashpress.animation.modify.ease.elasticOut;
    import ru.flashpress.animation.modify.loop;
    import ru.flashpress.animation.modify.reverse;
    import ru.flashpress.animation.timeout;

    public class ShakeTest extends Sprite
    {
        public function ShakeTest()
        {
            FPAnimation.init(stage);
            //
            var shape:Shape = new Shape();
            shape.graphics.beginFill(0xff0000, 1);
            shape.graphics.drawRect(-50, -50, 100, 100);
            shape.graphics.endFill();
            shape.x = 300;
            shape.y = 300;
            this.addChild(shape);
            //
            //
            // Create sync animation for moveY + Shake + Alpha
            var rootAnim:FPInterval = sync([elasticOut(moveFromToY(100, 300, 1000), 0), shakeOn('rotation', -30, 1000, null), alphaFromTo(0, 1, 300)]);
            //
            // Create reverse animation
            var reverseAnim:FPReverse = reverse(rootAnim, 0);
            //
            // Loop animation
            var loopAnim:FPLoop = loop(sequence([setProperty('rotation', 0), rootAnim, reverseAnim, timeout(1000)]), 0, 0);
            loopAnim.target = shape;
            loopAnim.play();
        }
    }
}
