package body Irs is

   --------------
   -- setValue --
   --------------

   procedure setValue (this: access T_Irs; v: in Float) is
   begin
      this.speed := v;
   end setValue;

   --------------
   -- irsSpeed --
   --------------

   function irsSpeed (this: access T_Irs) return Float is
   begin
      return this.speed;
   end irsSpeed;

end Irs;
