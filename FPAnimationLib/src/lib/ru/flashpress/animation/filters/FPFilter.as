/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.filters {
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPFilter extends FPInterval
    {
        use namespace nsFPAnimation;
        public function FPFilter()
        {
            super();
            _flags |= FPAnimFlags.FILTER;
        }

        nsFPAnimation function addToList(list:Array):void {}

        nsFPAnimation override function beginForSequence():void
        {
            super.beginForSequence();
            this.begin();
        }
    }
}
