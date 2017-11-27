package Gps is

   type T_Gps is private;
   
   procedure setValue(this: access T_Gps; v: in Float);
   function gpsSpeed(this: access T_Gps) return Float;
   
private
   
   type T_Gps is record
      value: Float;
   end record;
   

end Gps;
