

class SingleFactory {
  Single mSingle;
  Single newInstant(){
    if(mSingle == null){
      mSingle = Single();
      return mSingle;
    }else return mSingle;
  }
}

class Single {
  String nameTower = "โปรดเลือกเสา";
}