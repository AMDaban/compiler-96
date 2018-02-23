Class Main {
    main() : Object {
        (let logger : Logger <- new Logger, 
        stackMachine : StackMachine <- (new StackMachine).init() in {
            logger.log(stackMachine.listen());
        })
    };
};