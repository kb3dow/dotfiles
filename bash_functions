# from http://www.cyberciti.biz/faq/linux-random-password-generator/
genp() {
    local l=$1
        [ "$l" == "" ] && l=16
        tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}
