with AbstractPressureSensor; use AbstractPressureSensor;
with PressureSensor; use PressureSensor;
with AdmExt; use AdmExt;
With Ada.Text_IO; use Ada.Text_IO;
with AdmInt; use AdmInt;
with PressureObserver; use PressureObserver;
with AbstractAltitude; use AbstractAltitude;
with ComputeAltitude; use ComputeAltitude;

procedure Main is
   sensor1: T_AbstractPressureSensor_Access;
   sensor2: T_AbstractPressureSensor_Access;

   altitude: T_AbstractAltitude_Access;
   adm1: T_AdmInt_Access;
begin
   put_line("----- Init -----");
   sensor1 := T_AbstractPressureSensor_Access(PressureSensor.Constructor.Initialize(true, 42.42));
   sensor2 := T_AbstractPressureSensor_Access(AdmExt.Constructor.Initialize(true, 79.2));
   altitude := T_AbstractAltitude_Access(ComputeAltitude.Constructor.Initialize(42));
   adm1 := AdmInt.Constructor.Initialize(altitude);

--     put_line("Test 1 avec 1 sensor (OK, 42.42)");
--     sensor1.recordObserver(T_PressureObserver_Access(adm1));
--
--     put_line("Test 2 avec 1 sensor (OK, 80.4)");
--     sensor1.simuleMeasure(80.4, true);
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
