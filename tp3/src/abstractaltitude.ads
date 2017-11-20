package AbstractAltitude is

   type T_AbstractAltitude is abstract tagged null record;
   
   function computeAltitude(this: access T_AbstractAltitude;
                            measure: in T_Measure) return Float is abstract;
   

end AbstractAltitude;
