package body Traitement is

   function Moyenne(this: access T_Traitement; 
                    liste: access AdmInt.SensorsMap.Map) 
                    return Float;
   is
      item : Cursor := liste.First;
   begin
      loop
         exit when item = No_Element;
         
         if Element(C).Stock < Low then
            -- print a message perhaps
            Put("Low stock of part ");
            Put_Line(Key(C).Part_Number);
         end if;
         C := The_Store.Next(C);
      end loop;
      while Has_Element(item)
      return R*Float(T0)*Math.Log(Float(p0)*pression)/(M*g);
   end computeAltitude;

end Traitement;
