#!/system/bin/sh
# تحسين أداء تعدد المهام من خلال تعديل إعدادات النظام

# إعدادات prop لتحسين تعدد المهام
resetprop ro.sys.fw.bg_apps_limit 32      # زيادة حد التطبيقات التي تعمل في الخلفية
resetprop ro.sys.fw.dex2oat_threads 4     # تحسين كفاءة جمع البيانات
resetprop ro.config.low_ram false         # تعطيل وضع الذاكرة المنخفضة

# ضبط إدارة الذاكرة لزيادة تعدد المهام
echo '2048' > /sys/module/lowmemorykiller/parameters/minfree     # تقليل القيم لضمان بقاء التطبيقات في الذاكرة

# تفعيل تحسينات للنواة لتحسين تعدد المهام
echo '0' > /proc/sys/vm/oom_kill_allocating_task   # تعطيل قتل التطبيقات بناءً على تخصيص الذاكرة
echo '10' > /proc/sys/vm/swappiness                # تقليل مقدار تبديل الذاكرة الافتراضية (Swap)

# تحسين عملية تخصيص الطاقة للتطبيقات التي تعمل في الخلفية
echo '1' > /sys/module/cpu_boost/parameters/input_boost_enabled

# إعادة تشغيل النظام
reboot