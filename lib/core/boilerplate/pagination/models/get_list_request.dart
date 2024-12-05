class GetListRequest{

  int? page;
  Map<String, dynamic> params = {};
  Map<String, dynamic>?  extraParams;

  GetListRequest(
      {
        this.page,
        this.extraParams}
      );


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(page !=null) data['page'] = page;
    if(extraParams != null) {
      data.addAll(extraParams ?? {});
    }
    return data;
  }
}