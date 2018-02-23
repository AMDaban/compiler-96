Class StackMachine {
    logger : Logger;
    scanner : Scanner;
    integerHelper : IntegerHelper;
    stack: Stack;

    init() : StackMachine {
        {
            logger <- new Logger;
            scanner <- new Scanner;
            stack <- (new Stack).init();
            integerHelper <- new IntegerHelper;
            self;
        }
    };

    listen() : String {
        {
            (let isStopRead : Bool <- false, shouldStop : Bool <- false in {
                while isStopRead = false loop {
                    (let input : String <- scanner.read() in {
                        shouldStop <- checkAndReturnProperCommand(input).execute(stack);
                        if(shouldStop = true)
                        then
                            isStopRead <- true
                        else 
                            isStopRead <- false
                        fi;   
                    });
                } 
                pool;
            });

            "StackMachine halts successfully";
        }
    };

    checkAndReturnProperCommand(command : String) : Command {
        if(command = "")
        then
            new Command
        else    
            if(command = "x") 
            then
                new StopCommand
            else
                if(command = "+")
                then
                    new PlusCommand
                else
                    if(command = "s")
                    then
                        new SwapCommand
                    else
                        if(command = "e")
                        then
                            new EvaluationCommand
                        else
                            if(command = "d")
                            then
                                new DisplayCommand
                            else
                                if(integerHelper.isInteger(command))
                                then
                                    (new IntegerCommand).setAmount(command)
                                else
                                    {
                                        logger.log("StackMachine: command not found");
                                        new Command;
                                    }
                                fi
                            fi
                        fi
                    fi
                fi
            fi
        fi      
    };
};
