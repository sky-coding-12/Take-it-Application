class BankLoanModel {
  int? bankLoanId;
  int? bankId;
  int? vendorId;
  int? duration;
  int? loanAmount;
  int? interestRate;

  BankLoanModel(
      {this.bankLoanId,
      this.bankId,
      this.vendorId,
      this.duration,
      this.loanAmount,
      this.interestRate});

  BankLoanModel.fromJson(Map<String, dynamic> json) {
    bankLoanId = json['bankLoanId'];
    bankId = json['bankId'];
    vendorId = json['vendorId'];
    duration = json['duration'];
    loanAmount = json['loanAmount'];
    interestRate = json['interestRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankLoanId'] = this.bankLoanId;
    data['bankId'] = this.bankId;
    data['vendorId'] = this.vendorId;
    data['duration'] = this.duration;
    data['loanAmount'] = this.loanAmount;
    data['interestRate'] = this.interestRate;
    return data;
  }
}
