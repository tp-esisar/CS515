with Ada.Text_IO; use Ada.Text_IO;
package body Testfun is

   ----------
   -- test --
   ----------

   function test
     (adm: access T_AdmInt'Class;
      expectedSpeed: in Float;
      expectedAltitude: in Float)
      return Boolean
   is
      speed: Float;
      altitude: Float;
   begin
      speed := adm.getSpeed;
      altitude := adm.getAltitude;
      Put_Line("Expected: speed: " & Float'Image(expectedSpeed) & " altitude: " & Float'Image(expectedAltitude));
      Put_Line("Received: speed: " & Float'Image(speed) & " altitude: " & Float'Image(altitude));
      return (Float'Image(expectedAltitude) /= Float'Image(altitude)) or
        (Float'Image(expectedSpeed) /= Float'Image(speed));
   end test;

end Testfun;
