package body GpsAdapter is

   ----------------
   -- Initialise --
   ----------------

   procedure Initialise (this: in out T_GpsAdapter; gps: access T_Gps) is
   begin
      this.gps := gps;
   end Initialise;

   --------------
   -- getSpeed --
   --------------

   function getSpeed (this: access T_GpsAdapter) return T_Vitesse is
      result: T_Vitesse;
      temp: Float;
   begin
      temp := this.gps.gpsSpeed;
      result.status := True;
      if temp >= 800.0 then
         result.value := 800.0;
      else
         result.value := temp;
      end if;
      return result;
   end getSpeed;

end GpsAdapter;
