with Acpos; use Acpos.List;

package body Acpos is

   function init_rec(l1c: in List.Cursor;
                     l2c: in List.Cursor;
                     l3c: in List.Cursor)
                     return T_SpeedSelector_Access
   is
      res: T_SpeedSelector_Access;
      next: T_SpeedSelector_Access;
      l1 : List.Cursor;
      l2 : List.Cursor;
      l3 : List.Cursor;
   begin
      l1 := l1c;
      l2 := l2c;
      l3 := l3c;
      if l1 = No_Element then
         if l2 = No_Element then
            if l3 = No_Element then
               return null;
            else
               res := new T_SpeedSelector;
               res.Initialise(Element(l3));
               List.Next(l3);
            end if;
         else
            res := new T_SpeedSelector;
            res.Initialise(Element(l2));
            List.Next(l2);
         end if;
      else
         res := new T_SpeedSelector;
         res.Initialise(Element(l1));
         List.Next(l1);
      end if;

      next := init_rec(l1,l2,l3);
      if next /= null then
         res.setSuivant(next);
      end if;
      return res;

   end init_rec;

   procedure Initialise
     (this: access T_Acpos;
      l1: in List.Vector;
      l2: in List.Vector;
      l3: in List.Vector)
   is
   begin
      this.chaineADM := init_rec(l1.First,l2.First,l3.First);
      this.chaineIRS := init_rec(l2.First,l1.First,l3.First);
      this.currentChaine := this.chaineADM;
   end Initialise;

   function getSpeed (this: access T_Acpos) return Float is
   begin
      return this.currentChaine.getSpeed;
   end getSpeed;

   procedure setCommand(this: access T_Acpos;
                        cmd: T_Command)
   is
   begin
      if cmd = IRS_FIRST then
         this.currentChaine := this.chaineIRS;
      else
         this.currentChaine := this.chaineADM;
      end if;

   end setCommand;

end Acpos;
