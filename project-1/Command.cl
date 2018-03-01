Class Command {
    execute(stack: Stack) : Bool {
        false
    };
};

Class StopCommand inherits Command {
    execute(stack: Stack) : Bool {
        true
    };
};

Class PlusCommand inherits Command {
    execute(stack: Stack) : Bool {
        {
            stack.push("+");
            false;
        }
    };
};

Class SwapCommand inherits Command {
    execute(stack: Stack) : Bool {
        {
            stack.push("s");
            false;
        }
    };
};

Class DisplayCommand inherits Command {
    execute(stack: Stack) : Bool {
        {
            stack.print();
            false;
        }
    };
};

Class IntegerCommand inherits Command {
    amountToSave : String;

    execute(stack: Stack) : Bool {
        {
            stack.push(amountToSave);
            false;
        }
    };

    setAmount(amount : String) : IntegerCommand {
        {
            amountToSave <- amount;
            self;
        }
    };
};

Class EvaluationCommand inherits Command {
    execute(stack: Stack) : Bool {
        if(stack.size() = 0)
        then
            false
        else {
            (let integerHelper : IntegerHelper <- new IntegerHelper in {
                if(integerHelper.isInteger(stack.head()))
                then
                    false
                else
                    if(stack.head() = "s")
                    then {
                        stack.pop();
                        (let firstCommand : String <- stack.pop(), 
                        secondCommand : String <- stack.pop() in {
                            stack.push(firstCommand);
                            stack.push(secondCommand);
                        });

                        false;
                    }
                    else
                        if(stack.head() = "+")
                        then {
                            stack.pop();
                            (let firstOperand : Int <- integerHelper.stringToInteger(stack.pop()), 
                            secondOperand : Int <- integerHelper.stringToInteger(stack.pop()) in {
                                stack.push(integerHelper.integerToString(firstOperand + secondOperand));
                            });

                            false;
                        }
                        else {
                            "Never happens";
                            false;
                        }
                        fi
                    fi
                fi;    
            });
        }
        fi
    };
};