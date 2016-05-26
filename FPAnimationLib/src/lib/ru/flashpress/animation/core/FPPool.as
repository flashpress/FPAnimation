/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.core {
    import ru.flashpress.animation.FPAnimation;

    public class FPPool
    {
        use namespace nsFPAnimation;

        private var _count:int;
        private var list:Vector.<FPAnimation>;
        public function FPPool()
        {
            _count = 0;
            list = new <FPAnimation>[];
        }

        public function push(instance:FPAnimation):void
        {
            if (list.indexOf(instance) != -1) return;
            //
            list.push(instance);
            _count = list.length;
        }

        public function get length():int {return this._count;}

        [Inline]
        final public function shift():*
        {
            var anim:FPAnimation = list.shift();
            anim.create();
            _count = list.length;
            return anim;
        }
    }
}
