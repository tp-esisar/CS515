with AdmInt; use AdmInt.SensorMap;
--with AdmInt; use AdmInt;
with System; use System;
with ComputeAltitude; use ComputeAltitude;
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
         Put_Line("Altitude : " & Float'image(this.altitudeCalc.compute(resultat)));
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

   package body Constructor is
      function Initialize
        (a: access T_AbstractAltitude'Class)
                          --s: access T_AbstractSpeed;
                          --f: access T_AbstractFilter)
         return T_AdmInt_Access
      is
         Temp_Ptr: T_AdmInt_Access;
      begin
         Temp_Ptr := new T_AdmInt;
         Temp_Ptr.altitudeCalc := a;
--           Temp_Ptr.speedCalc := s;
--           Temp_Ptr.filterCalc := f;
         return Temp_Ptr;
      end Initialize;
   end Constructor;

end AdmInt;
