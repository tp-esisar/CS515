with Measure; use Measure;
package AbstractAltitude is

   type T_AbstractAltitude is abstract tagged null record;
   type T_AbstractAltitude_Access is access all T_AbstractAltitude'Class;
   
   function compute(this: access T_AbstractAltitude;
                            measure: in T_Measure) return Float is abstract;
   

end AbstractAltitude;
