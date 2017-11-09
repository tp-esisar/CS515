with AdmInt; use AdmInt.SensorMap;
with Compute; use Compute;
with Measure; use Measure;

package body Traitement is

   function Moyenne(liste: in AdmInt.SensorMap.Map) 
                    return T_Measure 
   is
      item : Cursor := liste.First;
      compteur : Natural := 0;
      somme : Float := 0.0;
      resultat : T_Measure;
   begin
      loop
         exit when item = No_Element;
         if Element(item).status and 
           Element(item).pressure>0.0 and 
           Element(item).pressure <= Compute.p0
         then 
            compteur := compteur + 1;
            somme := somme + Element(item).pressure;
         end if;
         Next(item);
      end loop;
                  
      resultat.status := compteur/=0;
      if compteur /= 0
      then resultat.pressure := somme/Float(compteur);
      end if;
      
      return resultat;
   end Moyenne;

end Traitement;
