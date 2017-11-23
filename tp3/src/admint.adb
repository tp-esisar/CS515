with AdmInt; use AdmInt.SensorMap;
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
      meanPressure: T_Measure;
      filteredPressure: T_Measure;
   begin
      if this.listeCapteur.Find(sensor) = No_Element
      	then this.listeCapteur.Insert(sensor, sensor.getMeasure);
      	else this.listeCapteur.Replace(sensor, sensor.getMeasure);
      end if;
      meanPressure := Moyenne(this.listeCapteur);
      if meanPressure.status
      then
         this.savedAltitude := this.altitudeCalc.compute(meanPressure);
         filteredPressure.status := meanPressure.status;
         filteredPressure.totalPressure := this.totalFilterCalc.filter(meanPressure.totalPressure);
         filteredPressure.staticPressure := this.staticFilterCalc.filter(meanPressure.staticPressure);
         if this.savedSpeed <= 100.0
         then
            this.savedSpeed := this.lowSpeedCalc.computeSpeed(filteredPressure);
         else
            this.savedSpeed := this.highSpeedCalc.computeSpeed(filteredPressure);
         end if;
      else
         this.savedAltitude := -1.0;
      end if;

   end handleNewPressure;

   function ID_Hashed
     (id: T_AbstractPressureSensor_Access)
      return Hash_Type
   is
   begin
      return Ada.Strings.Hash(System.Address_Image(id.all'Address));
   end ID_Hashed;

   function getAltitude
     (this: access T_AdmInt)
      return Float
   is
   begin
      return this.savedAltitude;
   end;

   function getSpeed
     (this: access T_AdmInt)
      return Float
   is
   begin
      return this.savedSpeed;
   end;

   package body Constructor is
      function Initialize(a: access T_AbstractAltitude'Class;
                          ls: access T_AbstractSpeed'Class;
                          hs: access T_AbstractSpeed'Class;
                          sf: access T_AbstractFilter'Class;
                          tf: access T_AbstractFilter'Class)
                          return T_AdmInt_Access
      is
         Temp_Ptr: T_AdmInt_Access;
      begin
         Temp_Ptr := new T_AdmInt;
         Temp_Ptr.altitudeCalc := a;
         Temp_Ptr.lowSpeedCalc := ls;
         Temp_Ptr.highSpeedCalc := hs;
         Temp_Ptr.staticFilterCalc := sf;
         Temp_Ptr.totalFilterCalc := tf;
         Temp_Ptr.savedSpeed := 0.0;
         Temp_Ptr.savedAltitude := 0.0;
         return Temp_Ptr;
      end Initialize;
   end Constructor;

end AdmInt;
