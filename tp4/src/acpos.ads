with Ada.Containers.Vectors; use Ada.Containers;
with GpsAdapter; use GpsAdapter;
with IrsAdapter; use IrsAdapter;
with AdmAdapter; use AdmAdapter;
with SpeedSelector; use SpeedSelector;
with AbstractVitesse; use AbstractVitesse;

package Acpos is

   type T_Command is (IRS_FIRST, ADM_FIRST);
   
   type T_Acpos is tagged private;
   type T_Acpos_Access is access all T_Acpos;
   
   package List is new Vectors (Natural, T_AbstractVitesse_Access);
   
   procedure Initialise(this: access T_Acpos;
                        l1: in List.Vector;
                        l2: in List.Vector;
                        l3: in List.Vector);
   
   function getSpeed(this: access T_Acpos) return Float;
   
   procedure setCommand(this: access T_Acpos;
                        cmd: in T_Command);
   
private
   
   type T_Acpos is tagged record
      chaineIRS: access T_SpeedSelector;
      chaineADM: access T_SpeedSelector;
      currentChaine: access T_SpeedSelector;
   end record;
   
end Acpos;

--with post => getSpeed'Result >= 0.0 and getSpeed'Result <= 800.0;
