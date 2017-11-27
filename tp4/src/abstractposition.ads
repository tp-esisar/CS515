package AbstractPosition is
   
   type T_AbstractPosition is abstract tagged null record;
   
   function getSpeed(this: access T_AbstractPosition) return Float is abstract;   

end AbstractPosition;
