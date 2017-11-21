package body speedCompressible is

   overriding function computeSpeed
     (this: access T_SpeedCompressible;
      measure: in T_Measure)
      return Float
   is
   begin
      return (((2/(gamma-1))*(((measure.totalPressure/measure.staticPressure)**((gamma-1)/gamma))-1))**0.5)*vs;
   end computeSpeed;

end speedCompressible;
