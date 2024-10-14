#!/system/bin/sh
# SmartMultiTask@Alex - سكربت إلغاء التثبيت الذكي

# مسار تخزين النسخة الاحتياطية للإعدادات الأصلية
ORIGINAL_DIR="/data/local/tmp/smartmultitask_backup"

# التحقق مما إذا كانت النسخة الاحتياطية موجودة
if [ -d "$ORIGINAL_DIR" ]; then
  echo "*******************************"
  echo "استعادة الإعدادات الأصلية..."
  echo "*******************************"
  
  # استعادة إعدادات prop الأصلية
  resetprop ro.sys.fw.bg_apps_limit "$(cat "$ORIGINAL_DIR/bg_apps_limit")"
  resetprop ro.sys.fw.dex2oat_threads "$(cat "$ORIGINAL_DIR/dex2oat_threads")"
  resetprop ro.config.low_ram "$(cat "$ORIGINAL_DIR/low_ram")"

  # استعادة إعدادات إدارة الذاكرة
  echo "$(cat "$ORIGINAL_DIR/minfree")" > /sys/module/lowmemorykiller/parameters/minfree

  # استعادة إعدادات النواة
  echo "$(cat "$ORIGINAL_DIR/oom_kill_allocating_task")" > /proc/sys/vm/oom_kill_allocating_task
  echo "$(cat "$ORIGINAL_DIR/swappiness")" > /proc/sys/vm/swappiness

  # استعادة إعدادات الطاقة
  echo "$(cat "$ORIGINAL_DIR/input_boost_enabled")" > /sys/module/cpu_boost/parameters/input_boost_enabled

  echo "*******************************"
  echo "تمت استعادة الإعدادات الأصلية بنجاح!"
  echo "*******************************"
else
  echo "لا توجد إعدادات احتياطية لاستعادتها. لم يتم تطبيق أي تغييرات."
fi

# حذف مجلد النسخة الاحتياطية
rm -rf "$ORIGINAL_DIR"

# إعادة تشغيل النظام
reboot