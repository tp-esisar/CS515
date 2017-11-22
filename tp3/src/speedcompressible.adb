with Ada.Numerics.Generic_Elementary_Functions;

package body speedCompressible is

   overriding function computeSpeed
     (this: access T_SpeedCompressible;
      measure: in T_Measure)
      return Float
   is
      package Math is new Ada.Numerics.Generic_Elementary_Functions(Float);
   begin
      return Math.Sqrt((2.0/(gamma-1.0))*
                       (Math."**"((measure.totalPressure/measure.staticPressure),
                          ((gamma-1.0)/gamma))-1.0))*vs;
   end computeSpeed;

end speedCompressible;
