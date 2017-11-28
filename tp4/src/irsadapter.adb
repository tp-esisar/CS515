package body IrsAdapter is

   procedure Initialise (this: in out T_IrsAdapter; irs: access T_Irs) is
   begin
      this.irs := irs;
   end Initialise;

   function getSpeed (this: access T_IrsAdapter) return T_Vitesse is
      result: T_Vitesse;
      temp: Float;
   begin
      temp := this.irs.irsSpeed;
      result.status := temp <= 800.0;
      result.value := temp;
      return result;
   end getSpeed;

end IrsAdapter;
