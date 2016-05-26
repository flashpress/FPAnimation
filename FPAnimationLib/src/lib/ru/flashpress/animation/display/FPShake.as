/**
 * Created by sam on 18.04.16.
 */
package ru.flashpress.animation.display {

    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPShake extends FPDisplay
    {
        use namespace nsFPAnimation;

        nsFPAnimation static function easeAnim(t:Number, b:Number, c:Number, d:Number):Number
        {
            var s:Number=4;
            var p:Number=0;
            var a:Number=c;
            //
            if (t==0) return b;
            if ((t/=d)==1) return b+c;
            if (!p) p=d*.3;
            if (a < Math.abs(c)) {
                a=c;
                //s=p/4;
            } else {
                //s = p/(2*Math.PI) * Math.asin (c/a);
            }
            return a*Math.pow(1.4,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b;
        }

        nsFPAnimation static var pool:FPPool;
        public static function create(property:String, delta:Number=-5, duration:int=500, ease:Function=null):FPShake
        {
            var animation:FPShake;
            if (pool && pool.length) {
                animation = pool.shift();
            } else {
                animation = new FPShake();
            }
            animation._delta = delta;
            animation._property = property;
            animation._func = ease ? ease : easeAnim;
            animation._duration = duration;
            animation._propertyFlags |= RELATIVELY;
            return animation;
        }

        public function FPShake()
        {
        }

        public var fromValue:Number;
        protected override function initFromValue():void
        {
            fromValue = currentTarget[_property];
        }

        nsFPAnimation var _delta:Number;
        public function get delta():Number {return this._delta;}

        nsFPAnimation var _func:Function;
        public function set easeFunc(value:Function):void {this._func = value;}

        nsFPAnimation var _property:String;
        public function get property():String {return this._property;}

        nsFPAnimation override function applyPosition(position:Number):void
        {
            position = _func.call(null, position, 0, 1, 1);
            position = 1-position;
            super.applyPosition(position);
            //
            if (_propertyFlags & ADDITIONAL) {
                currentTarget[_property] += _delta * position;
            } else {
                currentTarget[_property] = fromValue + _delta * position;
            }
        }

        public override function release():void
        {
            super.release();
            //
            _func = null;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }
    }
}
