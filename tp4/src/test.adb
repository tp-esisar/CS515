with Ada.Text_IO; use Ada.Text_IO;
package body test is

   ----------
   -- test --
   ----------

   function testunit
     (acpos1: access T_Acpos'Class;
      acpos2: access T_Acpos'Class;
      expectedSpeed1: in Float;
      expectedSpeed2: in Float)
      return Boolean
   is
      vitesse1: Float;
      vitesse2: Float;
   begin
      vitesse1 := acpos1.getSpeed;
      vitesse2 := acpos2.getSpeed;
      Put_Line("acpos1 : " & Float'Image(vitesse1) & "/" & Float'Image(expectedSpeed1));
      Put_Line("acpos2 : " & Float'Image(vitesse2) & "/" & Float'Image(expectedSpeed2));
      return (Float'Image(expectedSpeed1) /= Float'Image(vitesse1)) or
        (Float'Image(expectedSpeed2) /= Float'Image(vitesse2));

   end testunit;

end test;
