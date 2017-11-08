With Ada.Text_IO; use Ada.Text_IO;

package body Repertoire is

   -----------------
   -- Constructor --
   -----------------

   package body Constructor is

      ----------------
      -- Initialize --
      ----------------

      function Initialize
        (name: in String;
         nbElement: in Natural)
         return T_Repertoire_Access
      is
         Temp_Ptr : T_Repertoire_Access;
      begin
         Temp_Ptr := new T_Repertoire(nbElement);
         --Element.Constructor.Initialize(T_Element(Temp_Ptr), name);
         SetName(Temp_Ptr, name);
         return Temp_Ptr;
      end Initialize;

   end Constructor;

   ----------------
   -- AddElement --
   ----------------

   procedure AddElement (this: access T_Repertoire; e: in T_Element_Access) is
   begin
      this.elems(this.indice) := e;
      this.indice := this.indice + 1;
   end AddElement;

   ------------
   -- isFull --
   ------------

   function isFull (this: access T_Repertoire) return Boolean is
   begin
      return this.indice < this.nbElem;
   end isFull;

   --------------
   -- Afficher --
   --------------

   overriding procedure Afficher
     (this: access T_Repertoire;
      curPath: in String)
   is
      i: Natural := 0;
   begin
      Put_Line(curPath & this.GetName);
      while (i < this.indice) loop
         Afficher(this.elems(i), curPath&this.GetName&'\');
           i := i +1;
      end loop;
   end Afficher;

end Repertoire;
