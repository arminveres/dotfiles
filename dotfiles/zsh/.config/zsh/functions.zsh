function convert_heic_to_jpg () {
    for file in *.(heic|HEIC);
    do heif-convert $file ${file/%.(heic|HEIC)/.jpg};
    done
}

function git_update_project_in_dir() {
 for file in ./*/;
    do
        echo "$file" && \
        cd $file && \
        git pull && \
        cd -
    done
}

# set and change java versions
# just use -- sudo alternatives --config java

# find thermal info loc
function find_thermal_zone() {
    for i in /sys/class/hwmon/hwmon*/temp*_input;
        do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)";
    done
}


# Function to source files if they exist
function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

# add normal plugins
function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

# download plugins but do not source them => irregular plugins
function zsh_download_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

# Add completion plugins
function zsh_add_completion() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then 
        # For completions
            completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
            fpath+="$(dirname "${completion_file_path}")"
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
            fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
    fi
        completion_file="$(basename "${completion_file_path}")"
        if [ "$2" = true ] && compinit "${completion_file:1}"
}
