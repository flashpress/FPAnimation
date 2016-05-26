/**
 * Created by sam on 05.11.15.
 */
package ru.flashpress.animation.instant {
    import ru.flashpress.animation.FPAnimation;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPInstant extends FPAnimation
    {
        use namespace nsFPAnimation;

        public function FPInstant()
        {
            super();
            _flags |= FPAnimFlags.INSTANT;
        }


        public override function begin():void
        {
            super.begin();
            //
            _activated = false;
        }

        nsFPAnimation var _activated:Boolean;
        public function get activated():Boolean {return this._activated;}

        public function activate():void
        {
            _activated = true;
        }

        public override function release():void
        {
            super.release();
            _activated = false;
        }
    }
}
