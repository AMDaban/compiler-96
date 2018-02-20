Class Logger inherits IO {
    log(message : String) : SELF_TYPE {
        out_string(message.concat(" \n"))
    };
};