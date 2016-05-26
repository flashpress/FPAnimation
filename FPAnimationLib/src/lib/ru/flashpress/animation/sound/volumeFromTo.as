/**
 * Created by sam on 20.02.16.
 */
package ru.flashpress.animation.sound
{
    public function volumeFromTo(from:Number, to:Number, duration:Number=0):FPSound
    {
        return FPSound.createVolumeFromTo(from, to, duration);
    }
}
