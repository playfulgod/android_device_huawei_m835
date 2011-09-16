#!/system/bin/sh
# Copyright (c) 2009, Code Aurora Forum. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Code Aurora nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

target=`getprop ro.product.device`
# /* < DTS2011042803187 wuzhihui 20110428 begin */
# M835 uses a seperate config for cpu.(480M etc)
huawei_board=`getprop ro.huawei.board`

#/* <DTS2011051802421 liuming 20110518 begin */
echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
#/* DTS2011051802421 liuming 20110518 end >*/
echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias

case "$huawei_board" in
    "M835")
        echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
        echo 25000 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
        echo 480000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        ;;
    *)
        echo 80 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
        echo 245760 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        ;;
esac
# /*<BU5D03701, JIALIN, 20100301, begin*/
#echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
# /* < DTS2010080902195 wanghao 20100809 begin */
#echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias
#echo 80 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
# /* DTS2010080902195 wanghao 20100809 end > */
#echo 245760 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
# /*BU5D03701, JIALIN, 20100301, end>*/
# /* DTS2011042803187 wuzhihui 20110428 end > */

#/* < DTS2010100901287 wuzhihui 20101009 begin */
/system/bin/hwvefs /data/hwvefs -o allow_other &
#/* DTS2010100901287 wuzhihui 20101009 end > */

case "$target" in
    "qsd8250_surf" | "qsd8250_ffa")
        value=`getprop persist.maxcpukhz`
        case "$value" in
            "")
                cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq >\
                /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
                ;;
            *)
                echo $value > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
                ;;
        esac
        ;;

esac
