with AbstractPressureSensor; use AbstractPressureSensor;
with PressureObserver; use PressureObserver;
with Measure; use Measure;

package PressureSensor is

   type T_PressureSensor is new T_AbstractPressureSensor with private;
   type T_PressureSensor_Access is access all T_PressureSensor'Class;
   
   package Constructor is
      function Initialize(status: in Boolean; 
                          pressure: in Float) return T_PressureSensor_Access;
   end;
     
      
   overriding procedure simuleMeasure(this: access T_PressureSensor; 
                                      pressure: in Float; 
                                      status: in Boolean);
   
   overriding function getMeasure(this: access T_PressureSensor) return T_Measure;
   
private

   type T_PressureSensor is new T_AbstractPressureSensor with record
      measure: T_Measure;
   end record;
   
   
end PressureSensor;
