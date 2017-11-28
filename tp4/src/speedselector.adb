package body SpeedSelector is

   ----------------
   -- Initialise --
   ----------------

   procedure Initialise
     (this: in out T_SpeedSelector;
      vitesse: access T_AbstractVitesse)
   is
   begin
      this.vitesse := T_AbstractVitesse;
   end Initialise;

   ----------------
   -- setSuivant --
   ----------------

   procedure setSuivant
     (this: T_SpeedSelector;
      next: access T_SpeedSelector)
   is
   begin
      this.next := T_SpeedSelector;
   end setSuivant;

   --------------
   -- getSpeed --
   --------------

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
