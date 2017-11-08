With Ada.Text_IO; use Ada.Text_IO;
with Element; use Element;

package body Raccourci is

   -----------------
   -- Constructor --
   -----------------

   package body Constructor is

      ----------------
      -- Initialize --
      ----------------

      function Initialize
        (n: in String;
         e: in Element.T_Element_Access)
         return T_Element_Access
      is
         Temp_Ptr : T_Raccourci_Access;
      begin
         Temp_Ptr := new T_Raccourci;
         --Element.Constructor.Initialize(T_Element(Temp_Ptr), name);
         SetName(Temp_Ptr, n);
         SetElement(Temp_Ptr, e);
         return T_Element_Access(Temp_Ptr);
      end Initialize;

   end Constructor;

   --------------
   -- Afficher --
   --------------

   overriding procedure Afficher
     (this: access T_Raccourci;
      curPath: in String)
   is
   begin
      Put_Line(curPath & this.GetName & "-> " & this.link.GetName);
   end Afficher;

   ----------------
   -- SetElement --
   ----------------

   procedure SetElement
     (this: access T_Raccourci;
      e: in Element.T_Element_Access)
   is
   begin
      this.link := e;
   end SetElement;

end Raccourci;
