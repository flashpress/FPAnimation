/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.group {
    import ru.flashpress.animation.FPAnimation;
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    internal class FPGroup extends FPInterval
    {
        use namespace nsFPAnimation;

        protected var count:int;
        protected var list:Vector.<FPAnimation>;
        public function FPGroup()
        {
            super();
            _flags |= FPAnimFlags.GROUP;
            list = new <FPAnimation>[];
        }

        nsFPAnimation function init(animationsList:*):void
        {
            list.length = 0;
            var i:int;
            var anim:FPAnimation;
            for (i=0; i<animationsList.length; i++) {
                anim = animationsList[i];
                anim._parent = this;
                list.push(anim);
            }
            count = list.length;
        }

        nsFPAnimation override function beginForSequence():void
        {
            super.beginForSequence();
            var i:int;
            for (i=0; i<list.length; i++) {
                list[i].beginForSequence();
            }
        }

        public function get animations():Vector.<FPAnimation> {return this.list;}

        public override function release():void
        {
            super.release();
            //
            var i:int;
            for (i=0; i<list.length; i++) {
                list[i].release();
            }
            list.length = 0;
            count = 0;
        }
    }
}
