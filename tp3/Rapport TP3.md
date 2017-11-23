# CS 515 - TP3 : Pattern Stratégie

Développement d'un ADM (Air Data Module) simplifié qui calcule l'altitude et la vitesse son statut à partir de mesures de pression atmosphérique statique et dynamique.

## Diagramme UML

![Diagramme de Classe](ClassDiagram1.png)

On retrouve la structure générale mise en place au TP précédent, avec le **pattern listener** permettant à un *AdmInt* de s'abonner à un *PressureSensor*. Maintenant, comme l'*AdmInt* peut avoir plusieurs stratégie pour le filter ou le calcul de la vitesse, on utilise le **pattern strategy**. Ainsi peut importe l'objet utilisé pour filtrer ou pour calculer la vitesse, l'*AdmInt* ne verra que l'abstraction associée. On peut définir cet objet à la construction, et le changer en cours d'exécution.

## Code source

### Type Mesure

C'est le type qui va contenir les mesures des différents capteurs : le status, les pressions statique et totale.

```Ada
package Measure is

   type T_Measure is record 
      status: Boolean;
      totalPressure: Float;
      staticPressure: Float;
   end record;

end measure;
```

> measure.ads

### AbstractPressureSensor

Abstraction permettant de regrouper tout les capteurs.

On notera que cet objet permet de retenir une liste d'*observer*, qu'il faut notifier lorsque la valeur du capteur change.

```Ada
with PressureObserver; use PressureObserver;
with Ada.Containers.Vectors; use Ada.Containers;
with Measure; use Measure;

package AbstractPressureSensor is
   
   package ObserverContainer is new Vectors (Natural, T_PressureObserver_Access);
   
   type T_AbstractPressureSensor is abstract tagged record
      observers: ObserverContainer.Vector;
   end record;
   type T_AbstractPressureSensor_Access is access all T_AbstractPressureSensor'Class;
   
   procedure simuleMeasure(this: access T_AbstractPressureSensor; 
                           measure: in T_Measure) is abstract;

   procedure recordObserver(this: access T_AbstractPressureSensor;
                            observer: access T_PressureObserver'Class);
   
   function getMeasure(this: access T_AbstractPressureSensor) return T_Measure is abstract;

end AbstractPressureSensor;
```

> abstractpressuresensor.ads

```Ada
package body AbstractPressureSensor is

   procedure recordObserver
     (this: access T_AbstractPressureSensor;
      observer: access T_PressureObserver'Class)
   is
   begin
      this.observers.Append(observer);
   end recordObserver;

end AbstractPressureSensor;
```

> abstractpressuresensor.adb

### AdmExt et PressureSensor

Dans le cadre de cet exercice les deux implémentations sont très similaires et permettent simplement de simuler une nouvelle valeur.

```Ada
with AbstractPressureSensor; use AbstractPressureSensor;
with PressureObserver; use PressureObserver;
with Measure; use Measure;

package AdmExt is

   type T_AdmExt is new T_AbstractPressureSensor with private;
   type T_AdmExt_Access is access all T_AdmExt'Class;
     
   overriding procedure simuleMeasure(this: access T_AdmExt; 
                                      measure: in T_Measure);

   overriding function getMeasure(this: access T_AdmExt) return T_Measure;
   
private
   type T_AdmExt is new T_AbstractPressureSensor with record
      measure: T_Measure;
   end record;
   
end AdmExt;
```

> admext.ads

```Ada
with AbstractPressureSensor; use AbstractPressureSensor.ObserverContainer;
with PressureObserver; use PressureObserver;

package body AdmExt is

   overriding procedure simuleMeasure(this: access T_AdmExt;
                                      measure: in T_Measure)
   is
      C: Cursor := this.observers.First;
   begin
      this.measure := measure;
      loop
         exit when C = No_Element;
         Element(C).handleNewPressure(T_AbstractPressureSensor_Access(this));
         ObserverContainer.Next(C);
      end loop;
   end simuleMeasure;

   overriding function getMeasure(this: access T_AdmExt) return T_Measure
   is
   begin
      return this.measure;
   end getMeasure;

end AdmExt;
```

> admext.adb

```Ada
with AbstractPressureSensor; use AbstractPressureSensor;
with PressureObserver; use PressureObserver;
with Measure; use Measure;

package PressureSensor is

   type T_PressureSensor is new T_AbstractPressureSensor with private;
   type T_PressureSensor_Access is access all T_PressureSensor'Class;
      
   overriding procedure simuleMeasure(this: access T_PressureSensor; 
                                      measure: in T_Measure);
   overriding function getMeasure(this: access T_PressureSensor) return T_Measure;
   
private
   type T_PressureSensor is new T_AbstractPressureSensor with record
      measure: T_Measure;
   end record;
   
end PressureSensor;

```

> pressuresensor.ads

```Ada
with AbstractPressureSensor; use AbstractPressureSensor.ObserverContainer;
with PressureObserver; use PressureObserver;

package body PressureSensor is

   overriding procedure simuleMeasure(this: access T_PressureSensor;
                                      measure: in T_Measure)
   is
      C: Cursor := this.observers.First;
   begin
      this.measure := measure;
      loop
         exit when C = No_Element;
         Element(C).handleNewPressure(T_AbstractPressureSensor_Access(this));
         ObserverContainer.Next(C);
      end loop;
   end simuleMeasure;

   overriding function getMeasure(this: access T_PressureSensor) return T_Measure
   is
   begin
      return this.measure;
   end getMeasure;

end PressureSensor;

```

> pressuresensor.adb

### PressureObserver

C'est l'abstraction permettant d'être notifié en cas de changement de valeur sur l'un des capteurs.

On peut remarquer que l'on identifie les capteurs par leur adresse puisque c'est la seule information qu'on passe à cette méthode.

```Ada
limited with AbstractPressureSensor;

package PressureObserver is
   type T_PressureObserver is abstract tagged null record;
   type T_PressureObserver_Access is access all T_PressureObserver'Class;

   procedure handleNewPressure(this: access T_PressureObserver; 
                               sensor: access AbstractPressureSensor.T_AbstractPressureSensor'Class
                              ) is abstract;

end PressureObserver;
```

> pressureobserver.ads

### Stratégie des filtres

####AbstractFilter

C'est la première apparition du partern stratégie. Il permet de regrouper les différents types de filtres (tout les filtres doivent implémenter la fonction *filtrer*).

```Ada
package AbstractFilter is

   type T_AbstractFilter is abstract tagged null record;
   type T_AbstractFilter_Access is access all T_AbstractFilter'Class;
   
   function filter(this: access T_AbstractFilter;
                   pressure: in Float) return Float is abstract;
   
end AbstractFilter;
```

> abstractfiltrer.ads

#### FilterAirbus

Filtre pour les avions Airbus. On prend lors de la construction la constante **a** qui vaut 0.1 ou 0.01 en fonction de la pression filtrée. Il faut aussi garder en mémoire la dernière pression calculée.

```Ada
with AbstractFilter; use AbstractFilter;

package FilterAirbus is
   
   type T_FilterAirbus is new T_AbstractFilter with private;
   type T_FilterAirbus_Access is access all T_FilterAirbus'Class;
   
   package Constructor is
      function Initialize(a: in Float) return T_FilterAirbus_Access;
   end;
   
   overriding function filter(this: access T_FilterAirbus;
                   pressure: in Float) return Float;
   
   private
   type T_FilterAirbus is new T_AbstractFilter with record
      oldValue: Float := 0.0;
      a: Float;
   end record;

end filterAirbus;
```

> filterAirbus.ads

```Ada
package body FilterAirbus is

   package body Constructor is
      function Initialize (a: in Float) return T_FilterAirbus_Access;
      is
         Temp_Ptr : T_FilterAirbus_Access;
      begin
         Temp_Ptr := new T_FilterAirbus;
         Temp_Ptr.a := a;
         return Temp_Ptr;
      end Initialize;
   end Constructor;

   function filter (this: access T_FilterAirbus; pressure: in Float)
      return Float
   is
   begin
      this.oldValue = pressure + this.a * this.oldValue;
      return this.oldValue;
   end filter;

end FilterAirbus;
```

> filterAirbus.adb

#### FilterBoeing

Il faut garder en mémoire la dernière pression reçue.

```
with AbstractFilter; use AbstractFilter;

package filterBoeing is
   
   type T_FilterBoeing is new T_AbstractFilter with private;
   type T_FilterBoeing_Access is access all T_FilterBoeing'Class;
   
   overriding function filter(this: access T_FilterBoeing;
                   pressure: in Float) return Float;
   
private
   type T_FilterBoeing is new T_AbstractFilter with record
      oldValue: Float := 0.0;
   end record;

end filterBoeing;
```

> filterboeing.ads

```Ada
package body filterBoeing is

   function filter
     (this: access T_FilterBoeing;
      pressure: in Float)
      return Float
   is
   begin
      if this.oldValue = 0.0
      then
         this.oldValue := pressure;
      else
         this.oldValue := (pressure + this.oldValue)/2.0;
      end if;

      return this.oldValue;
   end filter;

end filterBoeing;
```

> filterboeing.adb

#### FilterDassault

Rien de spécial dans l'implémentation de ce filtre.

```Ada
with AbstractFilter; use AbstractFilter;

package FilterDassault is
   
   type T_FilterDassault is new T_AbstractFilter with null record;
   type T_FilterDassault_Access is access all T_FilterDassault'Class;
   
   overriding function filter(this: access T_FilterDassault;
                   pressure: in Float) return Float;

end FilterDassault;
```

> filterdassault.ads

```Ada
package body FilterDassault is

   function filter
     (this: access T_FilterDassault;
      pressure: in Float)
      return Float
   is
   begin
      return pressure;
   end filter;

end FilterDassault;
```

> filterdassault.adb

### Stratégie de vitesse

C'est la première apparition du partern stratégie. Il permet de regrouper les différents types de calcul de la vitesse (qui doivent implémenter une fonction *computeSpeed*).

```Ada
with Measure; use Measure;

package AbstractSpeed is
   
   type T_AbstractSpeed is abstract tagged null record;
   type T_AbstractSpeed_Access is access all T_AbstractSpeed'Class;
   
   function computeSpeed(this: access T_AbstractSpeed;
                         measure: in T_Measure) return Float is abstract;

end AbstractSpeed;
```

> abstractspeed.ads

#### TODO : Vitesse à écoulement compressible



#### TODO : Vitesse à écoulement incompressible



### AbstractAltitude

Encore un autre exemple du pattern stratégie, qui permet (même si dans notre cas on a qu'une façon de la calculer), changer l'objet de calcul de l'altitude.

```Ada
with Measure; use Measure;
package AbstractAltitude is

   type T_AbstractAltitude is abstract tagged null record;
   type T_AbstractAltitude_Access is access all T_AbstractAltitude'Class;
   
   function compute(this: access T_AbstractAltitude;
                            measure: in T_Measure) return Float is abstract;
   
end AbstractAltitude;
```

> abstractaltitude.ads

#### ComputeAltitude

Contient une procèdure qui retourne l'altitude à partir d'une pression, en définissant diverse constante.

```Ada
with AbstractAltitude; use AbstractAltitude;
with Measure; use Measure;
package ComputeAltitude is
   
   type T_ComputeAltitude is new T_AbstractAltitude with null record;
   type T_ComputeAltitude_Access is access all T_ComputeAltitude'Class;
   
   overriding function compute(this: access T_ComputeAltitude;
                               measure: in T_Measure) return Float;
   
   
   g : constant Float := 9.807;
   p0 : constant Float := 101315.0;
   R : constant Float := 8.314;
   T0 : constant Natural := 15;
   M : constant Float := 0.02896;
   
end ComputeAltitude;
```

> computealtitude.ads

```Ada
with Ada.Numerics.Generic_Elementary_Functions;

package body ComputeAltitude is

   overriding function compute(this: access T_ComputeAltitude;
                               measure: in T_Measure) return Float 
   is
      package Math is new Ada.Numerics.Generic_Elementary_Functions(Float);
   begin
      return R*Float(T0)*Math.Log(p0/measure.staticPressure)/(M*g);
   end compute;
  
end ComputeAltitude;
```

> computealtitude.adb

### Traitement

Permet de traiter une liste de pression en vérifiant leur validité puis en calculant la moyenne de toutes ces pressions valide. Cette fonction a été modifiée pour supporter 2 pressions.

Remarque : Il s'agit uniquement d'un package et pas d'un objet. Cela permet de séparer les rôles, cependant si on veux changer de fonction *Moyenne* il faut le faire en recompilant et non à la volée comme on pourrait le faire avec un objet lié à *AdmInt*.

```ada
with AdmInt;
with Measure;
with Compute;

package Traitement is
   
   function Moyenne(liste: in AdmInt.SensorMap.Map) 
                    return Measure.T_Measure;   
end Traitement;
```

> traitement.ads

```ada
with AdmInt; use AdmInt.SensorMap;
with ComputeAltitude; use ComputeAltitude;
with Measure; use Measure;

package body Traitement is

   function Moyenne(liste: in AdmInt.SensorMap.Map) 
                    return T_Measure 
   is
      item : Cursor := liste.First;
      compteur : Natural := 0;
      staticSomme : Float := 0.0;
      totalSomme : Float := 0.0;
      resultat : T_Measure;
   begin
      loop
         exit when item = No_Element;
         if Element(item).status and 
           Element(item).staticPressure>0.0 and 
           Element(item).staticPressure <= ComputeAltitude.p0 and
           Element(item).totalPressure>0.0 and
           Element(item).totalPressure <= ComputeAltitude.p0
         then 
            compteur := compteur + 1;
            staticSomme := staticSomme + Element(item).staticPressure;
            totalSomme := totalSomme + Element(item).totalPressure;
         end if;
         Next(item);
      end loop;
                  
      resultat.status := compteur/=0;
      if compteur /= 0
      then 
         resultat.staticPressure := staticSomme/Float(compteur);
         resultat.totalPressure := totalSomme/Float(compteur);
      end if;
      
      return resultat;
   end Moyenne;

end Traitement;
```

> traitement.adb

### TODO : AdmInt

Implémente l'objet en charge de récupèrer les données des différents capteur et de fournir la valeur de l'altitude et de la vitesse en temps réel.

Nous stockons les différents pressions dans une **Hashed_Map** ayant comme clé l'adresse de l'objet *Capteur de pression*, et comme valeur une *Measure*.

A l'initialisation, il doit s'enregistrer auprès des différents capteurs qu'il veut observer.

Ensuite à la notification d'une nouvelle valeur, *AdmInt* va :

1. Enregistrer la valeur dans la Hashmap
2. Passer la liste de valeur au module *Traitement* qui lui retourne la moyenne de toutes les pressions
3. TODO ...

## TODO : Tests

### Fichier de test

 ```Ada

 ```

### Exécution des tests

```Ada

```

### Analyse

### Test 1 

- ​



