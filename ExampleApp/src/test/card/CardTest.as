/**
 * Created by sam on 26.05.16.
 */
package test.card {
    import flash.display.Sprite;
    import flash.filters.BlurFilter;

    import ru.flashpress.animation.FPAnimation;
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.display.FPRotate3D;
    import ru.flashpress.animation.display.moveFromToX;
    import ru.flashpress.animation.display.rotate3dFromTo;
    import ru.flashpress.animation.display.scaleTo;
    import ru.flashpress.animation.group.FPSync;
    import ru.flashpress.animation.group.sequence;
    import ru.flashpress.animation.group.sync;
    import ru.flashpress.animation.modify.ease.strongOut;
    import ru.flashpress.animation.modify.loop;
    import ru.flashpress.animation.modify.reverse;
    import ru.flashpress.animation.modify.waveLinear;
    import ru.flashpress.animation.modify.waveVariable;
    import ru.flashpress.animation.timeout;

    public class CardTest extends Sprite
    {
        public function CardTest()
        {
            FPAnimation.init(stage);
            //
            var cardView:CardView = new CardView();
            this.addChild(cardView);
            cardView.x = 100;
            cardView.y = 300;
            //
            var duration1:int = 500;
            var duration2:int = 1000;
            var duration3:int = 800;
            //
            var rotateAnim:FPRotate3D = rotate3dFromTo(0, 0, 0, 0, -180, 0, duration1);
            rotateAnim.target = cardView.cont;
            rotateAnim.registerChangeCallback(cardView.changeRotate);
            var flipAnim:FPSync = sync([rotateAnim, waveLinear(scaleTo(0.7, duration1), 0.3, 1, 0)]);
            flipAnim.registerChangeCallback(function(position:Number):void
            {
                var blurValue:Number = position < 0.5 ? position/0.5 : 1-(position-0.5)/0.5;
                cardView.filters = [new BlurFilter(80*blurValue, 0)];
            });
            //
            var bounceAnim:FPInterval = sync([strongOut(moveFromToX(450, 550, duration2), 0), waveVariable(scaleTo(0.7, duration2*0.6), new <Number>[0.1, .02], 0)]);
            var flipGoAnim:FPInterval = sequence([sync([flipAnim, moveFromToX(100, 450, duration1)]), bounceAnim]);
            //
            var flipBackAnim:FPInterval = sync([reverse(flipAnim, duration3), moveFromToX(550, 100, duration3)]);
            //
            var animation:FPInterval = loop(sequence([timeout(10000), flipGoAnim, strongOut(flipBackAnim, 0), timeout(1000)]), 0, 0);
            animation.target = cardView;
            animation.play();
        }
    }
}



import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Matrix3D;
import flash.geom.PerspectiveProjection;
import flash.geom.Point;

class CardView extends Sprite
{
    [Embed(source="back.png")]
    private var Card0Class:Class;

    [Embed(source="card.png")]
    private var Card1Class:Class;

    public var cont:Sprite;
    private var card0:Bitmap;
    private var card1:Bitmap;
    public function CardView()
    {
        var perspective:PerspectiveProjection = new PerspectiveProjection();
        perspective.projectionCenter = new Point(0, 0);
        perspective.focalLength = 400;
        this.transform.perspectiveProjection = perspective;
        //
        cont = new Sprite();
        //
        card0 = new Card0Class();
        card0.x = -card0.width/2;
        card0.y = -card0.height/2;
        //
        card1 = new Card1Class();
        card1.scaleX = -1;
        card1.x = card1.width/2;
        card1.y = -card1.height/2;
        card1.visible = false;
        //
        this.addChild(cont);
        cont.addChild(card1);
        cont.addChild(card0);
        //
        this.scaleX = this.scaleY = 0.7;
    }

    public function reinit():void
    {
        this.scaleX = this.scaleY = 0.7;
        this.cont.transform.matrix3D = new Matrix3D();
        this.card0.visible = true;
        this.card1.visible = !this.card0.visible;
    }

    public function changeRotate():void
    {
        this.card0.visible = this.cont.rotationY > -90;
        this.card1.visible = !this.card0.visible;
    }
}
