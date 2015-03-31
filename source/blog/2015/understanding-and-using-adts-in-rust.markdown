---
title: Understanding and Using ADTs in Rust
date: 2015/03/30
author: Jason
tags: Rust, Algebraic Data Types
---
Dear Reader,

Have you ever had any of these thoughts or similar thoughts?

> "What are Algebraic Data Types? How do they work?"

> "Oh please, please, please don't let my boss ask me about ADTs;
 I don't want to look foolish."

If so, you are in luck.

This is a description of what an ADT is and how to use it.

I decided to use FizzBuzz as an example:


```rust

    /*
    This is an enum. In Rust, an enum is a type which can only
    be in one of a finite category of states; the states with which
    the enum was defined.

    Each of these states may or may not "wrap" an already existent type.
    For instance, a variable that is of the type FizzedEnum can be in 
    the one of the following states: FizzBuzz, Fizz, Buzz, or Int(isize).
    In the case of Int(isize), the FizzedEnum is in a state that wraps
    an integer of type isize.
    */
    enum FizzedEnum {
        FizzBuzz,
        Fizz,
        Buzz,
        Int(isize),
    }

    /* 
    This function returns one type, FizzedEnum, which can be in
    only one of the states FizzBuzz, Fizz, Buzz, or Int. While the
    first three members of the enum FizzedEnum have no contents the
    fourth member, Int, wraps an integer of type isize.

    The logic for which category of FizzedEnum is returned is
    pretty obvious and requires no explanation (this is FizzBuzz for
    goodess sake).
    */
    fn fizzer(num: isize)-> FizzedEnum {
        if num % 15 == 0     { FizzedEnum::FizzBuzz }
        else if num % 5 == 0 { FizzedEnum::Fizz }
        else if num % 3 == 0 { FizzedEnum::Buzz }
        else                 { FizzedEnum::Int(num) }
    }
     
     
    /*
    This is the main function. The main function is executed when
    the Rust binary is executed. In main() we iterate through a 
    range of numbers between 1 and 25. On each iteration we pass
    the number (num) into fizzer() then use Rust's match statement
    to take the appropriate action (a branch) for each state that
    has been returned to the result variable.
    */
    fn main() {
        for num in 1..25 {
            let result = fizzer(num);
            match result {
                FizzedEnum::FizzBuzz  => println!("FizzBuzz"),
                FizzedEnum::Fizz      => println!("Fizz"),
                FizzedEnum::Buzz      => println!("Buzz"),
                FizzedEnum::Int(x)    => println!("{:?}", x),
            }
        }
    }
    /*
    Also of note: The match statement above required no
    underscore/catch-all clause to compile. When matching the variable
    'result' (which is of type FizzedEnum) it can only be in one of four
    states FizzBuzz, Fizz, Buzz, or Int. 
    */
```

I really hope this example has helped you understand the use case and purpose of ADTs.

-Jason


> "Jason, this example is overly complex. You could have just used
> println! in the fizzer function."
-Some Sir

>"I know, but the point was to show off how to use ADTs while still
> accomplishing nothing useful. Good day, sir."
-Jason 