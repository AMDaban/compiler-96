Class StackItem {
    data : String;
    next : StackItem;

    init(receivedData : String) : StackItem {
        {
            data <- receivedData;
            self;
        }
    };

    setNext(receivedNext : StackItem) : StackItem {
        {
            next <- receivedNext;
            self;
        }
    };

    data() : String {
        data
    };

    next() : StackItem {
        next
    };
};