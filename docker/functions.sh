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

# Handle options
while getopts f FLAG; do
  case $FLAG in
    f)
      export ENFORCE_IMAGE_BUILD=1
      ;;
    \?) #unrecognized option - show help
      echo "Option -$OPTARG not allowed."
      exit 1
      ;;
  esac
done
