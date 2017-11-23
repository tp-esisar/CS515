with AdmInt; use AdmInt;

package Testfun is

   function test
     (adm: access T_AdmInt'Class;
      expectedSpeed: in Float;
      expectedAltitude: in Float)
   return Boolean;
 

end Testfun;
