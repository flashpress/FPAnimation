/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.core {
    public class FPrgbaUtils
    {
        public function FPrgbaUtils(color:uint=0)
        {
            if (color) {
                update(color);
            }
        }

        public function update(color:int):void
        {
            this.alpha = (color >> 24) & 0xff;
            this.red = (color >> 16) & 0xff;
            this.green = (color >> 8) & 0xff;
            this.blue = color & 0xff;
        }

        public function clear(value:int=0):void
        {
            alpha = value;
            red = value;
            green = value;
            blue = value;
        }

        public function interpolate(begin:FPrgbaUtils, finish:FPrgbaUtils, percent:Number, wave:Number):void
        {
            this.alpha = begin.alpha + (finish.alpha-begin.alpha)*percent + wave;
            this.red = begin.red + (finish.red-begin.red)*percent + wave;
            this.green = begin.green + (finish.green-begin.green)*percent + wave;
            this.blue = begin.blue + (finish.blue-begin.blue)*percent + wave;
        }

        public function getColor():uint
        {
            return (alpha<<24) + (red<<16) + (green<<8) + blue;
        }

        public var alpha:uint;
        public var red:uint;
        public var green:uint;
        public var blue:uint;

        public function toString():String
        {
            return '[a:'+alpha+', r:'+red+', g:'+green+', b:'+blue+']';
        }
    }
}
