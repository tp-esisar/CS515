package Compute is
   
   type T_Compute is null record;
    
   function computeAltitude(pression: in Float) return Float
     with pre => pression > 0.0 and pression <= p0,
     post => computeAltitude'Result >= 0.0;
   
   g : constant Float := 9.807;
   p0 : constant Float := 101315.0;
   R : constant Float := 8.314;
   T0 : constant Natural := 15;
   M : constant Float := 0.02896;
   
end Compute;
