# encrypt data and read from stdin
# base64 is used and is so is xz. xz is used mainly to help hide file size and a little to make data smaller.
sha256() {
sha256sum | awk '{print $1}'
 }
case $1 in
encrypt)
xz -9 | openssl enc -aes-256-cbc -salt -in /dev/stdin -out /dev/stdout -k $(echo -n $2 | sha256) | base64
exit;;
decrypt)
base64 --decode | openssl enc -d -aes-256-cbc -salt -in /dev/stdin -out /dev/stdout -k $(echo -n $2 | sha256) | xz -d
exit;;
esac
echo Usage: $0 'encrypt|decrypt' KEY
echo Data is compressed and then turned into base64 for readability.
