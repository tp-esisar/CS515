with Vitesse; use Vitesse;
package body SpeedSelector is

   procedure Initialise
     (this: in out T_SpeedSelector;
      vitesse: access T_AbstractVitesse'Class)
   is
   begin
      this.vitesse := vitesse;
   end Initialise;

   procedure setSuivant
     (this: in out T_SpeedSelector;
      next: access T_SpeedSelector)
   is
   begin
      this.next := next;
   end setSuivant;

   function getSpeed (this: access T_SpeedSelector) return Float is
      result: T_Vitesse;
   begin
      result := this.vitesse.getSpeed;
      if(result.status)
      then return result.value;
      else return this.next.getSpeed;
      end if;

   end getSpeed;

end SpeedSelector;
