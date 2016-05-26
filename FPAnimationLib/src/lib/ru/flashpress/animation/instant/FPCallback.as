/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.instant {
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPCallback extends FPInstant
    {
        use namespace nsFPAnimation;

        private static var pool:FPPool;
        public static function create(func:Function, ...parameters):FPCallback
        {
            var animation:FPCallback;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPCallback();
            }
            animation.func = func;
            animation.parameters = parameters;
            return animation;
        }

        private var func:Function;
        private var parameters:Array;
        public function FPCallback()
        {
            super();
        }

        public override function activate():void
        {
            super.activate();
            //
            if (func.length == parameters.length) {
                func.apply(null, parameters);
            } else {
                var t:Array = [this].concat(parameters);
                func.apply(null, t);
            }
        }

        public override function release():void
        {
            super.release();
            this.func = null;
            this.parameters = null;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
