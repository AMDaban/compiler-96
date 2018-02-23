Class IntegerHelper {
    isInteger(command : String) : Bool {
        (let isNumber : Bool <- true, 
        length : Int <- command.length(), 
        counter : Int <- 0 in {
            while (counter = length) = false loop {
                if(isDigit(command.substr(counter, 1)) = false)
                then
                    isNumber <- false
                else
                    "Useless else!"
                fi;        

                counter <- counter + 1;
            }
            pool;

            isNumber;
        })
    };

    isDigit(character : String) : Bool {
	    if character = "1" then true else
	    if character = "2" then true else
        if character = "0" then true else
        if character = "3" then true else
        if character = "4" then true else
        if character = "5" then true else
        if character = "6" then true else
        if character = "7" then true else
        if character = "8" then true else
        if character = "9" then true else
            false
        fi fi fi fi fi fi fi fi fi fi
    };

    characterToInteger(character : String) : Int {
	    if character = "0" then 0 else
    	if character = "1" then 1 else
	    if character = "2" then 2 else
        if character = "3" then 3 else
        if character = "4" then 4 else
        if character = "5" then 5 else
        if character = "6" then 6 else
        if character = "7" then 7 else
        if character = "8" then 8 else
        if character = "9" then 9 else
            { abort(); 0; }
        fi fi fi fi fi fi fi fi fi fi
    };

    stringToInteger(string : String) : Int {
        if string.length() = 0 then 0 else
	    if string.substr(0,1) = "-" then ~stringToIntegerHelper(string.substr(1,string.length()-1)) else
        if string.substr(0,1) = "+" then stringToIntegerHelper(string.substr(1,string.length()-1)) else
            stringToIntegerHelper(string)
        fi fi fi
    };

    stringToIntegerHelper(string : String) : Int {
	    (let int : Int <- 0 in {	
            (let j : Int <- string.length() in
	            (let i : Int <- 0 in
		            while i < j loop
			        {
			            int <- int * 10 + characterToInteger(string.substr(i,1));
			            i <- i + 1;
			        }
		            pool
		        )
	        );
            int;
	    })
    };

    integerToCharacter(integer : Int) : String {
        if integer = 0 then "0" else
        if integer = 1 then "1" else
        if integer = 2 then "2" else
        if integer = 3 then "3" else
        if integer = 4 then "4" else
        if integer = 5 then "5" else
        if integer = 6 then "6" else
        if integer = 7 then "7" else
        if integer = 8 then "8" else
        if integer = 9 then "9" else
	        { abort(); ""; }
        fi fi fi fi fi fi fi fi fi fi
    };

    integerToString(integer : Int) : String {
	    if integer = 0 then "0" else 
        if 0 < integer then integetToStringHelper(integer) else
          "-".concat(integetToStringHelper(integer * ~1)) 
        fi fi
    };

    integetToStringHelper(integer : Int) : String {
        if integer = 0 then "" else 
	    (let next : Int <- integer / 10 in
		    integetToStringHelper(next).concat(integerToCharacter(integer - next * 10))
	    )
        fi
    };
};