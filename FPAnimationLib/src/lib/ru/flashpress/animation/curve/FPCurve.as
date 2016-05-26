/**
 * Created by sam on 06.11.15.
 */
package ru.flashpress.animation.curve {
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPCurve extends FPInterval
    {
        use namespace nsFPAnimation;

        public function FPCurve()
        {
            super();
            this._flags = FPAnimFlags.CURVE;
        }
    }
}
