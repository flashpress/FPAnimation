/**
 * Created by sam on 11.11.15.
 */
package ru.flashpress.animation.modify {
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPModify extends FPInterval
    {
        use namespace nsFPAnimation;

        protected var _animation:FPInterval;
        private var _modifyDuration:Number;
        public function FPModify()
        {
            super();
            _flags |= FPAnimFlags.MODIFY;
        }

        nsFPAnimation function initModify(animation:FPInterval, duration:Number):void
        {
            if (this._animation && this._animation._parent == this) this._animation._parent = null;
            this._animation = animation;
            if (this._animation) this._animation._parent = this;
            //
            this._modifyDuration = duration;
        }

        // используется например в FPReverse и FPWave, чтобы изменить position отдаваемый в _animation
        protected var noApplyToAnim:Boolean;
        nsFPAnimation override function applyPosition(position:Number):void
        {
            super.applyPosition(position);
            if (_animation && !noApplyToAnim) _animation.applyPosition(position);
        }

        nsFPAnimation override function beginForSequence():void
        {
            super.beginForSequence();
            if (_animation) _animation.beginForSequence();
        }

        public function get modifyDuration():Number {return this._modifyDuration;}
        public function set modifyDuration(value:Number):void
        {
            this._modifyDuration = value;
        }

        public override function begin():void
        {
            super.begin();
            //
            if (_animation) _animation.begin();
            this._duration = this._modifyDuration ? this._modifyDuration : (this._animation?this._animation._duration:0);
        }

        public override function release():void
        {
            super.release();
            //
            _modifyDuration = 0;
            if(_animation) {
                _animation.release();
                _animation = null;
            }
        }
    }
}
