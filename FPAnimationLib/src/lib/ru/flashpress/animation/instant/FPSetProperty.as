/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.instant {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPSetProperty extends FPInstant
    {
        use namespace nsFPAnimation;

        nsFPAnimation static var pool:FPPool;
        public static function create(property:String, value:*):FPSetProperty
        {
            var animation:FPSetProperty;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPSetProperty();
            }
            animation.property = property;
            animation.value = value;
            return animation;
        }

        public function FPSetProperty()
        {
            super();
        }

        public function init(property:String, value:*):void
        {
            this.property = property;
            this.value = value;
        }

        nsFPAnimation var property:String;
        nsFPAnimation var value:*;
        public override function activate():void
        {
            super.activate();
            //
            currentTarget[property] = value;
        }

        public override function release():void
        {
            super.release();
            //
            property = null;
            value = null;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
