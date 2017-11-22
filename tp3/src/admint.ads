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
   function getAltitude (this: access T_AdmInt) return Float;
   function getSpeed (this: access T_AdmInt) return Float;
   
   function ID_Hashed (id: T_AbstractPressureSensor_Access) return Hash_Type;

   package SensorMap is new Ada.Containers.Hashed_Maps
     (Key_Type => T_AbstractPressureSensor_Access,
      Element_Type => T_Measure,
      Hash => ID_Hashed,
      Equivalent_Keys => "=");
   
   package Constructor is
      function Initialize(a: access T_AbstractAltitude'Class;
                          ls: access T_AbstractSpeed'Class;
                          hs: access T_AbstractSpeed'Class;
                          sf: access T_AbstractFilter'Class;
                          tf: access T_AbstractFilter'Class) 
                          return T_AdmInt_Access;
   end;
     
   
private
   type T_AdmInt is new T_PressureObserver with record
      listeCapteur: SensorMap.Map;
      altitudeCalc: access T_AbstractAltitude'Class;
      lowSpeedCalc: access T_AbstractSpeed'Class;
      highSpeedCalc: access T_AbstractSpeed'Class;
      staticFilterCalc: access T_AbstractFilter'Class;
      totalFilterCalc: access T_AbstractFilter'Class;
      savedSpeed: Float;
      savedAltitude: Float;
   end record;

end AdmInt;
