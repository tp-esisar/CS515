with AbstractPressureSensor; use AbstractPressureSensor;
with PressureSensor; use PressureSensor;
with AdmExt; use AdmExt;
With Ada.Text_IO; use Ada.Text_IO;
with AdmInt; use AdmInt;
with PressureObserver; use PressureObserver;
with AbstractAltitude; use AbstractAltitude;
with ComputeAltitude; use ComputeAltitude;
with SpeedIncompressible; use SpeedIncompressible;
with AbstractSpeed; use AbstractSpeed;
with SpeedCompressible; use SpeedCompressible;
with filterBoeing; use filterBoeing;
with AbstractFilter; use AbstractFilter;
with Testfun; use Testfun;
with FilterDassault; use FilterDassault;


procedure Main is
   sensor1: T_AbstractPressureSensor_Access;
   sensor2: T_AbstractPressureSensor_Access;

   altitudeCalc: T_AbstractAltitude_Access;
   lowSpeedCalc: T_AbstractSpeed_Access;
   highSpeedCalc: T_AbstractSpeed_Access;
   staticFilter: T_AbstractFilter_Access;
   totalFilter: T_AbstractFilter_Access;
   adm1: T_AdmInt_Access;
   error: Boolean;
begin
   put_line("----- Init -----");
   sensor1 := new T_PressureSensor;
   sensor2 := new T_AdmExt;
   altitudeCalc := new T_ComputeAltitude;
   lowSpeedCalc := new T_SpeedIncompressible;
   highSpeedCalc := new T_SpeedCompressible;
   staticFilter := new T_FilterDassault;
   totalFilter := new T_FilterDassault;
   error := False;

   adm1 := AdmInt.Constructor.Initialize(altitudeCalc,
                                         lowSpeedCalc,
                                         highSpeedCalc,
                                         staticFilter,
                                         totalFilter
                                        );
   Put_Line("format des donnees: (true:OK/false:KO,totalPressure,staticPressure)");
   Put_line("une altitude de -1.0 correspond a une altitude KO");
   Put_line("-----------------DEBUT Tests du tp2------------------");
   sensor1.recordObserver(T_PressureObserver_Access(adm1));
   put_line("Test 1 avec 1 sensor (true,1000.0,42.42)");
   sensor1.simuleMeasure((true,1000.0,42.42));
   error := error or test(adm1, 1.0, 3.41551E03);

   put_line("Test 2 avec 1 sensor (true,1000.0,80.4)");
   sensor1.simuleMeasure((true,1000.0,80.4));
   error := error or test(adm1, 1.0, 3.13475E03);

   put_line("Test 3 avec 1 sensor (false,1000.0,80.4)");
   sensor1.simuleMeasure((false,1000.0,80.4));
   error := error or test(adm1, 1.0, -1.0);

   Put_Line("Test 4 avec 2 sensors (false,1000.0,80.4) (true,1000.0,79.2)");
   sensor2.recordObserver(T_PressureObserver_Access(adm1));
   sensor2.simuleMeasure((true,1000.0,79.2));
   error := error or test(adm1, 1.0, 3.14135E03);

   Put_Line("Test 5 avec 2 sensors (true,1000.0,80.4) (true,1000.0,79.2)");
   sensor1.simuleMeasure((true,1000.0,80.4));
   error := error or test(adm1, 1.0, 3.13804E03);

   Put_Line("Test 6 avec 2 sensors (true,1000.0,-42.0) (true,1000.0,79.2)");
   sensor1.simuleMeasure((true,1000.0,-42.0));
   error := error or test(adm1, 1.0, 3.14135E03);

   Put_Line("Test 7 avec 2 sensors (true,1000.0,-42.0) (true,1000.0,999999.0)");
   sensor2.simuleMeasure((true,1000.0,999999.0));
   error := error or test(adm1, 1.0, -1.0);

   Put_line("-----------------FIN Tests du tp2------------------");


   Put_line("-----------------DEBUT Tests du tp3------------------");
   -- on réinitialize adm pour reset les filtres
   Put_line("Filtres de Dassault");
   adm1 := AdmInt.Constructor.Initialize(altitudeCalc,
                                         lowSpeedCalc,
                                         highSpeedCalc,
                                         staticFilter,
                                         totalFilter
                                        );
   sensor1.recordObserver(T_PressureObserver_Access(adm1));
   Put_Line("Test 8 avec 1 sensors (true,9000.0,42.42)");
   sensor1.simuleMeasure((true,9000.0,42.42));
   error := error or test(adm1, 1.17709E02, 3.41551E03);
   Put_Line("Test 9 avec 1 sensors (true,9000.0,42.42)");
   sensor1.simuleMeasure((true,9000.0,42.42));
   error := error or test(adm1, 1.42548E03, 3.41551E03);

   if error
   then
      Put_Line("TESTS FAIL");
   else
      Put_Line("TESTS OK");
   end if;

end Main;
