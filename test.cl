Class Main {
    main() : Object {
        (let io : IO <- new IO in {
            io.out_string("Hello, world!!\  salam\fs");
            io.out_int(3333);
            io.out_string("\n");
        })
    };
    --sal
    (* (*salam*) *)

    foo() : Int {
        3
    };

    foo_2() : String {
        {
        (*"hello,  world\f!";*) "salam";
        (*"hello, world\f!"*)
        }
	};
};
--salam aslam
