package AbstractFilter is

   type T_AbstractFilter is abstract tagged null record;
   
   function filter(this: access T_AbstractFilter;
                   pressure: in Float) return Float is abstract;
   

end AbstractFilter;
