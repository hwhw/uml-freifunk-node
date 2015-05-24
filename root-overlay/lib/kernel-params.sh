read_kernel_param() {
    case "$1" in *?=?*) export $1;; esac
    shift 1
    [ -z "$1" ] || read_kernel_param $@
}

read_kernel_param $(cat /proc/cmdline)
