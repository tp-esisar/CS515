with Ada.Text_IO; use Ada.Text_IO;
with Adm; use Adm;
with Irs; use Irs;
with Gps; use Gps;
with AdmAdapter; use AdmAdapter;
with IrsAdapter; use IrsAdapter;
with GpsAdapter; use GpsAdapter;
with Acpos; use Acpos;
with test; use test;


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
   irs1Adapter: T_IrsAdapter_Access;
   irs2Adapter: T_IrsAdapter_Access;
   gps1Adapter: T_GpsAdapter_Access;
   gps2Adapter: T_GpsAdapter_Access;
   acpos1: T_Acpos_Access;
   acpos2: T_Acpos_Access;
   error: Boolean := False;
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
   adm2Adapter := new T_AdmAdapter;
   adm3Adapter := new T_AdmAdapter;
   irs1Adapter := new T_IrsAdapter;
   irs2Adapter := new T_IrsAdapter;
   gps1Adapter := new T_GpsAdapter;
   gps2Adapter := new T_GpsAdapter;
   adm1Adapter.Initialise(adm1);
   adm2Adapter.Initialise(adm2);
   adm3Adapter.Initialise(adm3);
   irs1Adapter.Initialise(irs1);
   irs2Adapter.Initialise(irs2);
   gps1Adapter.Initialise(gps1);
   gps2Adapter.Initialise(gps2);
   acpos1 := new T_Acpos;
   acpos2 := new T_Acpos;

   --Init acpos1 et acpos2

   Put_Line("---------- Debut des tests ----------");

   Put_Line("===> Test 1");
   adm1.setState(100.0, True);
   adm2.setState(500.0, True);
   adm3.setState(1000.0, True);
   irs1.setValue(850.0);
   irs2.setValue(500.0);
   gps1.setValue(950.0);
   gps2.setValue(10.0);
   error := error or testunit(acpos1, acpos2, 100.0*0.514, 1000.0*0.514);

   Put_Line("===> Test 2");
   adm1.setState(100.0, False);
   adm2.setState(500.0, True);
   adm3.setState(1000.0, False);
   error := error or testunit(acpos1, acpos2, 500.0*0.514, 500.0*0.514);

   Put_Line("===> Test 3");
   adm2.setState(500.0, False);
   error := error or testunit(acpos1, acpos2, 500.0, 500.0);

   Put_Line("===> Test 4");
   irs2.setValue(900.0);
   error := error or testunit(acpos1, acpos2, 10.0, 950.0);

   Put_Line("===> Test 5");
   acpos1.setCommand(IRS_FIRST);
   adm1.setState(100.0, True);
   adm2.setState(500.0, False);
   adm3.setState(1000.0, False);
   irs1.setValue(850.0);
   irs2.setValue(800.0);
   gps1.setValue(950.0);
   gps2.setValue(10.0);
   error := error or testunit(acpos1, acpos2, 800.0, 100.0*0.514);

   Put_Line("===> Test 6");
   adm1.setState(100.0, False);
   irs2.setValue(850.0);
   error := error or testunit(acpos1, acpos2, 10.0, 950.0);

   Put_Line("===> Test 7");
   acpos1.setCommand(ADM_FIRST);
   adm1.setState(100.0, True);
   adm2.setState(500.0, True);
   adm3.setState(1000.0, True);
   irs1.setValue(850.0);
   irs2.setValue(500.0);
   gps1.setValue(950.0);
   gps2.setValue(10.0);
   error := error or testunit(acpos1, acpos2, 100.0*0.514, 1000.0*0.514);

   Put_Line("---------- Resultat des tests ----------");
   if error
   then Put_Line("TESTS FAIL");
   else Put_Line("TESTS OK");
   end if;

--   Put_Line("===> Test du contrat");
--   irs2.setValue(1000.0);

end Main;
