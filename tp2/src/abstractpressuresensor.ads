with PressureObserver; use PressureObserver;
with Ada.Containers.Vectors; use Ada.Containers;
with Measure; use Measure;

package AbstractPressureSensor is
   
   
   package ObserverContainer is new Vectors (Natural, T_PressureObserver_Access);
   
   type T_AbstractPressureSensor is abstract tagged record
      observers: ObserverContainer.Vector;
   end record;
   
   
   
   type T_AbstractPressureSensor_Access is access all T_AbstractPressureSensor'Class;
   
   procedure simuleMeasure(this: access T_AbstractPressureSensor; 
                           pressure: in Float;
                           status: in Boolean) is abstract;
   
   procedure recordObserver(this: access T_AbstractPressureSensor;
                            observer: access T_PressureObserver'Class);
   
   function getMeasure(this: access T_AbstractPressureSensor) return T_Measure is abstract;
   

      
end AbstractPressureSensor;
