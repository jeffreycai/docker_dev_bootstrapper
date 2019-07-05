log() {
  msg=$1
  echo " - ${msg}"
}
header() {
  msg=$1
  echo ""
  echo "======================"
  echo "* ${msg} *"
  echo "======================"
}