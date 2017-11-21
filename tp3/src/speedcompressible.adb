
package body speedCompressible is

   overriding function computeSpeed
     (this: access T_SpeedCompressible;
      measure: in T_Measure)
      return Float
   is
   begin
      return 1.0; --(((2.0/(gamma-1.0))*(((measure.totalPressure/measure.staticPressure)**((gamma-1.0)/gamma))-1.0))**0.5)*vs;
   end computeSpeed;

end speedCompressible;
