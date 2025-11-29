$projects = @(
    "packages\models_package",
    "packages\resources_package",
    "packages\services_package",
    "login_module",
    "erp_app",
    "container_app"
)

# دستور مشترک برای اجرا روی همه پروژه‌ها
function Run-CommandOnAllProjects([string]$command) {
    foreach ($proj in $projects) {
        Write-Host "============================"
        Write-Host "Running '$command' in $proj"
        Write-Host "============================"
        Push-Location $proj
        try {
            Invoke-Expression $command
        } catch {
            Write-Host "Error running command in $proj"
        }
        Pop-Location
    }
}

# ================================
# بخش کار با اسکریپت
# ================================

# 1️⃣ دریافت dependencies
Run-CommandOnAllProjects "flutter pub get"

# 2️⃣ اجرای تست‌ها (اختیاری)
# Run-CommandOnAllProjects "flutter test"

# 3️⃣ ساخت پروژه‌ها (مثال build apk برای shell_app)
# فقط shell_app را build می‌کنیم
Push-Location "container_app"
flutter build apk
Pop-Location

# 4️⃣ سایر دستورات مشترک می‌توانی اضافه کنی
# مثال:
# Run-CommandOnAllProjects "flutter pub outdated"
# Run-CommandOnAllProjects "flutter analyze"


# cd H:\projects\aryan_super_app\super_app || cd D:\Projects\super_app
# .\super_app.ps1
