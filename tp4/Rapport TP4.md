# CS 515 - TP4: Pattern Chaine de responsabilité

> Alexis BERTRAND
>
> Guillaume BRUCHON

Logiciel permettant d'estimer la meilleur vitesse en fonction des vitesses reçues des divers équipements.

## Diagramme UML

![Diagramme de Classe](ClassDiagram1.png)

Etant donné que les objets `Adm`, `Irs`et `Gps`sont figés et qu'ils ne corespondent pas à notre abstraction `AbstractVitesse`, nous avons défini des **adapteurs** qui permettent d'adapter l'interface de ces objets à la nôtre.

On retrouve aussi le pattern **chaine de responsabilité** avec le `SpeedSelector` : chaque maillon de la chaine à pour objectif de déterminer s'il est en mesure de donner l'information de vitesse (en utilisant l'`AbstractVitesse` auquel il est lié), ou le cas échant demande au maillon suivant.

L'`Acpos`contient deux listes de `SpeedSelector`: Une pour le *IRS_FIRST*, l'autre pour le *ADM_FISRT* qui sont construit en même temps l'objet lui-même.



## Code source

### Classes figées : Adm, Irs, Gps

Ces 3 classes représentent les équipements qui founissent les données permettant de calculer la vitesse.

Il n'y a rien de particulier sur l'implémentation de ces classes, mis à part le fait que l'interface de toutes ces classes est volontairement différents afin de montrer l'intérêt du pattern adapter.

Ces objets permettent uniquement de stocker une valeur (la valeur actuelle mesurée par le capteur), et spécifiquement pour `Adm` un status. On ajoutera à ces attributs des getters et setters.

```Ada
package Adm is
   
   type T_Adm is tagged private;
   type T_Adm_Access is access all T_Adm;
   
   procedure setState(this: access T_Adm; v: in Float; b: in Boolean);
   function getValue(this: access T_Adm) return Float
     with Post => getValue'Result >= 0.0 and getValue'Result <= 1300.0;
   function getStatus(this: access T_Adm) return Boolean;
      
private
   type T_Adm is tagged record
      value: Float;
      status: Boolean;
   end record;
end Adm;
```

> adm.ads

```Ada
package body Adm is

   procedure setState (this: access T_Adm; v: in Float; b: in Boolean) is
   begin
      this.value := v;
      this.status := b;
   end setState;

   function getValue (this: access T_Adm) return Float is
   begin
      return this.value;
   end getValue;

   function getStatus (this: access T_Adm) return Boolean is
   begin
      return this.status;
   end getStatus;

end Adm;
```

> adm.adb

```Ada
package Gps is

   type T_Gps is tagged private;
   type T_Gps_Access is access all T_Gps;
   
   procedure setValue(this: access T_Gps; v: in Float);
   function gpsSpeed(this: access T_Gps) return Float
     with Post => gpsSpeed'Result >= 0.0 and gpsSpeed'Result <= 1000.0;
   
private
   
   type T_Gps is tagged record
      value: Float;
   end record;
end Gps;
```

> gps.ads

```Ada
package body Gps is

   procedure setValue (this: access T_Gps; v: in Float) is
   begin
      this.value := v;
   end setValue;

   function gpsSpeed (this: access T_Gps) return Float is
   begin
      return this.value;
   end gpsSpeed;

end Gps;
```

> gps.adb

```Ada
package Irs is

   type T_Irs is tagged private;
   type T_Irs_Access is access all T_Irs;
   
   procedure setValue(this: access T_Irs; v: in Float);
   function irsSpeed(this: access T_Irs) return Float
     with Post => irsSpeed'Result >= 0.0 and irsSpeed'Result <= 900.0;
   
private
   type T_Irs is tagged record
      speed: Float;
   end record;
end Irs;
```

> irs.ads

```Ada
package body Irs is

   procedure setValue (this: access T_Irs; v: in Float) is
   begin
      this.speed := v;
   end setValue;

   function irsSpeed (this: access T_Irs) return Float is
   begin
      return this.speed;
   end irsSpeed;

end Irs;
```

> irs.adb

Etant donné que la plage de valeur que peuvent retourner les capteurs est fixe, nous avons défini des **postconditions** dans les getters :

- Adm : Valeur retournée comprise entre 0 et 1300
- Gps : Valeur retournée comprise entre 0 et 1000
- Irs : Valeur retournée comprise entre 0 et 900

### Adapters : AdmAdapter, IrsAdapter, GpsAdapter 

Ces adapeurs sont liés à l'objet correspondant et permettent de retourner un objet de type **Vitesse** qui contient une valeur et un status :

```Ada
package Vitesse is
   type T_Vitesse is record
      status: Boolean;
      value: Float;
   end record;
end Vitesse;
```

> Vitesse.ads

#### AdmAdapter

Cet adapteur permet d'utiliser un `Adm`. Lors de sa construction, il prend en paramètre un `Adm`, puis lorsque nécéssaire, demande à l'`Adm` sa valeur actuelle (en kts) puis la convertie pour pouvoir l'utiliser dans notre application (en m/s).

On peut ajouter une **postcondition** pour vérifier que le status est ok, la valeur retournée est bien dans l'intervalle : 0 - 668.2 (qui correspond à 1300*0.514).

```Ada
with AbstractVitesse; use AbstractVitesse;
with Adm; use Adm;
with Vitesse; use Vitesse;

package AdmAdapter is
   
   type T_AdmAdapter is new T_AbstractVitesse with private;
   type T_AdmAdapter_Access is access all T_AdmAdapter'Class;
   
   procedure Initialise (this: in out T_AdmAdapter; adm: access T_Adm);
   
   function getSpeed(this: access T_AdmAdapter) return T_Vitesse
     with post => (not getSpeed'Result.status) or 
     (getSpeed'Result.status and getSpeed'Result.value >= 0.0 and getSpeed'Result.value <= 668.2);
   
   ktsToms : constant Float := 0.514;
   
private
   type T_AdmAdapter is new T_AbstractVitesse with Record
      adm: access T_Adm;
   end record;

end AdmAdapter;
```

> admadapter.ads

```Ada
package body AdmAdapter is

   procedure Initialise (this: in out T_AdmAdapter; adm: access T_Adm) is
   begin
      this.adm := adm;
   end Initialise;

   function getSpeed (this: access T_AdmAdapter) return T_Vitesse is
      result: T_Vitesse;
   begin
      result.status := this.adm.getStatus;
      result.value := this.adm.getValue * ktsToms;
      return result;
   end getSpeed;

end AdmAdapter;
```

> admadapter.adb

#### IrsAdapter

Cet adapteur permet d'utiliser un `Irs`. Lors de sa construction, il prend en paramètre un `Irs`, puis lorsque nécéssaire, demande à `Irs` sa valeur actuelle puis vérifie qu'elle est inférieure à 800 m/s sinon la valeur est marquée comme invalide.

On peut ajouter une **postcondition** pour vérifier que le status est ko ou ok, et que la valeur retournée est bien dans l'intervalle : 0 - 800 (sinon elle est invalide).

```Ada
with AbstractVitesse; use AbstractVitesse;
with Irs; use Irs;
with Vitesse; use Vitesse;

package IrsAdapter is

   type T_IrsAdapter is new T_AbstractVitesse with private;
   type T_IrsAdapter_Access is access all T_IrsAdapter'Class;
   
   procedure Initialise (this: in out T_IrsAdapter; irs: access T_Irs);
   
   function getSpeed(this: access T_IrsAdapter) return T_Vitesse
     with post => (not getSpeed'Result.status and getSpeed'Result.value > 800.0) or 
     (getSpeed'Result.status and getSpeed'Result.value >= 0.0 and getSpeed'Result.value <= 800.0);
   
private
   type T_IrsAdapter is new T_AbstractVitesse with Record
      irs: access T_Irs;
   end record;
end IrsAdapter;
```

> lrsadapter.ads

```Ada
package body IrsAdapter is

   procedure Initialise (this: in out T_IrsAdapter; irs: access T_Irs) is
   begin
      this.irs := irs;
   end Initialise;

   function getSpeed (this: access T_IrsAdapter) return T_Vitesse is
      result: T_Vitesse;
   begin
      result.status := this.irs.irsSpeed <= 800.0;
      result.value := this.irs.irsSpeed;
      return result;
   end getSpeed;

end IrsAdapter;
```

> lrsadapter.adb

#### GpsAdapter

Cet adapteur permet d'utiliser un `Gps`. Lors de sa construction, il prend en paramètre un `Gps`, puis lorsque nécéssaire, demande à `Gps` sa valeur actuelle puis vérifie qu'elle est inférieure à 800 m/s sinon la valeur est saturée à 800 m/s.

On peut ajouter une **postcondition** pour vérifier que le status est toujours ok, et que la valeur retournée est bien dans l'intervalle : 0 - 800.

```Ada
with AbstractVitesse; use AbstractVitesse;
with Gps; use Gps;
with Vitesse; use Vitesse;

package GpsAdapter is

   type T_GpsAdapter is new T_AbstractVitesse with private;
   type T_GpsAdapter_Access is access all T_GpsAdapter'Class;
   
   procedure Initialise (this: in out T_GpsAdapter; gps: access T_Gps);
   
   function getSpeed(this: access T_GpsAdapter) return T_Vitesse
     with post => (getSpeed'Result.status and getSpeed'Result.value >= 0.0 and getSpeed'Result.value <= 800.0);
   
private
   type T_GpsAdapter is new T_AbstractVitesse with Record
      gps: access T_Gps;
   end record;
end GpsAdapter;
```

> gpsadapter.ads

```Ada
package body GpsAdapter is

   procedure Initialise (this: in out T_GpsAdapter; gps: access T_Gps) is
   begin
      this.gps := gps;
   end Initialise;

   function getSpeed (this: access T_GpsAdapter) return T_Vitesse is
      result: T_Vitesse;
      temp: Float;
   begin
      temp := this.gps.gpsSpeed;
      result.status := True;
      if temp >= 800.0 then
         result.value := 800.0;
      else
         result.value := temp;
      end if;
      return result;
   end getSpeed;

end GpsAdapter;
```

> gpsadapter.adb



### AbstractVitesse

C'est une simple abstraction permettant de voir de la même manière tous les adapter des capteurs. Ils devront tous définir une fonction `getSpeed` qui permet de récupèrer leur valeur actuelle.

```Ada
with Vitesse; use Vitesse;
package AbstractVitesse is
   
   type T_AbstractVitesse is abstract tagged null record;
   type T_AbstractVitesse_Access is access all T_AbstractVitesse'Class;
   
   function getSpeed(this: access T_AbstractVitesse) return T_Vitesse is abstract;   

end AbstractVitesse;
```

> abstractvitesse.ads

### SpeedSelector

SpeedSelecteur correspond aux maillons de notre chaine de responsabilité. Chaque maillon de la chain est en réalité associé à un capteur de vitesse (`AbstractVitesse`) et au maillon suivant (la construction de cette chaine est réalisé par le constructeur de `Acpos`).

Par exemple si l'on souhaite que la priorité de selection des valeurs soit : ADM1 => ADM2 => ... => GPS1, il faut chainer les maillons dans le même ordre.

Chaque maillon va récuperer la vitesse qui lui est associé, vérifier quelle soit correcte avant de la retourner, sinon il demande au prochain maillon sa valeur. Comme les GPS retournent toujours une valeur correcte, dans le pire des cas, on aura toujours au moins la valeur du GPS à retourner.

La vitesse retourné par ce composant doit être comprise entre 0 et 800 m/s (**postcondition**).

```Ada
with AbstractVitesse; use AbstractVitesse;

package SpeedSelector is

   type T_SpeedSelector is tagged private;
   type T_SpeedSelector_Access is access all T_SpeedSelector'Class;
   
   procedure Initialise (this: in out T_SpeedSelector; vitesse: access T_AbstractVitesse'Class); 
   
   procedure setSuivant (this: in out T_SpeedSelector; next: access T_SpeedSelector);
   
   function getSpeed(this: access T_SpeedSelector) return Float
     with post => getSpeed'Result >= 0.0 and getSpeed'Result <= 800.0;
   
private
   type T_SpeedSelector is tagged record
      vitesse: access T_AbstractVitesse'Class;
      next: access T_SpeedSelector;
   end record;
end SpeedSelector;
```

> speedselector.ads

```Ada
with Vitesse; use Vitesse;
package body SpeedSelector is

   procedure Initialise
     (this: in out T_SpeedSelector;
      vitesse: access T_AbstractVitesse'Class)
   is
   begin
      this.vitesse := vitesse;
   end Initialise;

   procedure setSuivant
     (this: in out T_SpeedSelector;
      next: access T_SpeedSelector)
   is
   begin
      this.next := next;
   end setSuivant;

   function getSpeed (this: access T_SpeedSelector) return Float is
      result: T_Vitesse;
   begin
      result := this.vitesse.getSpeed;
      if(result.status)
      then return result.value;
      else return this.next.getSpeed;
      end if;

   end getSpeed;

end SpeedSelector;
```

> speedselector.adb

### Acpos

C'est ce module `acpos` qui permet d'obtenir la valeur correcte de la vitesse suivant la chaine de responsabilité que l'on a vu précédement.

Dans son constructeur, on lui donne 3 listes : 

- une liste d'adm (adapter)
- une liste d'irs (adapter)
- une liste de gps (adpater)

En réalité ces 3 listes sont vu comme des `AbstractVitesse`.

Le rôle du construteur sera alors de contruire 2 chaines de responsabilité :

- L'une avec *ADM_FIRST*
- L'autre avec *IRS_FIRST*

On pourra alors switcher de l'une à l'autre en envoyant une commande à l'`acpos`.

Le constructeur construit ces chaines de manières récurssive.

Grâce à la fonction `getSpeed` on obtient la vitesse actuelle suivant le critère choisi. Cette vitesse est toujours comprise entre 0 et 800 m/h (**postcondition**).

```Ada
with Ada.Containers.Vectors; use Ada.Containers;
with GpsAdapter; use GpsAdapter;
with IrsAdapter; use IrsAdapter;
with AdmAdapter; use AdmAdapter;
with SpeedSelector; use SpeedSelector;
with AbstractVitesse; use AbstractVitesse;

package Acpos is

   type T_Command is (IRS_FIRST, ADM_FIRST);
   
   type T_Acpos is tagged private;
   type T_Acpos_Access is access all T_Acpos;
   
   package List is new Vectors (Natural, T_AbstractVitesse_Access);
   
   procedure Initialise(this: access T_Acpos;
                        l1: in List.Vector;
                        l2: in List.Vector;
                        l3: in List.Vector);
   
   function getSpeed(this: access T_Acpos) return Float
     with post => getSpeed'Result >= 0.0 and getSpeed'Result <= 800.0;
   
   procedure setCommand(this: access T_Acpos;
                        cmd: in T_Command);
   
private
   type T_Acpos is tagged record
      chaineIRS: access T_SpeedSelector;
      chaineADM: access T_SpeedSelector;
      currentChaine: access T_SpeedSelector;
   end record;
   
end Acpos;
```

> acpos.ads

```Ada
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
```

> acpos.adb

## Tests

### Fonction de test

```
with Acpos; use Acpos;

package test is
   
   function testunit (acpos1: access T_Acpos'Class; 
                  acpos2: access T_Acpos'Class; 
                  expectedSpeed1: in Float;
                  expectedSpeed2: in Float) return Boolean;

end test;
```

> test.ads

```
package body test is

   ----------
   -- test --
   ----------

   function testunit
     (acpos1: access T_Acpos'Class;
      acpos2: access T_Acpos'Class;
      expectedSpeed1: in Float;
      expectedSpeed2: in Float)
      return Boolean
   is
      vitesse1: Float;
      vitesse2: Float;
   begin
      vitesse1 := acpos1.getSpeed;
      vitesse2 := acpos2.getSpeed;
      Put_Line("acpos1 : " & Float'Image(vitesse1) & "/" & Float'Image(expectedSpeed1));
      Put_Line("acpos2 : " & Float'Image(vitesse2) & "/" & Float'Image(expectedSpeed2));
      return (Float'Image(expectedSpeed1) /= Float'Image(vitesse1)) or
        (Float'Image(expectedSpeed2) /= Float'Image(vitesse2));

   end testunit;

end test;
```

> test.adb

Cette fonction de test Permet de réaliser un test unitaire, elle prends en paramètre les deux acpos et des vitesses attendues, affiche le résultat du test et retourne un booléen qui true si il y a une erreur.

### Fichier de test

```
with Ada.Text_IO; use Ada.Text_IO;
with Adm; use Adm;
with Irs; use Irs;
with Gps; use Gps;
with AdmAdapter; use AdmAdapter;
with IrsAdapter; use IrsAdapter;
with GpsAdapter; use GpsAdapter;
with Acpos; use Acpos;
with test; use test;
with AbstractVitesse; use AbstractVitesse;


procedure Main is
   adm1: T_Adm_Access;
   adm2: T_Adm_Access;
   adm3: T_Adm_Access;
   irs1: T_Irs_Access;
   irs2: T_Irs_Access;
   gps1: T_Gps_Access;
   gps2: T_Gps_Access;
   adm1Adapter: T_AdmAdapter_Access;
   adm2Adapter: T_AdmAdapter_Access;
   adm3Adapter: T_AdmAdapter_Access;
   irs1Adapter: T_IrsAdapter_Access;
   irs2Adapter: T_IrsAdapter_Access;
   gps1Adapter: T_GpsAdapter_Access;
   gps2Adapter: T_GpsAdapter_Access;

   admList: Acpos.List.Vector;
   irsList: Acpos.List.Vector;
   gpsList: Acpos.List.Vector;

   acpos1: T_Acpos_Access;
   acpos2: T_Acpos_Access;

   error: Boolean := False;
begin
   Put_Line("---------- Initialisation ----------");
   adm1 := new T_Adm;
   adm2 := new T_Adm;
   adm3 := new T_Adm;
   irs1 := new T_Irs;
   irs2 := new T_Irs;
   gps1 := new T_Gps;
   gps2 := new T_Gps;
   adm1Adapter := new T_AdmAdapter;
   adm2Adapter := new T_AdmAdapter;
   adm3Adapter := new T_AdmAdapter;
   irs1Adapter := new T_IrsAdapter;
   irs2Adapter := new T_IrsAdapter;
   gps1Adapter := new T_GpsAdapter;
   gps2Adapter := new T_GpsAdapter;
   adm1Adapter.Initialise(adm1);
   adm2Adapter.Initialise(adm2);
   adm3Adapter.Initialise(adm3);
   irs1Adapter.Initialise(irs1);
   irs2Adapter.Initialise(irs2);
   gps1Adapter.Initialise(gps1);
   gps2Adapter.Initialise(gps2);


   --Init acpos1 et acpos2
   admList.Append(T_AbstractVitesse_Access(adm1Adapter));
   admList.Append(T_AbstractVitesse_Access(adm2Adapter));
   admList.Append(T_AbstractVitesse_Access(adm3Adapter));
   irsList.Append(T_AbstractVitesse_Access(irs1Adapter));
   irsList.Append(T_AbstractVitesse_Access(irs2Adapter));
   gpsList.Append(T_AbstractVitesse_Access(gps2Adapter));
   gpsList.Append(T_AbstractVitesse_Access(gps1Adapter));
   acpos1 := new T_Acpos;
   acpos1.Initialise(admList, irsList, gpsList);
   admList.Reverse_Elements;
   irsList.Reverse_Elements;
   gpsList.Reverse_Elements;
   acpos2 := new T_Acpos;
   acpos2.Initialise(admList, irsList, gpsList);



   Put_Line("---------- Debut des tests ----------");

   Put_Line("===> Test 1");
   adm1.setState(100.0, True);
   adm2.setState(500.0, True);
   adm3.setState(1000.0, True);
   irs1.setValue(850.0);
   irs2.setValue(500.0);
   gps1.setValue(950.0);
   gps2.setValue(10.0);
   error := error or testunit(acpos1, acpos2, 100.0*0.514, 1000.0*0.514);

   Put_Line("===> Test 2");
   adm1.setState(100.0, False);
   adm2.setState(500.0, True);
   adm3.setState(1000.0, False);
   error := error or testunit(acpos1, acpos2, 500.0*0.514, 500.0*0.514);

   Put_Line("===> Test 3");
   adm2.setState(500.0, False);
   error := error or testunit(acpos1, acpos2, 500.0, 500.0);

   Put_Line("===> Test 4");
   irs2.setValue(900.0);
   error := error or testunit(acpos1, acpos2, 10.0, 950.0);

   Put_Line("===> Test 5");
   acpos1.setCommand(IRS_FIRST);
   adm1.setState(100.0, True);
   adm2.setState(500.0, False);
   adm3.setState(1000.0, False);
   irs1.setValue(850.0);
   irs2.setValue(800.0);
   gps1.setValue(950.0);
   gps2.setValue(10.0);
   error := error or testunit(acpos1, acpos2, 800.0, 100.0*0.514);

   Put_Line("===> Test 6");
   adm1.setState(100.0, False);
   irs2.setValue(850.0);
   error := error or testunit(acpos1, acpos2, 10.0, 950.0);

   Put_Line("===> Test 7");
   acpos1.setCommand(ADM_FIRST);
   adm1.setState(100.0, True);
   adm2.setState(500.0, True);
   adm3.setState(1000.0, True);
   irs1.setValue(850.0);
   irs2.setValue(500.0);
   gps1.setValue(950.0);
   gps2.setValue(10.0);
   error := error or testunit(acpos1, acpos2, 100.0*0.514, 1000.0*0.514);

   Put_Line("---------- Resultat des tests ----------");
   if error
   then Put_Line("TESTS FAIL");
   else Put_Line("TESTS OK");
   end if;

--   Put_Line("===> Test du contrat");
--   irs2.setValue(1000.0);

end Main;
```

> main.adb

Ce fichier main permet d'executer les tests. Il y a une première phase d'initialisation où l'on instancie nos objets, puis une phase de tests unitares avec affichage dans le terminal ainsi que tests d'assertion (voir fonction `testunit`)

### Exécution des tests

### Analyse

#### Test 1

Dans ce premier test, nous initialisons tous les capteurs avec des valeurs par défaut et les adm avec des valeurs valides et des états OK. On observe que pour chaque acpos, leur premier adm a été choisis (adm1 pour acpos1 et adm3 pour acpos2) Cela confirme en partie l'exigence no 1, les ADM sont bien choisis en premier par défaut et leur ordre est différent selon l'acpos. Ce test valide aussi l'exigence no 4, la conversion kt -> m/s est réalisé par l'adapteur.

#### Test 2

L'état des adm 1 et 3 passe à KO, on observe bien que les deux acpos choisissent leur deuxième adm (adm2) Cela confirme encore un peu plus l'exigence no 1 car la gestion de la priorité semble fonctionner

#### Test 3

L'adm2 passe aussi à l'état KO, et l'irs1 possède une valeur invalide, on observe que les deux acpos utilise bien l'irs2. Cela valide l'exigence 5

#### Test 4 

Cette fois ci c'est au tour de l'irs2 de fournir une valeur erronée, on observe que les deux acpos passent aux gps 1 et 2, l'acpos1 utilise le gps1 et l'acpos2 utilise le gps2, on observe que le valeur de l'acpos2 est 800 alors que le gps2 indique 950, la saturation de l'exigence 6 fonctionne

#### Test 5

Dans ce test, l'acpos1 reçoit la commande `IRS_FIRST` et l'adm1 retourne une valeur valide. l'acpos1 ignore l'irs1 car la valeur est invalide et retourne donc celle de irs2. Cela prouve l'exigence 2 et confirme encore l'exigence 1

#### Test 6

Test identique au test 4, ce dernier permet de confirmer que le gps est utilisé en dernier recours même avec la commande `IRS_FIRST`

#### Test 7

Cette fois ci, la commande `ADM_FIRST` est envoyé au acpos1 et les adm repassent OK, on observe bien que les acpos 1 et 2 utilisent respectivement les adm 1 et 2. L'exigence 2 est validée

#### Exigence 3

L'Exigence 3 est renforcée par la programmation par contrat et ne doit pas arriver.