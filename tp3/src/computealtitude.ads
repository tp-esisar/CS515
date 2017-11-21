with AbstractAltitude; use AbstractAltitude;
with Measure; use Measure;
package ComputeAltitude is
   
   type T_ComputeAltitude is new T_AbstractAltitude with null record;
   type T_ComputeAltitude_Access is access all T_ComputeAltitude'Class;
   
   overriding function compute(this: access T_ComputeAltitude;
                               measure: in T_Measure) return Float;
   
   package Constructor is
      function Initialize(trash: in Integer) return T_ComputeAltitude_Access;
   end;
   
   g : constant Float := 9.807;
   p0 : constant Float := 101315.0;
   R : constant Float := 8.314;
   T0 : constant Natural := 15;
   M : constant Float := 0.02896;
   
end ComputeAltitude;
--  
--  with Ada.Numerics.Generic_Elementary_Functions;
--  
--  package body Compute is
--  
--     function computeAltitude (pression: in Float) return Float is
--        package Math is new Ada.Numerics.Generic_Elementary_Functions(Float);
--     begin
--        return R*Float(T0)*Math.Log(p0/pression)/(M*g);
--     end computeAltitude;
--  
--  end Compute;

