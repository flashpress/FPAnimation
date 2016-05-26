/**
 * Created by sam on 21.11.15.
 */
package ru.flashpress.animation.matrix.m3d
{
    import flash.geom.Matrix3D;

    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMatrixItem3d extends FPInterval
    {
        use namespace nsFPAnimation;

        protected var matrix:Matrix3D;
        protected var isStatic:Boolean;
        protected var isAppend:Boolean;
        public function FPMatrixItem3d()
        {
            super();
            _flags |= FPAnimFlags.MATRIX3D;
        }

        public override function begin():void
        {
            super.begin();
            matrix = currentTarget as Matrix3D;
        }
    }
}
