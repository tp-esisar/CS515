package AbstractFilter is

   type T_AbstractFilter is abstract tagged null record;
   type T_AbstractFilter_Access is access all T_AbstractFilter'Class;
   
   function filter(this: access T_AbstractFilter;
                   pressure: in Float) return Float is abstract;
   
end AbstractFilter;
