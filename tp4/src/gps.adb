package body Gps is

   --------------
   -- setValue --
   --------------

   procedure setValue (this: access T_Gps; v: in Float) is
   begin
      this.value := v;
   end setValue;

   --------------
   -- gpsSpeed --
   --------------

   function gpsSpeed (this: access T_Gps) return Float is
   begin
      return this.value;
   end gpsSpeed;

end Gps;
