with AbstractSpeed; use AbstractSpeed;
with Measure; use Measure;

package SpeedCompressible is
   
   type T_SpeedCompressible is new T_AbstractSpeed with null record;
   type T_SpeedCompressible_Access is access all T_SpeedCompressible'Class;
   
   overriding function computeSpeed(this: access T_SpeedCompressible;
                                    measure: in T_Measure) return Float;
   
   rho : constant Float := 1.293;
   gamma : constant Float := 7.0/5.0;
   vs : constant Float := 335.0;

end SpeedCompressible;
