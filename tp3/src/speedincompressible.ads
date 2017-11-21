with AbstractSpeed; use AbstractSpeed;
with Measure; use Measure;

package SpeedIncompressible is

   type T_SpeedIncompressible is new T_AbstractSpeed with null record;
   type T_SpeedIncompressible_Access is access all T_SpeedIncompressible'Class;
   
   overriding function computeSpeed(this: access T_SpeedIncompressible;
                                    measure: in T_Measure) return Float; 
   
   rho : constant Float := 1.293;

end SpeedIncompressible;
