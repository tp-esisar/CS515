with Ada.Numerics.Generic_Elementary_Functions;

package body ComputeAltitude is

   overriding function compute(this: access T_ComputeAltitude;
                               measure: in T_Measure) return Float 
   is
      package Math is new Ada.Numerics.Generic_Elementary_Functions(Float);
   begin
      return R*Float(T0)*Math.Log(p0/measure.staticPressure)/(M*g);
   end compute;
   
   package body Constructor is
      function Initialize(trash: in Integer)
         return T_ComputeAltitude_Access
      is
      begin
         return new T_ComputeAltitude;
      end Initialize;
   end Constructor;

end ComputeAltitude;
