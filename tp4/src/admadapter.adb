package body AdmAdapter is

   ----------------
   -- Initialise --
   ----------------

   procedure Initialise (this: in out T_AdmAdapter; adm: access T_Adm) is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Initialise unimplemented");
      raise Program_Error with "Unimplemented procedure Initialise";
   end Initialise;

   --------------
   -- getSpeed --
   --------------

   function getSpeed (this: access T_AdmAdapter) return Float is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "getSpeed unimplemented");
      raise Program_Error with "Unimplemented function getSpeed";
      return getSpeed (this => this);
   end getSpeed;

end AdmAdapter;
