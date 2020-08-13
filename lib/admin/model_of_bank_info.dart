


class ModelOfBankInfo{

  String selectedBank;
  bool currentAccount;
  bool salartAccount;
  bool studentAccount;
  bool saveingsAccount;
  bool foreignCurrencyAccount;
  bool depositLimitision;
  String depositLimitisionString;
  bool withdrowLimitision;
  String withdrowLimitisionString;
  bool interestLimitision;
  String interestLimitisionString;

  ModelOfBankInfo({
    this.selectedBank,
    this.currentAccount,
    this.salartAccount,
    this.studentAccount,
    this.saveingsAccount,
    this.foreignCurrencyAccount,
    this.depositLimitision,
    this.depositLimitisionString,
    this.withdrowLimitision,
    this.withdrowLimitisionString,
    this.interestLimitision,
    this.interestLimitisionString
  });

}