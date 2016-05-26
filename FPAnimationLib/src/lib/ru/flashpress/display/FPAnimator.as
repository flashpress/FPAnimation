/**
 * Created by sam on 09.01.16.
 */
package ru.flashpress.display
{
    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.display.FPAlpha;
    import ru.flashpress.animation.group.FPSequence;
    import ru.flashpress.animation.instant.FPVisible;
    import ru.flashpress.animation.modify.FPEase;

    public class FPAnimator
    {
        private var target:*;
        private var animsByName:Object;
        public function FPAnimator(target:*)
        {
            super();
            this.target = target;
            //
            animsByName = {};
        }

        public function runAnimation(animation:FPInterval, name:String=null, autorelease:Boolean=true):FPInterval
        {
            if (!name) name = 'root';
            if (autorelease) animation.autorelease();
            //
            var anim:Anim = animsByName[name] ? animsByName[name] : new Anim(target, name);
            anim.start(animation);
            return animation;
        }

        public function stopAnimation(name:String=null):void
        {
            if (!name) name = 'root';
            if (animsByName[name]) {
                var anim:Anim = animsByName[name];
                anim.stop();
            }
        }
        public function fadeHide(duration:int=800, visibleBefore:Boolean=false):FPInterval
        {
            var anim:FPInterval = FPEase.create(FPEase.STRONG_OUT, FPAlpha.hide(duration));
            if (visibleBefore) {
                anim = FPSequence.create(anim, FPVisible.hide());
            }
            runAnimation(anim, 'fade');
            return anim;
        }
        public function fadeShow(duration:int=800, unvisibleAfter:Boolean=false):FPInterval
        {
            if (unvisibleAfter) target.visible = true;
            //
            var anim:FPInterval = FPAlpha.show(duration);
            runAnimation(FPEase.create(FPEase.STRONG_OUT, anim), 'fade');
            return anim;
        }

        public function initFadeVisible(visible:Boolean):void
        {
            this._visible = visible;
            if (!visible) {
                target.alpha = 0;
                target.visible = false;
            }
        }

        private var _visible:Boolean;
        public function set fadeVisible(value:Boolean):void
        {
            if (_visible == value) return;
            _visible = value;
            if (value) {
                this.fadeShow(800, true);
            } else {
                this.fadeHide(800, true);
            }
        }
    }
}

import ru.flashpress.animation.FPInterval;

class Anim
{
    public var target:*, name:String;
    public function Anim(target:*, name:String)
    {
        this.target = target;
        this.name = name;
    }

    private var _animation:FPInterval;
    public function start(anim:FPInterval):void
    {
        stop(anim);
        _animation = anim;
        _animation.registerCompleteCallback(completeCallback);
        if (!_animation.target) _animation.target = target;
        _animation.play();
    }

    public function stop(anim:FPInterval=null):void
    {
        if (this._animation && (!anim || this._animation == anim)) {
            if (this._animation.played) this._animation.stop();
            if (this._animation.autoreleased && !this._animation.released) this._animation.release();
            this._animation = null;
        }
    }

    private function completeCallback():void
    {
        this._animation = null;
    }
}