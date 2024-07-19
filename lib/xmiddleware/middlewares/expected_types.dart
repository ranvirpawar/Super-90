import 'dart:collection';

class ExpectedTypes {
  /*
  *   int id;
  String pcId;
  int empId;
  String date;
  String type;
  int status;
  dynamic statusChangedBy;
  String statusChangeByName;
  dynamic statusChangedAt;
  dynamic statusChangedRemark;
  int reRaiseAction;
  int isActive;
  dynamic remark;
  String createdAt;
  int createdBy;
  dynamic updatedAt;
  dynamic updatedBy;
  String employee;
  List<Expenses> expenses;
  double amountToBePaid;
  * */
  static List<Map<String, Type>> getPettyCashVoucherDetails = [
    {"coffee": Map, "brewing": Map},
    {"region": List, "country": Map},
    {
      'id': int,
      'name': String,
    },

    {
      'id': int,
      'company': String,
    },
    {
      'id': int,
      'name': String,
    },
    {"region": List, "country": Map},
    {
      'id': int,
      'company': String,
    },
    // {
    //   'id': int,
    //   'pc_id': String,
    //   'emp_id': int,
    //   'date': String,
    //   'type': String,
    //   'status': int,
    //   'status_changed_by': int,
    //   'status_changed_at': String,
    //   'payment_status': int,
    //   'payment_status_changed_by': int,
    //   'payment_status_changed_at': String,
    //   'status_changed_remark': String,
    //   're_raise_action': int,
    //   're_raise_action_user': int,
    //   'is_active': int,
    //   'remark': String,
    //   'created_at': String,
    //   'created_by': int,
    //   'updated_at': String,
    //   'updated_by': int,
    //   'amount_to_be_paid': int,
    //   'padm_posting': int,
    //   'email_sent': int,
    //   'is_raise': int,
    //   'employee': String,
    //   'expenses': List,
    //   'status_changed_by_name': String
    // },
    // {
    //   'id': int,
    //   'petty_cash_voucher_master_id': int,
    //   'petty_cash_expense_master_id': int,
    //   'amount': int,
    //   'is_active': int,
    //   'remark': String,
    //   'created_at': String,
    //   'created_by': int,
    //   'updated_at': String,
    //   'updated_by': String,
    //   'main_expense': String,
    //   'sub_expense': String,
    //   'account_head_padm': String,
    //   'attachments': List
    // } ,
    // {
    //   'attachment_name': String,
    //   'attachment_url': String,
    // },
    // {
    //   'id': int,
    //   'pc_id': String,
    //   'emp_id': int,
    //   'date': String,
    //   'type': String,
    //   'status': int,
    //   'status_changed_by': int,
    //   'status_changed_at': String,
    //   'payment_status': int,
    //   'payment_status_changed_by': int,
    //   'payment_status_changed_at': String,
    //   'status_changed_remark': String,
    //   're_raise_action': int,
    //   're_raise_action_user': int,
    //   'is_active': int,
    //   'remark': String,
    //   'created_at': String,
    //   'created_by': int,
    //   'updated_at': String,
    //   'updated_by': int,
    //   'amount_to_be_paid': int,
    //   'padm_posting': int,
    //   'email_sent': int,
    //   'is_raise': int,
    //   'employee': String,
    //   'expenses': List,
    //   'status_changed_by_name': String
    // },
    // {
    //   'id': int,
    //   'petty_cash_voucher_master_id': int,
    //   'petty_cash_expense_master_id': int,
    //   'amount': int,
    //   'is_active': int,
    //   'remark': String,
    //   'created_at': String,
    //   'created_by': int,
    //   'updated_at': String,
    //   'updated_by': String,
    //   'main_expense': String,
    //   'sub_expense': String,
    //   'account_head_padm': String,
    //   'attachments': List
    // } ,
    // // {
    //   'attachment_name': String,
    //   'attachment_url': String,
    // },
  ];

  static List<Function> fromJson = [
    (json) {
      // return GetPettyCashVoucherDetails.fromJson(json);
    },
  ];
}
