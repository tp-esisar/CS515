package Irs is

   type T_Irs is tagged private;
   type T_Irs_Access is access all T_Irs;
   
   procedure setValue(this: access T_Irs; v: in Float);
   function irsSpeed(this: access T_Irs) return Float
     with Post => irsSpeed'Result >= 0.0 and irsSpeed'Result <= 900.0;
   
private
   
   type T_Irs is tagged record
      speed: Float;
   end record;

end Irs;
