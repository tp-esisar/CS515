package body AbstractPressureSensor is

   procedure recordObserver
     (this: access T_AbstractPressureSensor;
      observer: access T_PressureObserver'Class)
   is
   begin
      this.observers.Append(observer);
      observer.handleNewPressure(this);
   end recordObserver;

end AbstractPressureSensor;
