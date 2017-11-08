with Ada.Numerics.Generic_Elementary_Functions;

package body Compute is

   function computeAltitude (pression: in Float) return Float is
     package Math is new Ada.Numerics.Generic_Elementary_Functions(Float);
   begin
      return R*Float(T0)*Math.Log(Float(p0)*pression)/(M*g);
   end computeAltitude;

end Compute;
