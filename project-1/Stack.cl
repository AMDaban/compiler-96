Class Stack {
    firstNode : StackItem;
    size : Int;
    logger : Logger;

    init() : Stack { 
        {
            size <- 0;
            logger <- new Logger;
            self;
        }
    };

    size() : Int { size };

    head() : String { 
        if(size = 0)
        then {
            logger.log("Error in head() method : stack is empty");
            abort();
            firstNode.data();
        } else {
            firstNode.data();
        }
        fi
    };
    
    push(receivedData : String) : Stack {
        (let newStackItem : StackItem <- (new StackItem).init(receivedData) in {
            newStackItem.setNext(firstNode);
            firstNode <- newStackItem;
            size <- size + 1;
            self;
        })
    };

    pop() : String {
        if(size = 0)
        then {
            logger.log("Error in pop() method: stack is empty");
            abort();
            "";
        } else {
            (let commandToPop : String <-head() in {
                firstNode <- firstNode.next();
                size <- size - 1;
                commandToPop;
            });
        }
        fi
    };

    print() : Stack {
        {
            logger.log("Stack : ");

            if(size = 0)
            then {
                logger.log("\tstack is empty");
            } else {
                logger.log("[");

                (let stackitem : StackItem <- firstNode in {
                    while (isvoid stackitem) = false loop {
                        logger.log("\t".concat(stackitem.data().concat(
                            if(isvoid stackitem.next())
                            then "" else "," fi
                        )));
                        stackitem <- stackitem.next();
                    }
                    pool;
                });

                logger.log("]");
            }
            fi;

            self;
        }
    };
};