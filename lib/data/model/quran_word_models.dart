class QuranWordModels{

  int serialNo;
  String imageUrl;
  String percentComplete;
  String taskNumber;

  QuranWordModels({this.serialNo, this.imageUrl, this.percentComplete, this.taskNumber});

  QuranWordModels.fromMap(dynamic map){
    this.serialNo=map['SERIAL_NO'];
    this.imageUrl=map['IMAGE_URL'];
    this.percentComplete=map['PERCENT_COMPLETE'];
    this.taskNumber=map['TASK_NUMBER'];
  }

}