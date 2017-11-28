with Acpos; use Acpos.ADMList;
with Acpos; use Acpos.IRSList;
with Acpos; use Acpos.GPSList;
package body Acpos is


   function init_rec(admc: in out ADMList.Cursor;
                     irsc: in out IRSList.Cursor;
                     gpsc: in out GPSList.Cursor)
                     return T_Chaines
   is
      res: T_Chaines;
      next: T_Chaines;
   begin
      if admc = ADMList.No_Element then
         if irsc = IRSList.No_Element then
            if gpsc = GPSList.No_Element then
               res.chaineADM := null;
            else
               res.chaineADM := new T_SpeedSelector;
               res.chaineADM.Initialise(Element(gpsc));
               GPSList.Next(gpsc);
            end if;
         else
            res.chaineADM := new T_SpeedSelector;
            res.chaineADM.Initialise(Element(irsc));
            IRSList.Next(irsc);
         end if;
      else
         res.chaineADM := new T_SpeedSelector;
         res.chaineADM.Initialise(Element(admc));
         ADMList.Next(admc);
      end if;

      if irsc = IRSList.No_Element then
         if admc = ADMList.No_Element then
            if gpsc = GPSList.No_Element then
               res.chaineIRS := null;
            else
               res.chaineIRS := new T_SpeedSelector;
               res.chaineIRS.Initialise(Element(gpsc));
               GPSList.Next(gpsc);
            end if;
         else
            res.chaineIRS := new T_SpeedSelector;
            res.chaineIRS.Initialise(Element(admc));
            ADMList.Next(admc);
         end if;
      else
         res.chaineIRS := new T_SpeedSelector;
         res.chaineIRS.Initialise(Element(irsc));
         IRSList.Next(irsc);
      end if;



      next := init_rec(admc,
                       irsc,
                       gpsc);
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
      adms: in ADMList.Vector;
      irss: in IRSList.Vector;
      gpss: in GPSList.Vector)
   is
      temp_admc: ADMList.Cursor;
      temp_irsc: IRSList.Cursor;
      temp_gpsc: GPSList.Cursor;
   begin
      temp_admc := adms.First;
      temp_irsc := irss.First;
      temp_gpsc := gpss.First;
      this.chaines := init_rec(temp_admc,
                               temp_irsc,
                               temp_gpsc);
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
