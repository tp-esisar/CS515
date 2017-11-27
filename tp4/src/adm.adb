package body Adm is

   --------------
   -- setState --
   --------------

   procedure setState (this: access T_Adm; v: in Float; b: in Boolean) is
   begin
      this.value := v;
      this.status := b;
   end setState;

   --------------
   -- getValue --
   --------------

   function getValue (this: access T_Adm) return Float is
   begin
      return this.value;
   end getValue;

   ---------------
   -- getStatus --
   ---------------

   function getStatus (this: access T_Adm) return Boolean is
   begin
      return this.status;
   end getStatus;

end Adm;
