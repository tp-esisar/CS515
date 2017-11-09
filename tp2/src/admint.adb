with AdmInt; use AdmInt.SensorMap;
with Compute; use Compute;
with Traitement; use Traitement;
with Ada.Text_IO; use Ada.Text_IO;

package body AdmInt is

   overriding procedure handleNewPressure
     (this: access T_AdmInt;
      sensor: access T_AbstractPressureSensor)
   is
      resultat: T_Measure;
   begin
      if this.listeCapteur.Find(sensor) = No_Element
      	then null; --this.listeCapteur.Insert(sensor, sensor.getMeasure);
      	else null; --this.listeCapteur.Replace(sensor, sensor.getMeasure);
      end if;

      resultat := Moyenne(this.listeCapteur);
      if resultat.status
      then
         Put_Line("Altitude : " & Float'image(computeAltitude(resultat.pressure)));
      else
         Put_Line("Altitude : KO");
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
