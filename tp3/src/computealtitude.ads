with AbstractAltitude; use AbstractAltitude;
package ComputeAltitude is
   
   type T_ComputeAltitude is new T_AbstractAltitude with null record;
   
   overriding function computeAltitude(this: access T_ComputeAltitude;
                                       pression: in Float) return Float
   
   
   g : constant Float := 9.807;
   p0 : constant Float := 101315.0;
   R : constant Float := 8.314;
   T0 : constant Natural := 15;
   M : constant Float := 0.02896;
   
end ComputeAltitude;
