/**
 * Created by sam on 08.11.15.
 */
package ru.flashpress.animation.text {
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPTextNum extends FPProperty
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function createTo(toValue:Number, duration:Number=0, fixedCount:int=0):FPTextNum
        {
            var animation:FPTextNum;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPTextNum();
            }
            animation._propertyFlags = FPProperty.RELATIVELY;
            animation._duration = duration;
            animation._toValue = toValue;
            animation.fixedCount = fixedCount;
            return animation;
        }
        public static function createFromTo(fromValue:Number, toValue:Number, duration:Number=0, fixedCount:int=0):FPTextNum
        {
            var animation:FPTextNum;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPTextNum();
            }
            animation._propertyFlags = 0;
            animation._duration = duration;
            animation._fromValue = fromValue;
            animation._toValue = toValue;
            animation.fixedCount = fixedCount;
            return animation;
        }


        private var _toValue:Number;
        private var _fromValue:Number;
        private var fixedCount:int;
        public function FPTextNum()
        {
            super();
            _flags |= FPAnimFlags.TEXT;
        }

        nsFPAnimation override function beginForSequence():void
        {
            super.beginForSequence();
            this.begin();
        }

        private var _value:Number;
        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            //
            _value = _fromValue + (_toValue-_fromValue)*position + _wave;
            currentTarget.text = _value.toFixed(fixedCount);
        }

        protected override function initFromValue():void
        {
            _fromValue = Number(currentTarget.text);
        }

        public function set valueTo(value:Number):void
        {
            this._toValue = value;
        }

        public override function release():void
        {
            super.release();
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
