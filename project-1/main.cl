Class Main {
    main() : Object {
        (let logger : Logger <- new Logger, 
        stack : Stack <- (new Stack).init() in {
            stack.push("1");
            stack.push("2");
            stack.push("3");
            stack.print();
            logger.log(stack.head());
            stack.pop();
            stack.pop();
            stack.print();
        })
    };
};