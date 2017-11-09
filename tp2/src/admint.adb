with AdmInt; use AdmInt.SensorMap;

package body AdmInt is

   overriding procedure handleNewPressure
     (this: access T_AdmInt;
      sensor: access T_AbstractPressureSensor)
   is
   begin
      if this.listeCapteur.Find(sensor) = No_Element
      	then null; --this.listeCapteur.Insert(sensor, sensor.getMeasure);
      	else null; --this.listeCapteur.Replace(sensor, sensor.getMeasure);
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
