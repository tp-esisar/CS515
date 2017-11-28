with AbstractVitesse; use AbstractVitesse;

package SpeedSelector is

   type T_SpeedSelector is tagged private;
   type T_SpeedSelector_Access is access all T_SpeedSelector'Class;
   
   procedure Initialise (this: in out T_SpeedSelector; vitesse: access T_AbstractVitesse'Class); 
   
   procedure setSuivant (this: in out T_SpeedSelector; next: access T_SpeedSelector);
   
   function getSpeed(this: access T_SpeedSelector) return Float
     with post => getSpeed'Result >= 0.0 and getSpeed'Result <= 800.0;
   
private
   type T_SpeedSelector is tagged record
      vitesse: access T_AbstractVitesse'Class;
      next: access T_SpeedSelector;
   end record;
   
end SpeedSelector;
