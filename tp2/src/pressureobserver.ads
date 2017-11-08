limited with AbstractPressureSensor;
package PressureObserver is
   type T_PressureObserver is abstract tagged null record;
   type T_PressureObserver_Access is access all T_PressureObserver'Class;

   procedure handleNewPressure(this: access T_PressureObserver; 
                               sensor: access AbstractPressureSensor.T_AbstractPressureSensor
                              ) is abstract;

end PressureObserver;
