class LoanOfferModel {
  int? loanOfferId;
  int? bankId;
  int? vendorId;
  int? loanAmount;
  int? loanInterest;
  String? status;
  int? duration;

  LoanOfferModel(
      {this.loanOfferId,
        this.bankId,
        this.vendorId,
        this.loanAmount,
        this.loanInterest,
        this.status,
        this.duration});

  LoanOfferModel.fromJson(Map<String, dynamic> json) {
    loanOfferId = json['loanOfferId'];
    bankId = json['bankId'];
    vendorId = json['vendorId'];
    loanAmount = json['loanAmount'];
    loanInterest = json['loanInterest'];
    status = json['status'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loanOfferId'] = this.loanOfferId;
    data['bankId'] = this.bankId;
    data['vendorId'] = this.vendorId;
    data['loanAmount'] = this.loanAmount;
    data['loanInterest'] = this.loanInterest;
    data['status'] = this.status;
    data['duration'] = this.duration;
    return data;
  }
}
