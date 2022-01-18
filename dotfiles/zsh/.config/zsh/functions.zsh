function convHeic () {
    for file in *.(heic|HEIC); 
    do heif-convert $file ${file/%.(heic|HEIC)/.jpg}; 
    done
}

# set and change java versions
function setjdk() {
  if [ $# -ne 0 ]; then
    removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
    if [ -n "${JAVA_HOME+x}" ]; then
      removeFromPath $JAVA_HOME
    fi
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
    export PATH=$JAVA_HOME/bin:$PATH
  fi
}
