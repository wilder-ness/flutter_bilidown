class ApiResult<T>{
  bool success;
  String message;
  T data;
  ApiResult(this.success,this.message,this.data);
}