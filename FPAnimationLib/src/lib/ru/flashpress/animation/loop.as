/**
 * Created by sam on 24.03.16.
 */
package ru.flashpress.animation {
    public function loop(animation:FPInterval, count:int=0, duration:int=0):FPLoop
    {
        return FPLoop.create(animation, count, duration);
    }
}
