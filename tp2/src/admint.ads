with PressureObserver; use PressureObserver;
with Ada.Containers.Hashed_Maps; use Ada.Containers;
with Measure; use Measure;
with AbstractPressureSensor; use AbstractPressureSensor;

package AdmInt is
   type T_AdmInt is new T_PressureObserver with private;
   
   overriding procedure handleNewPressure(this: access T_AdmInt; 
                                          sensor: access T_AbstractPressureSensor
                                         );
   
   function ID_Hashed (id: T_AbstractPressureSensor_Access) return Hash_Type;

   package SensorMap is new Ada.Containers.Hashed_Maps
     (Key_Type => T_AbstractPressureSensor_Access,
      Element_Type => T_Measure,
      Hash => ID_Hashed,
      Equivalent_Keys => "=");
   
private
   type T_AdmInt is new T_PressureObserver with record
      listeCapteur: SensorMap.Map;
   end record;

end AdmInt;
