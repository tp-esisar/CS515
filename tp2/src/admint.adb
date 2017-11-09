with AdmInt; use AdmInt.SensorMap;

package body AdmInt is

   overriding procedure handleNewPressure
     (this: access T_AdmInt;
      sensor: access T_AbstractPressureSensor)
   is
   begin
      if Find(this.listeCapteur, sensor) = No_Element
      	then Insert(this.listeCapteur, sensor, sensor.getMeasure);
      	else Replace(this.listeCapteur, sensor, sensor.getMeasure);
      end if;
   end handleNewPressure;

   function ID_Hashed
     (id: T_AbstractPressureSensor_Access)
      return Hash_Type
   is
   begin
      raise Program_Error with "Unimplemented function ID_Hashed";
      return ID_Hashed (id => id);
   end ID_Hashed;

end AdmInt;
