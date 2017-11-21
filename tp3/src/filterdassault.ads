with AbstractFilter; use AbstractFilter;

package FilterDassault is
   
   type T_FilterDassault is new T_AbstractFilter with null record;
   type T_FilterDassault_Access is access all T_FilterDassault'Class;
   
   function filter(this: access T_FilterDassault;
                   pressure: in Float) return Float;

end FilterDassault;
