class ProductsModel {
  String? name;
  String? phone;
  String? address;
  var prize;
  var amountPaid;
  var remainingAmount;
  String? date;
  bool? isDelliverd;
  var numDresses;
  var length;
  var chestLength;
  var ketfLength;
  var komLength;
  var neck;
  var handLength;
  var hand2Length;
  var droppTaqwera2;
  var droppTaqwera1;
  var droppTaqwera3;
  var badnSize1;
  var badnSize2;
  var badnSize3;
  var kLength;
  var k2Length;
  var mLength;
  var details;
  var komSize;
  var yaqaSize;
  var gaybSize;
  var ganbSize;
  var sadrSize;
  var taqweraSize;
  var glabSize;
 var komSha3rawyLenght1;
  var komSha3rawyLenght2;
  var komSha3rawyLenght3;
  var komSha3rawyLenght4;
  var komBaladyLenght1;
  var komBaladyLenght2;
  var komBaladyLenght3;
  var komBaladyLenght4;

  String? glab;
  String? yaqa;
  String? gayb;
  String? ganb;
  String? taqwera;
  String? kom;
  String? komBalady ;
  String? komSha3rawy;
  String? createdAt;
  String? deliveryTime;
  String? type;
  String? additionalType1;
  String? additionalType2;
  String? fyberType;
  var quantity;
  var workerCost;
  var total;
  String? image;
  String? sId;
  String? sadr;
  var code;
  int? iV;

  ProductsModel(
      {this.name,
      this.phone,
      this.badnSize1,
      this.badnSize2,
      this.badnSize3,
      this.taqweraSize,
      this.droppTaqwera1,
      this.droppTaqwera2,
      this.droppTaqwera3,
      this.k2Length,
      this.hand2Length,
      this.sadrSize,
      this.ganbSize,
      this.komSize,
      this.yaqaSize,
      this.gaybSize,
      this.glabSize,
      this.address,
      this.isDelliverd,
      this.prize,
      this.amountPaid,
        this.komBaladyLenght1,
        this.komBaladyLenght2,
        this.komBaladyLenght3,
        this.komBaladyLenght4,

        this.remainingAmount,
      this.date,
        this.komBalady,
        this.komSha3rawy,
      this.numDresses,
      this.length,
      this.chestLength,
      this.ketfLength,
      this.komLength,
      this.neck,
      this.code,
      this.sadr,
      this.handLength,
      this.kLength,
      this.mLength,
      this.details,
      this.glab,
      this.yaqa,
      this.gayb,
      this.ganb,
      this.taqwera,
      this.kom,
      this.createdAt,
      this.deliveryTime,
      this.type,
      this.additionalType1,
      this.additionalType2,
      this.fyberType,
      this.quantity,
      this.workerCost,
      this.total,
        this.komSha3rawyLenght1,
        this.komSha3rawyLenght2,
        this.komSha3rawyLenght3,
        this.komSha3rawyLenght4,

      this.image,
      this.sId,
      this.iV});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    komSha3rawy=json["kom_sha3rawy"];
    komBalady=json["kom_balady"];
    sadrSize = json["sadr_size"];
    komBaladyLenght1=json["kom_balady_lenght1"];
    komBaladyLenght2=json["kom_balady_lenght2"];
    komBaladyLenght3=json["kom_balady_lenght3"];
    komBaladyLenght4=json["kom_balady_lenght4"];

    ganbSize = json["ganb_size"];
    yaqaSize = json["yaqa_size"];
    komSize = json["kom_size"];
    glabSize = json["glab_size"];
    taqweraSize = json["taqwera_size"];
    gaybSize = json["gayb_size"];
    k2Length = json["k2_length"];
    hand2Length = json["hand2_length"];
    droppTaqwera3 = json["dropp_taqwera3"];
    droppTaqwera2 = json["dropp_taqwera2"];
    droppTaqwera1 = json["dropp_taqwera1"];
    komSha3rawyLenght4=json["kom_sha3rawy_lenght4"];
    komSha3rawyLenght3=json["kom_sha3rawy_lenght3"];
    komSha3rawyLenght2=json["kom_sha3rawy_lenght2"];
    komSha3rawyLenght1=json["kom_sha3rawy_lenght1"];

    badnSize1 = json["badn_size1"];
    badnSize2 = json["badn_size2"];
    badnSize3 = json["badn_size3"];

    isDelliverd = json['is_delliverd'];
    address = json['address'];
    prize = json['prize'];
    amountPaid = json['amount_paid'];
    remainingAmount = json['Remaining_amount'];
    date = json['date'];
    numDresses = json['num_dresses'];
    length = json['length'];
    chestLength = json['chest_length'];
    ketfLength = json['ketf_length'];
    komLength = json['kom_length'];
    neck = json['neck'];
    handLength = json['hand_length'];
    kLength = json['k_length'];
    mLength = json['m_length'];
    details = json['details'];
    glab = json['glab'];
    yaqa = json['yaqa'];
    gayb = json['gayb'];
    ganb = json['ganb'];
    taqwera = json['taqwera'];
    kom = json['kom'];
    createdAt = json['created_at'];
    deliveryTime = json['delivery_time'];
    type = json['type'];
    additionalType1 = json['additional_type1'];
    additionalType2 = json['additional_type2'];
    fyberType = json['fyber_type'];
    quantity = json['quantity'];
    workerCost = json['worker_cost'];
    total = json['total'];
    image = json['image'];
    sId = json['_id'];
    sadr = json['sadr'];
    code = json['code'];

    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['sadr'] = this.sadr;
    data["kom_balady_lenght1"]=this.komBaladyLenght1;
    data["kom_balady_lenght2"]=this.komBaladyLenght2;
    data["kom_balady_lenght3"]=this.komBaladyLenght3;
    data["kom_balady_lenght4"]=this.komBaladyLenght4;

    data["kom_balady"]=this.komBalady;
    data["kom_sha3rawy"]=this.komSha3rawy;
    data['code'] = this.code;
    data["sadr_size"] = this.sadrSize;
    data["ganb_size"] = this.ganbSize;
    data["yaqa_size"] = this.yaqaSize;
    data["kom_size"] = this.komSize;
    data["glab_size"] = this.glabSize;
    data["taqwera_size"] = this.taqweraSize;
    data["gayb_size"] = this.gaybSize;
    data["k2_length"] = this.k2Length;
    data["hand2_length"] = this.hand2Length;
    data["dropp_taqwera3"] = this.droppTaqwera3;
    data["dropp_taqwera2"] = this.droppTaqwera2;
    data["dropp_taqwera1"] = this.droppTaqwera1;
    data["badn_size1"] = this.badnSize1;
    data["badn_size2"] = this.badnSize2;
    data["badn_size3"] = this.badnSize3;
    data["kom_sha3rawy_lenght3"]=this.komSha3rawyLenght3;
    data["kom_sha3rawy_lenght2"]=this.komSha3rawyLenght2;
    data["kom_sha3rawy_lenght1"]=this.komSha3rawyLenght1;
    data["kom_sha3rawy_lenght4"]=this.komSha3rawyLenght4;

    data['phone'] = this.phone;
    data['address'] = this.address;
    data['prize'] = this.prize;
    data['amount_paid'] = this.amountPaid;
    data['Remaining_amount'] = this.remainingAmount;
    data['date'] = this.date;
    data['num_dresses'] = this.numDresses;
    data['length'] = this.length;
    data['chest_length'] = this.chestLength;
    data['ketf_length'] = this.ketfLength;
    data['kom_length'] = this.komLength;
    data['neck'] = this.neck;
    data['hand_length'] = this.handLength;
    data['is_delliverd'] = this.isDelliverd;
    data['k_length'] = this.kLength;
    data['m_length'] = this.mLength;
    data['details'] = this.details;
    data['glab'] = this.glab;
    data['yaqa'] = this.yaqa;
    data['gayb'] = this.gayb;
    data['ganb'] = this.ganb;
    data['taqwera'] = this.taqwera;
    data['kom'] = this.kom;
    data['created_at'] = this.createdAt;
    data['delivery_time'] = this.deliveryTime;
    data['type'] = this.type;
    data['additional_type1'] = this.additionalType1;
    data['additional_type2'] = this.additionalType2;
    data['fyber_type'] = this.fyberType;
    data['quantity'] = this.quantity;
    data['worker_cost'] = this.workerCost;
    data['total'] = this.total;
    data['image'] = this.image;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
