#!/usr/bin/env bash

tmp_dir="/tmp/cliphist"
mkdir -p "$tmp_dir"

if [[ -n "$1" ]]; then
  cliphist decode <<<"$1" | wl-copy
  exit
fi

read -r -d '' prog <<EOF
/^[0-9]+\s<meta http-equiv=/ { next }
/\[ binary/ {
    if (match(\$0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp)) {
        file_path = "$tmp_dir/" grp[1] "." grp[3]
        if (system("[ -f " file_path " ]") != 0) {
            system("echo " grp[1] "\\\\\t | cliphist decode >" file_path)
        }
        print \$0"\0icon\x1f" file_path
        next
    }
}
1
EOF

cliphist list | gawk "$prog"
