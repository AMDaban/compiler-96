Class Logger inherits IO {
    log(message : String) : SELF_TYPE {
        out_string(message.concat(" \n"))
    };

    logInt(numberToLog : Int) : SELF_TYPE {
        {
            out_int(numberToLog);
            out_string(" \n");
        }
    };
};