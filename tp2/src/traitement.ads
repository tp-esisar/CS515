with AdmInt;
with Measure; use Measure;

package Traitement is
   type T_Traitement is null record;
   
   function Moyenne(this: access T_Traitement; 
                        liste: access AdmInt.SensorMap.Map) 
                        return T_Measure;
   
end Traitement;
