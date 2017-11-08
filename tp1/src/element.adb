package body Element is

   -----------------
   -- Constructor --
   -----------------

   package body Constructor is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize (this: access T_Element; name: in String) is
      begin
         SetName(this, name);
      end Initialize;

   end Constructor;

   -------------
   -- SetName --
   -------------

   procedure SetName (this: access T_Element; n: in String) is
   begin
      this.name := n;
   end SetName;

   -------------
   -- GetName --
   -------------

   function GetName (this: access T_Element) return String is
   begin
      return this.name;
   end GetName;

end Element;
