with AdmInt;
with Measure;
with ComputeAltitude;

package Traitement is
   
   function Moyenne(liste: in AdmInt.SensorMap.Map) 
                    return Measure.T_Measure
   with post => (Moyenne'Result.status and 
                   Moyenne'Result.staticPressure <= ComputeAltitude.p0 and Moyenne'Result.staticPressure > 0.0 and
                   Moyenne'Result.totalPressure <= ComputeAltitude.p0 and Moyenne'Result.totalPressure > 0.0
                ) or not Moyenne'Result.status;
   
end Traitement;
