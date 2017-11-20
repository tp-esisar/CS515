with AdmInt; use AdmInt.SensorMap;
with System; use System;
with Compute; use Compute;
with Traitement; use Traitement;
with Ada.Text_IO; use Ada.Text_IO;
with System.Address_To_Access_Conversions;
with Ada.Strings;
with System.Address_Image;
with Ada.Strings.Hash;

package body AdmInt is

   overriding procedure handleNewPressure
     (this: access T_AdmInt;
      sensor: access T_AbstractPressureSensor'Class)
   is
      resultat: T_Measure;
   begin
      if this.listeCapteur.Find(sensor) = No_Element
      	then this.listeCapteur.Insert(sensor, sensor.getMeasure);
      	else this.listeCapteur.Replace(sensor, sensor.getMeasure);
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
      -- Put_Line("hash: " & System.Address_Image(id.all'Address));
      return Ada.Strings.Hash(System.Address_Image(id.all'Address));
   end ID_Hashed;

end AdmInt;
