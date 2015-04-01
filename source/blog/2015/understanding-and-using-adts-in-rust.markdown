---
title: Understanding and Using ADTs in Rust
date: 2015/03/30
author: Jason
tags: Rust, Algebraic Data Types
---

The concept of ADTs (Algebraic Data Type) took me a while to wrap my head around. I come from a Python background where ADTs are not a thing. When I finally figured out what was going on in ADT-land my growing comprehension of Rust-lang sort of snapped into place.

Let's explore ADT's using everyone's favorite coding example: [FizzBuzz](https://en.wikipedia.org/wiki/Fizz_buzz).

#### It Starts with an Enum

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


#### A function that returns one type but contains many types


```rust
fn fizzer(num: isize)-> FizzedEnum {
    if num % 15 == 0     { FizzedEnum::FizzBuzz }
    else if num % 5 == 0 { FizzedEnum::Fizz }
    else if num % 3 == 0 { FizzedEnum::Buzz }
    else                 { FizzedEnum::Int(num) }
}
```

Determining which FizzedEnum is returned from `fizzer()` follows the rules of FizzBuzz.

The above function **returns one type**, FizzedEnum, which **can be in
only one of the states** FizzBuzz, Fizz, Buzz, or Int. While the
first three members of the enum FizzedEnum have no contents, the
fourth member, Int, wraps an integer of type `isize`.

This is a **VERY IMPORTANT** point: The state of the
resulting FizzedEnum is returned by this function. This resulting FizzedEnum type carries
information about its own state. **If the FizzedEnum is in the 'Int' state
it also carries the value of an integer**.

**Using this principle one may create functions that are capable of returning Enums that "carry" any type of data . This is the crux on which the principle of enums exists. This is their purpose.**

#### Matching on an Enum

Let's use our enum within the `main()` function.

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

Within `main()` we iterate through a range of numbers between 1 and 25 (exclusive). On each iteration we:

1. pass the variable num into the fizzer function
2. use Rust’s match statement to branch according to the state of the result
3. `println!()` the appropriate message

Notice that the match statement above required no underscore/catch-all clause to compile. When matching the variable 'result' (which is of type FizzedEnum) it can only be in one of four states FizzBuzz, Fizz, Buzz, or Int. The match statement in Rust must be exhaustive, and this one is.

#### Conclusion

You should have a pretty good understanding of ADTs in rust now. If you're still unsure, drop us a line and we will dive deeper in our next article. Thanks for reading.

[Try it in the Rust playground](http://is.gd/OElt98)
