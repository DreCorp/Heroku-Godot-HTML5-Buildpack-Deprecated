#
function download_godot_headless() {
    #
    local VERSION=$1
    GODOT_HEADLESS_URL=https://downloads.tuxfamily.org/godotengine/${VERSION}/Godot_v${VERSION}-stable_linux_headless.64.zip
    
    #
    if [ ! -f $CACHE_DIR/godot_headless.64 ]; then
        #
        output_section "Downloading Godot Headless v$VERSION executable..."
        curl -s $GODOT_HEADLESS_URL -o godot-headless.zip || exit 1
        unzip -o godot-headless.zip
        cp Godot_v${VERSION}-stable_linux_headless.64 $CACHE_DIR/godot_headless.64
        touch "$CACHE_DIR/._sc_"
    else
        output_section "Using cached Godot v$VERSION Headless executable"
    fi
    #
    output_section "Godot Headless setup done"
}


#
function download_godot_templates() {
    #
    local VERSION=$1
    GODOT_TEMPLATES_URL=https://downloads.tuxfamily.org/godotengine/${VERSION}/Godot_v${VERSION}-stable_export_templates.tpz
    TEMPLATES_DEST="$CACHE_DIR/editor_data/templates/${VERSION}.stable"
    
    #
    if [ ! -f $TEMPLATES_DEST/webassembly_debug.zip ]; then
        output_section "Downloading Godot Templates..."
        curl -s $GODOT_TEMPLATES_URL -o godot-templates.zip || exit 1
        unzip -o godot-templates.zip
        mkdir -p $TEMPLATES_DEST
        cp templates/webassembly_debug.zip $TEMPLATES_DEST
        cp templates/webassembly_release.zip $TEMPLATES_DEST

    else
        output_section "Using cached Godot HTML5 Templates"
    fi
    
    # Godot export templates are stored at $CACHE_DIR/editor_data/templates/${VERSION}.stable
    output_section "Godot Templates setup done"
}

#
function export_godot_project() {
    #
    OUTPUT_DEST="$BUILD_DIR/dist"
    FILE_NAME="$OUTPUT_DEST/index.html"
    
    #
    output_section "Exporting Godot Project..."
    output_line "Target: '$FILE_NAME'"
    
    # create folders
    mkdir -p $OUTPUT_DEST
    # Export the project to HTML5 
    # (The project must have a HTML5 export template setup)
    # source: $BUILD_DIR/dist
    # destinations: $OUTPUT_FILE
    $CACHE_DIR/godot_headless.64 --path "$OUTPUT_DEST" --export "HTML5" "index.html" || exit 1
}
