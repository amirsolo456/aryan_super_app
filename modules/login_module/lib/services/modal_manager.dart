import 'package:flutter/material.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Data/Auth/Login/dto.dart';

class ManagementPickerModal extends StatelessWidget {
  final LoginModuleResult result;
  final List<ManagementAccounts> accounts;
  final Function(ManagementAccounts) onAccountSelected;

  const ManagementPickerModal({
    super.key,
    required this.result,
    required this.accounts,
    required this.onAccountSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "انتخاب حساب مدیریت",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: accounts.isEmpty
                  ? Center(
                      child: Text(
                        "هیچ حسابی موجود نیست",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: accounts.length,
                      itemBuilder: (context, index) {
                        final account = accounts[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              account.managementAccountDesc ??
                                  account.managementAccountDesc ??
                                  "حساب مدیریت ${index + 1}",
                            ),
                            subtitle: account.managementAccountId != null
                                ? Text("ID: ${account.managementAccountId}")
                                : null,
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.pop(context);
                              onAccountSelected(account);
                            },
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("بستن"),
            ),
          ],
        ),
      ),
    );
  }
}
/*class ManagementPickerModal extends StatelessWidget {
  final LoginModuleResult result;
  final List<ManagementAccounts> accounts;
  final LoginBloc bloc;

  const ManagementPickerModal({
    super.key,
    required this.result,
    required this.accounts,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "انتخاب حساب مدیریت",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: accounts.isEmpty
                  ? Center(
                child: Text(
                  "هیچ حسابی موجود نیست",
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        account.managementAccountDesc ??
                            account.managementAccountDesc ??
                            account.managementAccountDesc ??
                            "حساب مدیریت ${index + 1}",
                      ),
                      subtitle: account.managementAccountId != null
                          ? Text("ID: ${account.managementAccountId}")
                          : null,
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pop(context);
                        final updatedResult = result.copyWith(
                          selectedAccount: account,
                        );

                        bloc.add(
                          LoginSuccessEvent(updatedResult),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("بستن"),
            ),
          ],
        ),
      ),
    );
  }
}*/

// 5. در صفحه اصلی که مودال را نشان می‌دهد:
