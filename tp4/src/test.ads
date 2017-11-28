with Acpos; use Acpos;

package test is
   
   function test (acpos1: access T_Acpos'Class; 
                  acpos2: access T_Acpos'Class; 
                  expectedSpeed1: in Float;
                  expectedSpeed2: in Float) return Boolean;

end test;
