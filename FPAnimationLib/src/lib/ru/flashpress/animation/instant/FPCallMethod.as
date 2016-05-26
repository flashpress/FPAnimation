/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.instant {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPCallMethod extends FPInstant
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(methodName:String, ...parameters):FPCallMethod
        {
            var animation:FPCallMethod;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPCallMethod();
            }
            animation.methodName = methodName;
            animation.parameters = parameters;
            return animation;
        }

        public function FPCallMethod()
        {
            super();
        }

        private var methodName:String;
        private var parameters:Array;
        public override function activate():void
        {
            super.activate();
            //
            currentTarget[methodName].apply(null, parameters);
        }

        public override function release():void
        {
            super.release();
            //
            parameters = null;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
