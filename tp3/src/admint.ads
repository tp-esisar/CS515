with PressureObserver; use PressureObserver;
with Ada.Containers.Hashed_Maps; use Ada.Containers;
with Measure; use Measure;
with AbstractPressureSensor; use AbstractPressureSensor;
with AbstractAltitude; use AbstractAltitude;
with AbstractFilter; use AbstractFilter;
with AbstractSpeed; use AbstractSpeed;

package AdmInt is
   type T_AdmInt is new T_PressureObserver with private;
   type T_AdmInt_Access is access all T_AdmInt'Class;
   
   overriding procedure handleNewPressure(this: access T_AdmInt; 
                                          sensor: access T_AbstractPressureSensor'Class
                                         );
   
   function ID_Hashed (id: T_AbstractPressureSensor_Access) return Hash_Type;

   package SensorMap is new Ada.Containers.Hashed_Maps
     (Key_Type => T_AbstractPressureSensor_Access,
      Element_Type => T_Measure,
      Hash => ID_Hashed,
      Equivalent_Keys => "=");
   
   package Constructor is
      function Initialize(a: access T_AbstractAltitude'Class)
                          --s: access T_AbstractSpeed;
                         -- f: access T_AbstractFilter) 
                          return T_AdmInt_Access;
   end;
     
   
private
   type T_AdmInt is new T_PressureObserver with record
      listeCapteur: SensorMap.Map;
      altitudeCalc: access T_AbstractAltitude'Class;
--        speedCalc: T_AbstractSpeed_Access;
--        staticFilterCalc: T_AbstractFilter_Access;
--        totalFilterCalc: T_AbstractFilter_Access;
   end record;

end AdmInt;
