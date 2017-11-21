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

procedure Main is
   sensor1: T_AbstractPressureSensor_Access;
   sensor2: T_AbstractPressureSensor_Access;

   altitudeCalc: T_AbstractAltitude_Access;
   lowSpeedCalc: T_AbstractSpeed_Access;
   highSpeedCalc: T_AbstractSpeed_Access;
   staticFilter: T_AbstractFilter_Access;
   totalFilter: T_AbstractFilter_Access;
   adm1: T_AdmInt_Access;
begin
   put_line("----- Init -----");
   sensor1 := new T_PressureSensor;
   sensor2 := new T_AdmExt;
   altitudeCalc := new T_ComputeAltitude;
   lowSpeedCalc := new T_SpeedIncompressible;
   highSpeedCalc := new T_SpeedCompressible;
   staticFilter := new T_FilterBoeing;
   totalFilter := new T_FilterBoeing;

   adm1 := AdmInt.Constructor.Initialize(altitudeCalc,
                                         lowSpeedCalc,
                                         highSpeedCalc,
                                         staticFilter,
                                         totalFilter
                                        );

   put_line("Test 1 avec 1 sensor (OK, 42.42)");
   sensor1.recordObserver(T_PressureObserver_Access(adm1));
   sensor1.simuleMeasure((true,1.0,42.42));
   put_line("Test 2 avec 1 sensor (OK, 80.4)");
   sensor1.simuleMeasure((true,1.0,80.4));
--
--     put_line("Test 3 avec 1 sensor (KO, 80.4)");
--     sensor1.simuleMeasure(80.4, false);
--
--     Put_Line("Test 4 avec 2 sensors (KO, 80.4) (OK, 79.2)");
--     sensor2.recordObserver(T_PressureObserver_Access(adm1));
--
--     Put_Line("Test 5 avec 2 sensors (OK, 80.4) (OK, 79.2)");
--     sensor1.simuleMeasure(80.4, true);
--
--     Put_Line("Test 6 avec 2 sensors (OK, -42) (OK, 79.2)");
--     sensor1.simuleMeasure(-42.0, true);
--
--     Put_Line("Test 7 avec 2 sensors (OK, -42) (OK, 9999999)");
--     sensor2.simuleMeasure(9999999.0, true);

end Main;
