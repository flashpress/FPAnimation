/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation {
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPProperty extends FPInterval
    {
        use namespace nsFPAnimation;

        public static const RELATIVELY:int = 0x1;
        public static const ADDITIONAL:int = 0x2;

        nsFPAnimation var  _propertyFlags:int = 0;
        public function FPProperty()
        {
            super();
            _flags |= FPAnimFlags.PROPERTY;
        }

        nsFPAnimation override function beginForSequence():void
        {
            this.begin();
            super.beginForSequence();
        }

        final public override function begin():void
        {
            super.begin();
            //
            if (_propertyFlags & RELATIVELY) {
                initFromValue();
            }
        }

        protected function initFromValue():void {}
    }
}
