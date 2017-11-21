with Measure; use Measure;

package AbstractSpeed is
   
   type T_AbstractSpeed is abstract tagged null record;
   type T_AbstractSpeed_Access is access all T_AbstractSpeed'Class;
   
   function computeSpeed(this: access T_AbstractSpeed;
                         measure: in T_Measure) return Float is abstract;

end AbstractSpeed;
