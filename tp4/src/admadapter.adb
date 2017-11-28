package body AdmAdapter is

   ----------------
   -- Initialise --
   ----------------

   procedure Initialise (this: in out T_AdmAdapter; adm: access T_Adm) is
   begin
      this.adm := adm;
   end Initialise;

   --------------
   -- getSpeed --
   --------------

   function getSpeed (this: access T_AdmAdapter) return T_Vitesse is
      result: T_Vitesse;
   begin
      result.status := this.adm.getStatus;
      result.value := this.adm.getValue * ktsToms;
      return result;
   end getSpeed;

end AdmAdapter;
