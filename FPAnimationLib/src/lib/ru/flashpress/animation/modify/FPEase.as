
 
package ru.flashpress.animation.modify
{
    import ru.flashpress.animation.*;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.FPPool;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPEase extends FPModify
    {
        use namespace nsFPAnimation;

        nsFPAnimation static var pool:FPPool;
        public static function create(ease:*, animation:FPInterval=null, duration:int=0):FPEase
        {
            var _animation:FPEase;
            if (pool && pool.length) {
                _animation = pool.shift();
            } else {
                _animation = new FPEase();
            }
            _animation.ease = ease;
            _animation.initModify(animation, duration);
            //
            return _animation;
        }

        nsFPAnimation var _ease:*;
        nsFPAnimation var _func:Function;
        public function FPEase()
        {
            super();
        }

        nsFPAnimation override function applyPosition(position:Number):void
        {
            position = _func.call(null, position, 0, 1, 1);
            super.applyPosition(position);
        }

        public function get ease():* {return this._ease;}
        public function set ease(value:*):void
        {
            if (this._ease == value) return;
            this._ease = value;
            this._func = value is Function ? value : funcByType(value);
        }

        public override function release():void
        {
            super.release();
            //
            _ease = null;
            _func = null;
            //
            if (!pool) pool = new FPPool();
            pool.push(this);
        }

        // get function by name *******************************************************************************
        public static function funcByType(type:String):Function
        {
            switch (type) {
                case REGULAR:           return regularEase;
                case ELASTIC_IN:        return elasticEaseIn;
                case ELASTIC_OUT:       return elasticEaseOut;
                case ELASTIC_IN_OUT:    return elasticEaseInOut;
                case STRONG_IN:         return strongEaseIn;
                case STRONG_OUT:        return strongEaseOut;
                case STRONG_IN_OUT:     return strongEaseInOut;
                case BACK_IN:           return backEaseIn;
                case BACK_OUT:          return backEaseOut;
                case BACK_IN_OUT:       return backEaseInOut;
                case CIRC_IN:           return circEaseIn;
                case CIRC_OUT:          return circEaseOut;
                case CIRC_IN_OUT:       return circEaseInOut;
                case CUBIC_IN:          return cubicEaseIn;
                case CUBIC_OUT:         return cubicEaseOut;
                case CUBIC_IN_OUT:      return cubicEaseInOut;
                case EXP_IN:            return expEaseIn;
                case EXP_OUT:           return expEaseOut;
                case EXP_IN_OUT:        return expEaseInOut;
                case QUAD_IN:           return quadEaseIn;
                case QUAD_OUT:          return quadEaseOut;
                case QUAD_IN_OUT:       return quadEaseInOut;
                case QUART_IN:          return quartEaseIn;
                case QUART_OUT:         return quartEaseOut;
                case QUART_IN_OUT:      return quartEaseInOut;
                case QUINT_IN:          return quintEaseIn;
                case QUINT_OUT:         return quintEaseOut;
                case QUINT_IN_OUT:      return quintEaseInOut;
                case SIN_IN:            return sinEaseIn;
                case SIN_OUT:           return sinEaseOut;
                case SIN_IN_OUT:        return sinEaseInOut;
                case BOUNCE_IN:         return bounceEaseIn;
                case BOUNCE_OUT:        return bounceEaseOut;
                case BOUNCE_IN_OUT:     return bounceEaseInOut;
            }
            return regularEase;
        }

        // constants ******************************************************************************************

        public static const REGULAR:String = 'regular';
        public static const STRONG_IN:String = 'strongIn';
        public static const STRONG_OUT:String = 'strongOut';
        public static const STRONG_IN_OUT:String = 'strongInOut';
        public static const BACK_IN:String = 'backIn';
        public static const BACK_OUT:String = 'backOut';
        public static const BACK_IN_OUT:String = 'backInOut';
        public static const CIRC_IN:String = 'circIn';
        public static const CIRC_OUT:String = 'circOut';
        public static const CIRC_IN_OUT:String = 'circInOut';
        public static const CUBIC_IN:String = 'cubicIn';
        public static const CUBIC_OUT:String = 'cubicOut';
        public static const CUBIC_IN_OUT:String = 'cubicInOut';
        public static const ELASTIC_IN:String = 'elasticIn';
        public static const ELASTIC_OUT:String = 'elasticOut';
        public static const ELASTIC_IN_OUT:String = 'elasticInOut';
        public static const EXP_IN:String = 'expIn';
        public static const EXP_OUT:String = 'expOut';
        public static const EXP_IN_OUT:String = 'expInOut';
        public static const QUAD_IN:String = 'quadIn';
        public static const QUAD_OUT:String = 'quadOut';
        public static const QUAD_IN_OUT:String = 'quadInOut';
        public static const QUART_IN:String = 'quartIn';
        public static const QUART_OUT:String = 'quartOut';
        public static const QUART_IN_OUT:String = 'quartInOut';
        public static const QUINT_IN:String = 'quintIn';
        public static const QUINT_OUT:String = 'quintOut';
        public static const QUINT_IN_OUT:String = 'quintInOut';
        public static const SIN_IN:String = 'sinIn';
        public static const SIN_OUT:String = 'sinOut';
        public static const SIN_IN_OUT:String = 'sinInOut';

        public static const BOUNCE_IN:String = 'bounceIn';
        public static const BOUNCE_OUT:String = 'bounceOut';
        public static const BOUNCE_IN_OUT:String = 'bounceInOut';


        // functions ******************************************************************************************

        public static function regularEase(t:Number, b:Number, c:Number, d:Number):Number {
            return t;
        }

        public static function strongEaseIn(t:Number, b:Number, c:Number, d:Number):Number  {
            return c*(t/=d)*t*t*t*t+b;
        }
        public static function strongEaseOut(t:Number, b:Number,c:Number, d:Number):Number {
            return c*((t=t/d-1)*t*t*t*t+1)+b;
        }
        public static function strongEaseInOut(t:Number, b:Number, c:Number, d:Number):Number {
            if ((t/=d/2) < 1) return c/2*t*t*t*t*t+b;
            //
            return c/2*((t-=2)*t*t*t*t+2)+b;
        }

        public static function backEaseIn(t:Number, b:Number, c:Number, d:Number):Number  {
            var s:Number = 1.70158;
            return c*(t/=d)*t*((s+1)*t - s) + b;
        }
        public static function backEaseOut(t:Number, b:Number, c:Number, d:Number):Number {
            var s:Number = 1.70158;
            return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
        }
        public static function backEaseInOut(t:Number, b:Number, c:Number, d:Number):Number {
            var s:Number = 1.70158;
            if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
            //
            return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
        }

        public static function elasticEaseIn(t:Number, b:Number, c:Number, d:Number, a:Number=0, p:Number=0):Number {
            if (t == 0)
                return b;

            if ((t /= d) == 1)
                return b + c;

            if (!p)
                p = d * 0.3;

            var s:Number;
            if (!a || a < Math.abs(c))
            {
                a = c;
                s = p / 4;
            }
            else
            {
                s = p / (2 * Math.PI) * Math.asin(c / a);
            }

            return -(a * Math.pow(2, 10 * (t -= 1)) *
                     Math.sin((t * d - s) * (2 * Math.PI) / p)) + b;
        }
        public static function elasticEaseOut(t:Number, b:Number, c:Number, d:Number, a:Number=0, p:Number=0):Number {
            if (t == 0)
                return b;

            if ((t /= d) == 1)
                return b + c;

            if (!p)
                p = d * 0.3;

            var s:Number;
            if (!a || a < Math.abs(c))
            {
                a = c;
                s = p / 4;
            }
            else
            {
                s = p / (2 * Math.PI) * Math.asin(c / a);
            }

            return a * Math.pow(2, -10 * t) *
                   Math.sin((t * d - s) * (2 * Math.PI) / p) + c + b;
        }
        public static function elasticEaseInOut(t:Number, b:Number, c:Number, d:Number, a:Number=0, p:Number=0):Number {
            if (t == 0)
                return b;

            if ((t /= d / 2) == 2)
                return b + c;

            if (!p)
                p = d * (0.3 * 1.5);

            var s:Number;
            if (!a || a < Math.abs(c))
            {
                a = c;
                s = p / 4;
            }
            else
            {
                s = p / (2 * Math.PI) * Math.asin(c / a);
            }

            if (t < 1)
            {
                return -0.5 * (a * Math.pow(2, 10 * (t -= 1)) *
                       Math.sin((t * d - s) * (2 * Math.PI) /p)) + b;
            }

            return a * Math.pow(2, -10 * (t -= 1)) *
                   Math.sin((t * d - s) * (2 * Math.PI) / p ) * 0.5 + c + b;
        }

        public static function circEaseIn(t:Number, b:Number, c:Number, d:Number):Number {
            return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
        }
        public static function circEaseOut(t:Number, b:Number, c:Number, d:Number):Number {
            return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
        }
        public static function circEaseInOut(t:Number, b:Number, c:Number, d:Number):Number {
            if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
            //
            return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
        }

        public static function cubicEaseIn(t:Number, b:Number, c:Number, d:Number):Number {
            return c*(t/=d)*t*t + b;
        }
        public static function cubicEaseOut(t:Number, b:Number, c:Number, d:Number):Number {
            return c*((t=t/d-1)*t*t + 1) + b;
        }
        public static function cubicEaseInOut(t:Number, b:Number, c:Number, d:Number):Number {
            if ((t/=d/2) < 1) return c/2*t*t*t + b;
            //
            return c/2*((t-=2)*t*t + 2) + b;
        }

        public static function expEaseIn(t:Number, b:Number, c:Number, d:Number):Number {
            return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b;
        }
        public static function expEaseOut(t:Number, b:Number, c:Number, d:Number):Number {
            return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b;
        }
        public static function expEaseInOut(t:Number, b:Number, c:Number, d:Number):Number {
            if (t==0) return b;
            if (t==d) return b+c;
            if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
            //
            return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
        }

        public static function quadEaseIn(t:Number, b:Number, c:Number, d:Number):Number {
            return c*(t/=d)*t + b;
        }
        public static function quadEaseOut(t:Number, b:Number, c:Number, d:Number):Number {
            return -c *(t/=d)*(t-2) + b;
        }
        public static function quadEaseInOut(t:Number, b:Number, c:Number, d:Number):Number {
            if ((t/=d/2) < 1) return c/2*t*t + b;
            //
            return -c/2 * ((--t)*(t-2) - 1) + b;
        }

        public static function quartEaseIn(t:Number, b:Number, c:Number, d:Number):Number {
            return c*(t/=d)*t*t*t + b;
        }
        public static function quartEaseOut(t:Number, b:Number, c:Number, d:Number):Number {
            return -c * ((t=t/d-1)*t*t*t - 1) + b;
        }
        public static function quartEaseInOut(t:Number, b:Number, c:Number, d:Number):Number {
            if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
            //
            return -c/2 * ((t-=2)*t*t*t - 2) + b;
        }

        public static function quintEaseIn(t:Number, b:Number, c:Number, d:Number):Number {
            return c*(t/=d)*t*t*t*t + b;
        }
        public static function quintEaseOut(t:Number, b:Number, c:Number, d:Number):Number {
            return c*((t=t/d-1)*t*t*t*t + 1) + b;
        }
        public static function quintEaseInOut(t:Number, b:Number, c:Number, d:Number):Number {
            if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
            return c/2*((t-=2)*t*t*t*t + 2) + b;
        }

        public static function sinEaseIn(t:Number, b:Number, c:Number, d:Number):Number {
            return -c * Math.cos(t/d * (Math.PI/2)) + c + b;
        }
        public static function sinEaseOut(t:Number, b:Number, c:Number, d:Number):Number {
            return c * Math.sin(t/d * (Math.PI/2)) + b;
        }
        public static function sinEaseInOut(t:Number, b:Number, c:Number, d:Number):Number {
            return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
        }

        public static function bounceEaseIn(t:Number, b:Number, c:Number, d:Number):Number
        {
            return c-bounceEaseOut(d-t, 0, c, d);
        }
        public static function bounceEaseOut(t:Number, b:Number, c:Number, d:Number):Number
        {
            if ((t/=d) < (1/2.75)) {
                return c*(7.5625*t*t) + b;
            } else if (t < (2/2.75)) {
                return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
            } else if (t < (2.5/2.75)) {
                return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
            } else {
                return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
            }
        }
        public static function bounceEaseInOut(t:Number, b:Number, c:Number, d:Number):Number
        {
            if (t < d/2) return bounceEaseIn(t*2, 0, c, d) * .5 + b;
            return bounceEaseOut(t*2-d, 0, c, d) * .5 + c*.5 + b;
        }

    }
}

