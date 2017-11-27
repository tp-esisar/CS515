package AbstractVitesse is
   
   type T_AbstractVitesse is abstract tagged null record;
   
   function getSpeed(this: access T_AbstractVitesse) return Float is abstract;   

end AbstractVitesse;
