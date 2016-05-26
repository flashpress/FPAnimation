# FPAnimation

## Shake animation example
Gif result:

<img src="images/shake_anim.gif" data-canonical-src="images/shake_anim.gif" width="150" />

Source code with **[Inline]** functions:
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
// Create sync animation for moveY + Shake + Alpha
var rootAnim:FPInterval = sync([elasticOut(moveFromToY(100, 300, 1000), 0), shakeOn('rotation', -30, 1000, null), alphaFromTo(0, 1, 300)]);
//
// Create reverse animation
var reverseAnim:FPReverse = reverse(rootAnim);
//
// Loop animation
var loopAnim:FPLoop = loop(sequence([setProperty('rotation', 0), rootAnim, reverseAnim, timeout(1000)]), 0, 0);
loopAnim.target = shape;
loopAnim.play();
```

Source code without **[Inline]** functions: 
```ActionScript
// Create sync animation for moveY + Shake + Alpha
var moveAnim:FPMove = FPMove.createFromToY(100, 300, 1000);
var easeMove:FPEase = FPEase.create(FPEase.ELASTIC_OUT, moveAnim);
var shakeAnim:FPShake = FPShake.create('rotation', -30, 1000);
var alphaAnim:FPAlpha = FPAlpha.createFromTo(0, 1, 300);
var rootAnim:FPSync = FPSync.create(easeMove, shakeAnim, alphaAnim);
//
// Create reverse animation
var reverseAnim:FPReverse = FPReverse.create(rootAnim);
//
// Loop animation
var setInitProperty:FPSetProperty = FPSetProperty.create('rotation', 0);
var timeout:FPTimeout = FPTimeout.create(1000);
var sequenceAnim:FPSequence = FPSequence.create(setInitProperty, rootAnim, reverseAnim, timeout);
var loopAnim:FPLoop = FPLoop.create(sequenceAnim);
loopAnim.target = shape;
loopAnim.play();
```


## Card animation example

Gif result:

<img src="images/card_anim.gif" data-canonical-src="images/card_anim.gif" />

Source code: <a href="https://github.com/flashpress/FPAnimation/blob/master/ExampleApp/src/test/card/CardTest.as">ExampleApp/../CardTest.as</a>
