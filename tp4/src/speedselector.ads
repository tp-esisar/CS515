with AbstractVitesse; use AbstractVitesse;

package SpeedSelector is

   type T_SpeedSelector is tagged private;
   
   procedure Initialise (this: in out T_SpeedSelector; vitesse: access T_AbstractVitesse'Class); 
   
   procedure setSuivant (this: in out T_SpeedSelector; next: access T_SpeedSelector);
   
   function getSpeed(this: access T_SpeedSelector) return Float;
   
private
   type T_SpeedSelector is tagged record
      vitesse: access T_AbstractVitesse'Class;
      next: access T_SpeedSelector;
   end record;
   
end SpeedSelector;
