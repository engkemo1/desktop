class Customer {
  String? code;
  String? userName;
  var remainingAmount;
  var customerAmount;
  String? address;
  String? phone;
  var length;
  var ketfLength;
  var komLength;
  var sadrLength;
  var neckLength;
  var handLength;
  var kabkLength;
  String? sId;
  int? iV;

  Customer(
      {this.code,
      this.userName,
        this.customerAmount,
      this.remainingAmount,
      this.address,
      this.phone,
      this.length,
      this.ketfLength,
      this.komLength,
      this.sadrLength,
      this.neckLength,
      this.handLength,
      this.kabkLength,
      this.sId,
      this.iV});

  Customer.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    userName = json['userName'];
    remainingAmount = json['Remaining_amount'];
    customerAmount = json['customer_amount'];

    address = json['address'];
    phone = json['phone'];
    length = json['length'];
    ketfLength = json['ketf_length'];
    komLength = json['kom_length'];
    sadrLength = json['sadr_length'];
    neckLength = json['neck_length'];
    handLength = json['hand_length'];
    kabkLength = json['kabk_length'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['userName'] = this.userName;
    data['Remaining_amount'] = this.remainingAmount;
    data['customer_amount'] = this.customerAmount;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['length'] = this.length;
    data['ketf_length'] = this.ketfLength;
    data['kom_length'] = this.komLength;
    data['sadr_length'] = this.sadrLength;
    data['neck_length'] = this.neckLength;
    data['hand_length'] = this.handLength;
    data['kabk_length'] = this.kabkLength;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
