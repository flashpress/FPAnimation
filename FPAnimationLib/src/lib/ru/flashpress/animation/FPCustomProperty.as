/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPCustomProperty extends FPProperty
    {
        use namespace nsFPAnimation;

        nsFPAnimation static var pool:FPPool;
        public static function createTo(property:String, toValue:Number, duration:Number=0):FPCustomProperty
        {
            var animation:FPCustomProperty;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPCustomProperty();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation._duration = duration;
            animation.property = property;
            animation.toValue = toValue;
            return animation;
        }
        public static function createFromTo(property:String, fromValue:Number, toValue:Number, duration:Number=0):FPCustomProperty
        {
            var animation:FPCustomProperty;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPCustomProperty();
            }
            animation._propertyFlags = 0;
            animation._duration = duration;
            animation.property = property;
            animation.fromValue = fromValue;
            animation.toValue = toValue;
            return animation;
        }

        public function FPCustomProperty()
        {
            super();
        }

        nsFPAnimation var property:String;
        nsFPAnimation var toValue:Number;
        nsFPAnimation var fromValue:Number;
        public function init(property:String, value:Number):void
        {
            this.property = property;
            this.toValue = value;
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
            currentTarget[property] = fromValue + (toValue-fromValue)*position + _wave;
        }

        protected override function initFromValue():void
        {
            fromValue = currentTarget[property];
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
