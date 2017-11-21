with AdmInt;
with Measure;
with ComputeAltitude;

package Traitement is
   
   function Moyenne(liste: in AdmInt.SensorMap.Map) 
                    return Measure.T_Measure;
   
end Traitement;
