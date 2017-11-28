with AbstractVitesse; use AbstractVitesse;

package SpeedSelector is

   type T_SpeedSelector is private;
   
   procedure Initialise (this: in out T_SpeedSelector; vitesse: access T_AbstractVitesse); 
   
   procedure setSuivant (this: T_SpeedSelector; next: access T_SpeedSelector);
   
   function getSpeed(this: access T_SpeedSelector) return Float;
   
private
   type T_SpeedSelector is record
      vitesse: access T_AbstractVitesse;
      next: access T_SpeedSelector;
   end record;
   
end SpeedSelector;
