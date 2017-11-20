with AdmInt;
with Measure;
with Compute;

package Traitement is
   
   function Moyenne(liste: in AdmInt.SensorMap.Map) 
                    return Measure.T_Measure
     with post => (Moyenne'Result.status and Moyenne'Result.pressure <= Compute.p0 and Moyenne'Result.pressure > 0.0) or 
     			(not Moyenne'Result.status and Moyenne'Result.pressure = 0.0);
   
end Traitement;
