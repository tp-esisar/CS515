with AdmInt; use AdmInt.SensorMap;
with ComputeAltitude; use ComputeAltitude;
with Measure; use Measure;

package body Traitement is

   function Moyenne(liste: in AdmInt.SensorMap.Map) 
                    return T_Measure 
   is
      item : Cursor := liste.First;
      compteur : Natural := 0;
      staticSomme : Float := 0.0;
      totalSomme : Float := 0.0;
      resultat : T_Measure;
   begin
      loop
         exit when item = No_Element;
         if Element(item).status and 
           Element(item).staticPressure>0.0 and 
           Element(item).staticPressure <= ComputeAltitude.p0 and
           Element(item).totalPressure>0.0 and
           Element(item).totalPressure <= ComputeAltitude.p0
         then 
            compteur := compteur + 1;
            staticSomme := staticSomme + Element(item).staticPressure;
            totalSomme := totalSomme + Element(item).totalPressure;
         end if;
         Next(item);
      end loop;
                  
      resultat.status := compteur/=0;
      if compteur /= 0
      then 
         resultat.staticPressure := staticSomme/Float(compteur);
         resultat.totalPressure := totalSomme/Float(compteur);
      end if;
      
      return resultat;
   end Moyenne;

end Traitement;
