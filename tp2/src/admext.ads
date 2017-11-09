with AbstractPressureSensor; use AbstractPressureSensor;
with PressureObserver; use PressureObserver;
with Measure; use Measure;

package AdmExt is

   type T_AdmExt is new T_AbstractPressureSensor with private;
   type T_AdmExt_Access is access all T_AdmExt'Class;
   
   package Constructor is
      function Initialize(status: in Boolean; 
                          pressure: in Float) return T_AdmExt_Access;
   end;
     
      
   overriding procedure simuleMeasure(this: access T_AdmExt; 
                                      pressure: in Float; 
                                      status: in Boolean);
   
   overriding function getMeasure(this: access T_AdmExt) return T_Measure;
   
private

   type T_AdmExt is new T_AbstractPressureSensor with record
      measure: T_Measure;
   end record;
   
   
end AdmExt;
