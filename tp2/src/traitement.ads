with AdmInt;
with Measure;

package Traitement is
   type T_Traitement is null record;
   
   function Moyenne(liste: in AdmInt.SensorMap.Map) 
                    return Measure.T_Measure;
   
end Traitement;
