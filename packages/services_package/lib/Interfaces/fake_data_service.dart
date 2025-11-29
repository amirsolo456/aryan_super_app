// -------------------- Fake Data Service --------------------

import 'package:models_package/Data/Com/Person/dto.dart';
import 'package:models_package/Data/Auth/Menu/dto.dart' as menu;

class FakeDataService {
  static Response getFakePersons() {
    return Response(
      data: [
        ResponseData(
          personId: 1,
          fullName: "امیر سلیمانی",
          fatherName: "یاسر",
          nationalCode: "1234567890",
        ),
        ResponseData(
          personId: 2,
          fullName: "فاطمه رضایی",
          fatherName: "علی",
          nationalCode: "0987654321",
        ),
        ResponseData(
          personId: 3,
          fullName: "محمد احمدی",
          fatherName: "حسین",
          nationalCode: "1122334455",
        ),
        ResponseData(
          personId: 4,
          fullName: "سارا کریمی",
          fatherName: "مهدی",
          nationalCode: "2233445566",
        ),
        ResponseData(
          personId: 5,
          fullName: "علی احمدی",
          fatherName: "رحیم",
          nationalCode: "3344556677",
        ),
        ResponseData(
          personId: 6,
          fullName: "مریم رضایی",
          fatherName: "امید",
          nationalCode: "4455667788",
        ),
        ResponseData(
          personId: 7,
          fullName: "حسین محمدی",
          fatherName: "علی",
          nationalCode: "5566778899",
        ),
        ResponseData(
          personId: 8,
          fullName: "لیلا صادقی",
          fatherName: "حسین",
          nationalCode: "6677889900",
        ),
        ResponseData(
          personId: 9,
          fullName: "رضا کاظمی",
          fatherName: "جواد",
          nationalCode: "7788990011",
        ),
        ResponseData(
          personId: 10,
          fullName: "زهرا ملکی",
          fatherName: "حسن",
          nationalCode: "8899001122",
        ),
        ResponseData(
          personId: 11,
          fullName: "حمید رحمانی",
          fatherName: "سعید",
          nationalCode: "9900112233",
        ),
        ResponseData(
          personId: 12,
          fullName: "نگین صفوی",
          fatherName: "مهدی",
          nationalCode: "0011223344",
        ),
        ResponseData(
          personId: 13,
          fullName: "علی رضاپور",
          fatherName: "حسین",
          nationalCode: "1122334456",
        ),
        ResponseData(
          personId: 14,
          fullName: "فاطمه نوروزی",
          fatherName: "امیر",
          nationalCode: "2233445567",
        ),
        ResponseData(
          personId: 15,
          fullName: "مهدی کریمی",
          fatherName: "رضا",
          nationalCode: "3344556678",
        ),
        ResponseData(
          personId: 16,
          fullName: "سمانه احمدی",
          fatherName: "جواد",
          nationalCode: "4455667789",
        ),
        ResponseData(
          personId: 17,
          fullName: "رضا فراهانی",
          fatherName: "علی",
          nationalCode: "5566778890",
        ),
        ResponseData(
          personId: 18,
          fullName: "لیلا تهرانی",
          fatherName: "حسین",
          nationalCode: "6677889901",
        ),
        ResponseData(
          personId: 19,
          fullName: "سعید ملکی",
          fatherName: "مهدی",
          nationalCode: "7788990012",
        ),
        ResponseData(
          personId: 20,
          fullName: "مهسا کاظمی",
          fatherName: "امیر",
          nationalCode: "8899001123",
        ),
      ],
    );
  }
}

class FakeMenuDataService {
  static menu.Response getFakeMenu() {
    return menu.Response(
      data: [
        menu.ResponseData(
          menuId: 1,
          menuDesc: 'پیشخوان',
          appLink: '/dashboard',
        ),
        menu.ResponseData(
          menuId: 2,
          menuDesc: 'کاربران',
          subMenus: [
            menu.ResponseData(
              menuId: 21,
              menuDesc: 'لیست کاربران',
              appLink: '/users/list',
            ),
            menu.ResponseData(
              menuId: 22,
              menuDesc: 'نقش‌ها',
              subMenus: [
                menu.ResponseData(
                  menuId: 221,
                  menuDesc: 'مدیران',
                  appLink: '/users/roles/admins',
                ),
                menu.ResponseData(
                  menuId: 222,
                  menuDesc: 'کاربران عادی',
                  appLink: '/users/roles/regular',
                ),
              ],
            ),
            menu.ResponseData(
              menuId: 23,
              menuDesc: 'فعالیت اخیر',
              subMenus: [
                menu.ResponseData(
                  menuId: 231,
                  menuDesc: 'ورودها',
                  appLink: '/users/activity/logins',
                ),
                menu.ResponseData(
                  menuId: 232,
                  menuDesc: 'تغییرات',
                  subMenus: [
                    menu.ResponseData(
                      menuId: 2321,
                      menuDesc: 'رمز عبور',
                      appLink: '/users/activity/password-changes',
                    ),
                    menu.ResponseData(
                      menuId: 2322,
                      menuDesc: 'اطلاعات پروفایل',
                      appLink: '/users/activity/profile-updates',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        menu.ResponseData(
          menuId: 3,
          menuDesc: 'تنظیمات',
          subMenus: [
            menu.ResponseData(
              menuId: 31,
              menuDesc: 'پروفایل',
              appLink: '/settings/profile',
            ),
            menu.ResponseData(
              menuId: 32,
              menuDesc: 'امنیت',
              subMenus: [
                menu.ResponseData(
                  menuId: 321,
                  menuDesc: 'تغییر رمز',
                  appLink: '/settings/security/password',
                ),
                menu.ResponseData(
                  menuId: 322,
                  menuDesc: 'تأیید دومرحله‌ای',
                  appLink: '/settings/security/2fa',
                ),
              ],
            ),
          ],
        ),
        menu.ResponseData(
          menuId: 4,
          menuDesc: 'گزارش‌ها',
          subMenus: [
            menu.ResponseData(
              menuId: 41,
              menuDesc: 'گزارش فروش',
              appLink: '/reports/sales',
            ),
            menu.ResponseData(
              menuId: 42,
              menuDesc: 'گزارش کاربران',
              appLink: '/reports/users',
            ),
          ],
        ),
      ],
    );
  }
}
