package body Acpos is


   function init_rec(adms: in out ADMList.Vector;
                     irss: in out IRSList.Vector;
                     gpss: in out GPSList.Vector)
                     return T_Chaines
   is
      res: T_Chaines;
      next: T_Chaines;
   begin
      if adms.Is_Empty then
         if irss.Is_Empty then
            if gpss.Is_Empty then
               res.chaineADM := null;
            else
               res.chaineADM := new T_SpeedSelector;
               res.chaineADM.Initialise(gpss.First_Element);
               gpss.Delete_First;
            end if;
         else
            res.chaineADM := new T_SpeedSelector;
            res.chaineADM.Initialise(irss.First_Element);
            irss.Delete_First;
         end if;
      else
         res.chaineADM := new T_SpeedSelector;
         res.chaineADM.Initialise(adms.First_Element);
         adms.Delete_First;
      end if;

      if irss.Is_Empty then
         if adms.Is_Empty then
            if gpss.Is_Empty then
               res.chaineIRS := null;
            else
               res.chaineIRS := new T_SpeedSelector;
               res.chaineIRS.Initialise(gpss.First_Element);
               gpss.Delete_First;
            end if;
         else
            res.chaineIRS := new T_SpeedSelector;
            res.chaineIRS.Initialise(adms.First_Element);
            adms.Delete_First;
         end if;
      else
         res.chaineIRS := new T_SpeedSelector;
         res.chaineIRS.Initialise(irss.First_Element);
         irss.Delete_First;
      end if;

      next := init_rec(adms,irss,gpss);
      if next.chaineADM /= null then
         res.chaineADM.setSuivant(next.chaineADM);
      end if;
      if next.chaineIRS /= null then
         res.chaineIRS.setSuivant(next.chaineIRS);
      end if;
      return res;

   end init_rec;

   ----------------
   -- Initialise --
   ----------------

   procedure Initialise
     (this: access T_Acpos;
      adms: in out ADMList.Vector;
      irss: in out IRSList.Vector;
      gpss: in out GPSList.Vector)
   is
   begin
      this.chaines := init_rec(adms,irss,gpss);
      this.currentChaine := this.chaines.chaineADM;
   end Initialise;

   --------------
   -- getSpeed --
   --------------

   function getSpeed (this: access T_Acpos) return Float is
   begin
      return this.currentChaine.getSpeed;
   end getSpeed;

   procedure setCommand(this: access T_Acpos;
                        cmd: T_Command)
   is
   begin
      if cmd = IRS_FIRST then
         this.currentChaine := this.chaines.chaineIRS;
      else
         this.currentChaine := this.chaines.chaineADM;
      end if;

   end setCommand;


end Acpos;
