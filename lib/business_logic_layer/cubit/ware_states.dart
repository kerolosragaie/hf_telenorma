
abstract class WareStates{}
class WareInitialState extends WareStates{}
class WareLoadedState extends WareStates {}
class AllWareLoadedState extends WareStates {
 late final allWares ;
  AllWareLoadedState(this.allWares);
}
class IncreaseMenge extends WareStates{}
class DecreaseMenge extends WareStates{}
