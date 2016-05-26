/**
 * Created by sam on 20.02.16.
 */
package ru.flashpress.animation.sound
{
    public function panFromTo(from:Number, to:Number, duration:Number=0):FPSound
    {
        return FPSound.createPanFromTo(from, to, duration);
    }
}
