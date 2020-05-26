

class CurrentTime{
  int start;
  int _time;
  Function overFunction;
  CurrentTime(int start){
    this.start = start;
    _time = start;
  }

  int getTime(){
    return _time;
  }
  void decreaseTime(){
    _time--;
  }
  void addTime(int second){
    _time += second;
  }
}