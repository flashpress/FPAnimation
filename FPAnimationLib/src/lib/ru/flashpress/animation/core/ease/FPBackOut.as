/**
 * Created by sam on 20.11.15.
 */
package ru.flashpress.animation.core.ease {
    public class FPBackOut
    {
        private var force:Number;
        public function FPBackOut(force:Number=1.70158)
        {
            this.force = force;
        }

        public function backEaseIn(t:Number, b:Number, c:Number, d:Number):Number
        {
            return c*(t/=d)*t*((force+1)*t - force) + b;
        }
        public function backEaseOut(t:Number, b:Number, c:Number, d:Number):Number
        {
            return c*((t=t/d-1)*t*((force+1)*t + force) + 1) + b;
        }
        public function backEaseInOut(t:Number, b:Number, c:Number, d:Number):Number
        {
            if ((t/=d/2) < 1) return c/2*(t*t*(((force*=(1.525))+1)*t - force)) + b;
            //
            return c/2*((t-=2)*t*(((force*=(1.525))+1)*t + force) + 2) + b;
        }
    }
}
