# FPAnimation

Example shake anim
```ActionScript
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
// Create animation for moveY + Shake + Alpha
var rootAnim:FPInterval = sync([elasticOut(moveFromToY(100, 300, 1000), 0), shakeOn('rotation', -30, 1000, null), alphaFromTo(0, 1, 300)]);
//
// Create reverse animation
var reverseAnim:FPReverse = FPReverse.create(rootAnim);
//
// Loop animation
var loopAnim:FPLoop = loop(sequence([setProperty('rotation', 0), rootAnim, reverseAnim, timeout(1000)]), 0, 0);
loopAnim.target = shape;
loopAnim.play();
```

Gif result:

![](images/shake_anim.gif)
