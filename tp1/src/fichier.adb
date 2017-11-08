With Ada.Text_IO; use Ada.Text_IO;
with Element; use Element;

package body Fichier is

   -----------------
   -- Constructor --
   -----------------

   package body Constructor is

      ----------------
      -- Initialize --
      ----------------

      function Initialize(name: in String) return T_Element_Access is
         Temp_Ptr : T_Fichier_Access;
      begin
         Temp_Ptr := new T_Fichier;
         --Element.Constructor.Initialize(T_Element(Temp_Ptr), name);
         SetName(Temp_Ptr, name);
         return T_Element_Access(Temp_Ptr);
      end Initialize;

   end Constructor;

   --------------
   -- Afficher --
   --------------

   overriding procedure Afficher
     (this: access T_Fichier;
      curPath: in String)
   is
   begin
      put_line(curPath & this.GetName);
   end Afficher;

end Fichier;
