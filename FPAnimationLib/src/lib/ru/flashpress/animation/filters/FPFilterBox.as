/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.filters {
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPFilterBox extends FPInterval
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        private static function create(...filtersList):FPFilterBox
        {
            var animation:FPFilterBox;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPFilterBox();
            }
            animation.init(filtersList);
            return animation;
        }

        protected var count:int;
        protected var list:Vector.<FPFilter>;
        public function FPFilterBox()
        {
            super();
            this._flags |= FPAnimFlags.FILTER;
            //
            list = new <FPFilter>[];
        }

        private function init(filtersList:*):void
        {
            list.length = 0;
            var i:int;
            if (filtersList[0] is Array || filtersList[0] is Vector.<FPInterval>) {
                filtersList = filtersList[0];
            }
            var filter:FPFilter;
            for (i=0; i<filtersList.length; i++) {
                filter = filtersList[i];
                filter._parent = this;
                list.push(filter);
            }
            count = list.length;
        }

        private var i1:int;
        private var filter1:FPFilter;
        public override function begin():void
        {
            super.begin();
            //
            var dur:int = 0;
            for (i1=0; i1<count; i1++) {
                filter1 = list[i1];
                dur = Math.max(dur, filter1._duration);
            }
            filter1 = null;
            this._duration = dur;
        }

        private var i2:int;
        nsFPAnimation override function applyPosition(position:Number):void
        {
            var filters:Array = [];
            var filter:FPFilter;
            for (i2=0; i2<count; i2++) {
                filter = list[i2];
                filter.applyPosition(position);
                filter.addToList(filters);
            }
            currentTarget.filters = filters;
        }

        nsFPAnimation override function beginForSequence():void
        {
            super.beginForSequence();
            var i:int;
            for (i=0; i<count; i++) {
                list[i].beginForSequence();
            }
        }

        public override function release():void
        {
            super.release();
            //
            var i:int;
            for (i=0; i<count; i++) {
                list[i].release();
            }
            list.length = 0;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
