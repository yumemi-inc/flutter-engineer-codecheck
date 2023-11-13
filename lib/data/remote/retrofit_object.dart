/// retrofitで受け取ったjsonをそのまま保持するためのクラス
class RetrofitObject extends Object {
  const RetrofitObject(
    this.json,
  );

  RetrofitObject.fromJson(Map<String, dynamic> map) : json = map;

  final Map<String, Object?> json;
}
