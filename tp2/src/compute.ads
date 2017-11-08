package Compute is
   
   type T_Compute is null record;
    
   function computeAltitude(pression: in Float) return Float;
   
   g : constant Float := 9.807;
   p0 : constant Natural := 101315;
   R : constant Float := 8.314;
   T0 : constant Natural := 15;
   M : constant Float := 0.02896;
   
end Compute;
