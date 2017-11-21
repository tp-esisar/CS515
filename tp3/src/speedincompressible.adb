package body SpeedIncompressible is

   overriding function computeSpeed
     (this: access T_SpeedIncompressible;
      measure: in T_Measure)
      return Float
   is
   begin
      return 1.0; --(2.0*(measure.totalPressure-measure.staticPressure)/rho)**0.5;
   end computeSpeed;

end SpeedIncompressible;
