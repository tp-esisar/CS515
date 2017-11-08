with AdmInt;

package Traitement is
   type T_Traitement is null record;
   
   function Moyenne(this: access T_Traitement; 
                        liste: access AdmInt.SensorsMap.Map) 
                        return Float;
   
end Traitement;
