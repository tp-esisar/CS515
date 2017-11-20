with AbstractPressureSensor; use AbstractPressureSensor;
with PressureObserver; use PressureObserver;
with Measure; use Measure;

package PressureSensor is

   type T_PressureSensor is new T_AbstractPressureSensor with private;
   type T_PressureSensor_Access is access all T_PressureSensor'Class;
      
   overriding procedure simuleMeasure(this: access T_PressureSensor; 
                                      measure: in T_Measure);
   overriding function getMeasure(this: access T_PressureSensor) return T_Measure;
   
private
   type T_PressureSensor is new T_AbstractPressureSensor with record
      measure: T_Measure;
   end record;
   
end PressureSensor;
