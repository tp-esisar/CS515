package Adm is
   
   type T_Adm is private;
   
   procedure setState(this: access T_Adm; v: in Float; b: in Boolean);
   function getValue(this: access T_Adm) return Float;
   function getStatus(this: access T_Adm) return Boolean;
      
private
   
   type T_Adm is record
      value: Float;
      status: Boolean;
   end record;
end Adm;
