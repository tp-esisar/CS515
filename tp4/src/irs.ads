package Irs is

   type T_Irs is private;
   
   procedure setValue(this: access T_Irs; v: in Float);
   function irsSpeed(this: access T_Irs) return Float;
   
private
   
   type T_Irs is record
      speed: Float;
   end record;

end Irs;
