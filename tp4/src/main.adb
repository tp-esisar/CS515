with Ada.Text_IO; use Ada.Text_IO;
with Adm; use Adm;
with Irs; use Irs;
with Gps; use Gps;
with AdmAdapter; use AdmAdapter;
with IrsAdapter; use IrsAdapter;
with GpsAdapter; use GpsAdapter;


procedure Main is
   adm1: T_Adm_Access;
   adm2: T_Adm_Access;
   adm3: T_Adm_Access;
   irs1: T_Irs_Access;
   irs2: T_Irs_Access;
   gps1: T_Gps_Access;
   gps2: T_Gps_Access;
   adm1Adapter: T_AdmAdapter_Access;
   adm2Adapter: T_AdmAdapter_Access;
   adm3Adapter: T_AdmAdapter_Access;
   irs1Adapter: T_IrsAdapter;
   irs2Adapter: T_IrsAdapter;
   gps1Adapter: T_GpsAdapter_Access;
   gps2Adapter: T_GpsAdapter_Access;
begin
   Put_Line("---------- Initialisation ----------");
   adm1 := new T_Adm;
   adm2 := new T_Adm;
   adm3 := new T_Adm;
   irs1 := new T_Irs;
   irs2 := new T_Irs;
   gps1 := new T_Gps;
   gps2 := new T_Gps;
   adm1Adapter := new T_AdmAdapter;
   adm1Adapter.Initialise(adm1);
   adm2Adapter := new T_AdmAdapter;
   adm2Adapter.Initialise(adm2);
   adm3Adapter := new T_AdmAdapter;
   adm3Adapter.Initialise(adm3);
   irs1Adapter := new T_IrsAdapter;
   irs1Adapter.Initialise(irs1);
   irs2Adapter := new T_IrsAdapter;
   irs2Adapter.Initialise(irs2);
   gps1Adapter := new T_GpsAdapter;
   gps1Adapter.Initialise(gps1);
   gps2Adapter := new T_GpsAdapter;
   gps2Adapter.Initialise(gps2);
   --  Insert code here.
end Main;
