with Ada.Numerics.Generic_Elementary_Functions;

package body SpeedIncompressible is

   overriding function computeSpeed
     (this: access T_SpeedIncompressible;
      measure: in T_Measure)
      return Float
   is
      package Math is new Ada.Numerics.Generic_Elementary_Functions(Float);
   begin
      return Math.Sqrt(2.0*(measure.totalPressure-measure.staticPressure)/rho);
   end computeSpeed;

end SpeedIncompressible;
