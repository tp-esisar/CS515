with PressureObserver; use PressureObserver;
with Ada.Containers.Hashed_Maps;
with Mesure; use Mesure;

package AdmInt is
   type T_AdmInt is new T_PressureObserver with private;
   
   overriding procedure handleNewPressure(this: access T_AdmInt; 
                               sensor: access T_AbstractPressureSensor;
                               status: Boolean;
                               pressure: Float );
   
   function ID_Hashed (id: AbstractPressureSensorAccess) return Hash_Type;

   package Phrases is new Ada.Containers.Hashed_Maps
     (Key_Type => AbstractPressureSensorAccess,
      Element_Type => T_Mesure,
      Hash => ID_Hashed,
      Equivalent_Keys => "=");

   end AdmInt;
