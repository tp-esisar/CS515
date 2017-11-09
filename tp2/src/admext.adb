with AbstractPressureSensor; use AbstractPressureSensor.ObserverContainer;
with PressureObserver; use PressureObserver;
package body AdmExt is

   package body Constructor is
      function Initialize (status: in Boolean; pressure: in Float)
         return T_AdmExt_Access
      is
         Temp_Ptr : T_AdmExt_Access;
      begin
         Temp_Ptr := new T_AdmExt;
         Temp_Ptr.measure.status := status;
         Temp_Ptr.measure.pressure := pressure;
         return Temp_Ptr;
      end Initialize;
   end Constructor;

   overriding procedure simuleMeasure (this: access T_AdmExt;
                                       pressure: in Float;
                                       status: in Boolean)
   is
      C: Cursor := this.observers.First;
   begin
      this.measure.pressure := pressure;
      this.measure.status := status;
      loop
         exit when C = No_Element;
         Element(C).handleNewPressure(T_AbstractPressureSensor_Access(this));
         ObserverContainer.Next(C);
      end loop;
   end simuleMeasure;

   overriding function getMeasure(this: access T_AdmExt) return T_Measure
   is
   begin
      return this.measure;
   end getMeasure;

end AdmExt;
