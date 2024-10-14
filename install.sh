#!/system/bin/sh
# SmartMultiTask@Alex - سكربت التثبيت

# تأكد من أن السكربت يعمل بصلاحيات الروت
if [ "$(id -u)" -ne 0 ]; then
    echo "يجب تشغيل هذا السكربت بصلاحيات الروت!"
    exit 1
fi

# مسار تخزين النسخة الاحتياطية للإعدادات الأصلية
ORIGINAL_DIR="/data/local/tmp/smartmultitask_backup"

# إنشاء المجلد إذا لم يكن موجودًا
mkdir -p "$ORIGINAL_DIR"

# أخذ نسخة احتياطية من الإعدادات الأصلية
echo "*******************************"
echo "أخذ نسخة احتياطية من الإعدادات الأصلية..."
echo "*******************************"

# نسخ الإعدادات الحالية إلى المجلد الاحتياطي
getprop ro.sys.fw.bg_apps_limit > "$ORIGINAL_DIR/bg_apps_limit"
getprop ro.sys.fw.dex2oat_threads > "$ORIGINAL_DIR/dex2oat_threads"
getprop ro.config.low_ram > "$ORIGINAL_DIR/low_ram"
cat /sys/module/lowmemorykiller/parameters/minfree > "$ORIGINAL_DIR/minfree"
cat /proc/sys/vm/oom_kill_allocating_task > "$ORIGINAL_DIR/oom_kill_allocating_task"
cat /proc/sys/vm/swappiness > "$ORIGINAL_DIR/swappiness"
cat /sys/module/cpu_boost/parameters/input_boost_enabled > "$ORIGINAL_DIR/input_boost_enabled"

# تحسين أداء تعدد المهام
echo "*******************************"
echo "تثبيت تحسينات SmartMultiTask..."
echo "*******************************"

# إعدادات prop لتحسين تعدد المهام
resetprop ro.sys.fw.bg_apps_limit 32      # زيادة حد التطبيقات في الخلفية
resetprop ro.sys.fw.dex2oat_threads 4     # تحسين كفاءة جمع البيانات
resetprop ro.config.low_ram false         # تعطيل وضع الذاكرة المنخفضة

# ضبط إدارة الذاكرة
echo '2048' > /sys/module/lowmemorykiller/parameters/minfree

# تحسينات للنواة
echo '0' > /proc/sys/vm/oom_kill_allocating_task   # تعطيل قتل التطبيقات
echo '10' > /proc/sys/vm/swappiness                # تقليل تبديل الذاكرة الافتراضية

# تخصيص الطاقة
echo '1' > /sys/module/cpu_boost/parameters/input_boost_enabled

# إنهاء التثبيت بنجاح
echo "*******************************"
echo "تم تثبيت SmartMultiTask@Alex بنجاح!"
echo "*******************************"