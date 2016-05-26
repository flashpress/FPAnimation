/**
 * Created by sam on 19.11.15.
 */
package ru.flashpress.animation.display {
    import ru.flashpress.animation.FPProperty;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPDisplay extends FPProperty
    {
        use namespace nsFPAnimation;
        public function FPDisplay()
        {
            super();
            _flags |= FPAnimFlags.DISPLAY;
        }
    }
}
