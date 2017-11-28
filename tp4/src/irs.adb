package body Irs is

   procedure setValue (this: access T_Irs; v: in Float) is
   begin
      this.speed := v;
   end setValue;

   function irsSpeed (this: access T_Irs) return Float is
   begin
      return this.speed;
   end irsSpeed;

end Irs;
