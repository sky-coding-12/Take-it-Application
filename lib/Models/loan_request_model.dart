class LoanRequestModel {
  int? loanRequestId;
  int? bankId;
  int? vendorId;
  int? loanAmount;
  int? loanInterest;
  String? status;
  int? duration;

  LoanRequestModel(
      {this.loanRequestId,
      this.bankId,
      this.vendorId,
      this.loanAmount,
      this.loanInterest,
      this.status,
      this.duration});

  LoanRequestModel.fromJson(Map<String, dynamic> json) {
    loanRequestId = json['loanRequestId'];
    bankId = json['bankId'];
    vendorId = json['vendorId'];
    loanAmount = json['loanAmount'];
    loanInterest = json['loanInterest'];
    status = json['status'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loanRequestId'] = this.loanRequestId;
    data['bankId'] = this.bankId;
    data['vendorId'] = this.vendorId;
    data['loanAmount'] = this.loanAmount;
    data['loanInterest'] = this.loanInterest;
    data['status'] = this.status;
    data['duration'] = this.duration;
    return data;
  }
}
