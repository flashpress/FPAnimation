/**
 * Created by sam on 21.11.15.
 */
package ru.flashpress.animation.matrix.m2d {
    import flash.geom.Matrix;

    import ru.flashpress.animation.FPInterval;
    import ru.flashpress.animation.core.constants.FPAnimFlags;
    import ru.flashpress.animation.core.nsFPAnimation;

    public class FPMatrixItem2d extends FPInterval
    {
        use namespace nsFPAnimation;

        protected var matrix:Matrix;
        protected var isStatic:Boolean;
        public function FPMatrixItem2d()
        {
            super();
            _flags |= FPAnimFlags.MATRIX2D;
        }

        public override function begin():void
        {
            super.begin();
            matrix = currentTarget as Matrix;
        }
    }
}
