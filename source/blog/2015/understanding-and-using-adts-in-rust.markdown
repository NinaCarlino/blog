---
title: Understanding and Using ADTs in Rust
date: 2015/03/30
author: Jason
tags: Rust, Algebraic Data Types
---

Have you ever had any of these thoughts or similar thoughts?

> "What are Algebraic Data Types? How do they work?"

> "Oh please, please, please don't let my boss ask me about ADTs;
> I don't want to look foolish."

> "I've read everything I can about ADTs and it's just not clicking"

If so, you are in luck.

I have had these thoughts and once I figured out what was going on
in ADT-land my comprehension of the entire Rust language kind of 
snapped into place for me.

This is a description of what an ADT (Algebraic Data Type) is and how to use it. 

I decided to use FizzBuzz as an example.

#### An enum

```rust
enum FizzedEnum {
    FizzBuzz,
    Fizz,
    Buzz,
    Int(isize),
}
```

This is an enum. Enums are Rust's ADT.

In Rust, an enum is a **type** which can only be in **one of a finite category of states**; the states with which the enum was defined.

Each of these states may or may not "wrap" an already existent type. For instance, a variable that is of the type FizzedEnum can be in the one of the following states:

+ FizzBuzz
+ Fizz
+ Buzz
+ Int(isize)

In the case of Int(isize), the FizzedEnum is in a state that wraps an integer of type isize.


#### A function that returns one type that can be many types


```rust 
fn fizzer(num: isize)-> FizzedEnum {
    if num % 15 == 0     { FizzedEnum::FizzBuzz }
    else if num % 5 == 0 { FizzedEnum::Fizz }
    else if num % 3 == 0 { FizzedEnum::Buzz }
    else                 { FizzedEnum::Int(num) }
}
```

The above function **returns one type**, FizzedEnum, which **can be in
only one of the states** FizzBuzz, Fizz, Buzz, or Int. While the
first three members of the enum FizzedEnum have no contents the
fourth member, Int, wraps an integer of type isize.

This is a **very important point**: From this function the state of the
resulting FizzedEnum is returned. This resulting FizzedEnum type carries
information about its own state. **If the FizzedEnum is in the 'Int' state
it also carries the value of an integer**. 

**Using this principle one may create functions that are capable of returning Enums that "carry" any type of data. This is the very crux on which the principle of enums exists. This is their purpose.**

The logic for which category of FizzedEnum is returned is
pretty obvious and requires no explanation (this is FizzBuzz for
goodess sake).


#### Matching on an Enum

This is the main function. The main function is executed when
the Rust binary is executed. 

```rust
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
```

In main() we iterate through a range of numbers between 1 and 25. On each iteration we pass the number (num) into fizzer() then use Rust's match statement to take the appropriate action (a branch) for each state that has been returned to the result variable.

Notice that the match statement above required no underscore/catch-all clause to compile. When matching the variable 'result' (which is of type FizzedEnum) it can only be in one of four states FizzBuzz, Fizz, Buzz, or Int. 

##### Conclusion

TL;DR - Just read the bold parts. If you're clever enough it might make some sense.

I really hope this example has helped you understand the use case and purpose of ADTs. Here is [a gist that can be copied-pasted-compiled-and-run](https://gist.github.com/elbow-jason/0fdea26fa4aad95e1098#file-gistfile1-rs).

> "Jason, this example is overly complex. You could have just used
> println! in the fizzer function."
-Some Sir

>"I know, but the point was to show off how to use ADTs while still
> accomplishing nothing useful. Good day, sir."
-Jason 