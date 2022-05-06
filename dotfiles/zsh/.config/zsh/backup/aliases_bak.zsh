# OS Specific Aliases
case "$(uname -s)" in

Darwin)
    # echo 'Mac OS X'
    alias ls='ls -G'
    ;;

Linux)
    alias ls='ls --color=auto'
    ;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
    # echo 'MS Windows'
    ;;
*)
    # echo 'Other OS'
    ;;
    esac
