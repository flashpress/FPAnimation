/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPUpdateProperty extends FPInterval
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(property:String, value:*, duration:Number=0):FPUpdateProperty
        {
            var animation:FPUpdateProperty;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPUpdateProperty();
            }
            animation._duration = duration;
            animation.property = property;
            animation.value = value;
            return animation;
        }

        public function FPUpdateProperty()
        {
            super();
        }

        private var property:String;
        private var value:*;
        public function init(property:String, value:*):void
        {
            this.property = property;
            this.value = value;
        }

        nsFPAnimation override function beginForSequence():void
        {
            super.beginForSequence();
            this.begin();
        }
        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            currentTarget[property] = value;
        }

        public override function release():void
        {
            super.release();
            //
            property = null;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
