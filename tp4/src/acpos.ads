with Ada.Containers.Vectors; use Ada.Containers;
with GpsAdapter; use GpsAdapter;
with IrsAdapter; use IrsAdapter;
with AdmAdapter; use AdmAdapter;
with SpeedSelector; use SpeedSelector;

package Acpos is

   type T_Command is (IRS_FIRST, ADM_FIRST);
   
   type T_Acpos is tagged private;
   type T_Acpos_Access is access all T_Acpos;
   
   package GPSList is new Vectors (Natural, T_GpsAdapter_Access);
   package IRSList is new Vectors (Natural, T_IrsAdapter_Access);
   package ADMList is new Vectors (Natural, T_AdmAdapter_Access);
   
   procedure Initialise(this: access T_Acpos;
                        adms: in out ADMList.Vector;
                        irss: in out IRSList.Vector;
                        gpss: in out GPSList.Vector);
   
   function getSpeed(this: access T_Acpos) return Float;
   
   procedure setCommand(this: access T_Acpos;
                        cmd: in T_Command);
   
private
   
   type T_Chaines is record
      chaineIRS: access T_SpeedSelector;
      chaineADM: access T_SpeedSelector;
   end record;
   
   type T_Acpos is tagged record
      chaines: T_Chaines;
      currentChaine: access T_SpeedSelector;
   end record;
   
end Acpos;

--with post => getSpeed'Result >= 0.0 and getSpeed'Result <= 800.0;
