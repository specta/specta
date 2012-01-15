# Expecta

A Matcher Framework for Objective-C/Cocoa

## INTRODUCTION

The main advantage of using Expecta over other matcher frameworks is that you do not have to specify the data types. Also, the syntax of Expecta matchers is much more readable and does not suffer from parenthesitis. If you have used [Jasmine](http://pivotal.github.com/jasmine/) before, you will feel right at home!

**OCHamcrest**

```objective-c
assertThat(@"foo", is(equalTo(@"foo")));
assertThatUnsignedInteger(foo, isNot(equalToUnsignedInteger(1)));
assertThatBool([bar isBar], is(equalToBool(YES)));
assertThatDouble(baz, is(equalToDouble(3.14159)));
```

vs.

**Expecta**

```objective-c
expect(@"foo").toEqual(@"foo");
expect(foo).Not.toEqual(1);
expect([bar isBar]).toEqual(YES);
expect(baz).toEqual(3.14159);
```

## SETUP

Use [CocoaPods](https://github.com/CocoaPods/CocoaPods)

```ruby
dependency 'Expecta', '~> 0.1.2'
```

or

1. Clone from Github.
2. Run `rake` in project root to build.
3. Copy and add all header files in `products` folder to the Spec/Test target in your Xcode project.
4. For **OS X projects**, copy and add `libExpecta-macosx.a` in `products` folder to the Spec/Test target in your Xcode project.  
   For **iOS projects**, copy and add `libExpecta-ios-universal.a` in `products` folder to the Spec/Test target in your Xcode project.
5. Add `-ObjC` to the "Other Linker Flags" build setting for the Spec/Test target in your Xcode project.
6. Add the following to your test code.

```objective-c
#define EXP_SHORTHAND
#import "Expecta.h"
```

If `EXP_SHORTHAND` is not defined, expectations must be written with `EXP_expect` instead of `expect`.

Expecta is framework-agnostic. It works well with OCUnit (SenTestingKit) and OCUnit-compatible test frameworks such as [Specta](http://github.com/petejkim/specta/), [GHUnit](http://github.com/gabriel/gh-unit/) and [GTMUnit](http://code.google.com/p/google-toolbox-for-mac/). Expecta also supports [Cedar](http://pivotal.github.com/cedar/).

## BUILT-IN MATCHERS

>`expect(x).toEqual(y);` compares objects or primitives x and y and passes if they are identical (==) or equivalent (isEqual:).
>
>`expect(x).toBeIdenticalTo(y);` compares objects x and y and passes if they are identical and have the same memory address.
>
>`expect(x).toBeNil();` passes if x is nil.
>
>`expect(x).toBeTruthy();` passes if x evaluates to true (non-zero).
>
>`expect(x).toBeFalsy();` passes if x evaluates to false (zero).
>
>`expect(x).toContain(y);` passes if an instance of NSArray or NSString x contains y.
>
>`expect(x).toBeInstanceOf([Foo class]);` passes if x is an instance of a class Foo.
>
>`expect(x).toBeKindOf([Foo class]);` passes if x is an instance of a class Foo or if x is an instance of any class that inherits from the class Foo.
>
>`expect([Foo class]).toBeSubclassOf([Bar class]);` passes if the class Foo is a subclass of the class Bar or if it is identical to the class Bar. Use toBeKindOf() for class clusters.
>
>`expect(x).toBeLessThan(y);`
>
>`expect(x).toBeLessThanOrEqualTo(y);`
>
>`expect(x).toBeGreaterThan(y);`
>
>`expect(x).toBeGreaterThanOrEqualTo(y);`
>
>`expect(x).toBeInTheRangeOf(y,z);`

**More matchers are coming soon!**

## INVERTING MATCHERS

Every matcher's criteria can be inverted by prepending `.Not`: (It is with a capital `N` because `not` is a keyword in C++.)

>`expect(x).Not.toEqual(y);` compares objects or primitives x and y and passes if they are *not* equivalent.

## ASYNCHRONOUS TESTING

Every matcher can be made to perform asynchronous testing by prepending `.isGoing` or `.isNotGoing`:

>`expect(x).isGoing.toBeNil();` passes if x becomes nil before the timeout.

Default timeout is 1.0 second. This setting can be changed by calling `[Expecta setAsynchronousTestTimeout:x]`, where x is the desired timeout.

## WRITING NEW MATCHERS

Writing a new matcher is easy with special macros provided by Expecta. Take a look at how `.toBeKindOf()` matcher is defined:

`EXPMatchers+toBeKindOf.h`

```objective-c
#import "Expecta.h"

EXPMatcherInterface(toBeKindOf, (Class expected));
// 1st argument is the name of the matcher function
// 2nd argument is the list of arguments that may be passed in the function call.
// Multiple arguments are fine. (e.g. (int foo, float bar))

#define toBeAKindOf toBeKindOf
```

`EXPMatchers+toBeKindOf.m`

```objective-c
#import "EXPMatchers+toBeKindOf.h"

EXPMatcherImplementationBegin(toBeKindOf, (Class expected)) {
  BOOL actualIsNil = (actual == nil);
  BOOL expectedIsNil = (expected == nil);

  prerequisite(^BOOL{
    return !(actualIsNil || expectedIsNil);
    // Return `NO` if matcher should fail whether or not the result is inverted using `.Not`.
  });

  match(^BOOL{
    return [actual isKindOfClass:expected];
    // Return `YES` if the matcher should pass, `NO` if it should not.
    // The actual value/object is passed as `actual`.
    // Please note that primitive values will be wrapped in NSNumber/NSValue.
  });

  failureMessageForTo(^NSString *{
    if(actualIsNil) return @"the actual value is nil/null";
    if(expectedIsNil) return @"the expected value is nil/null";
    return [NSString stringWithFormat:@"expected: a kind of %@, "
                                       "got: an instance of %@, which is not a kind of %@",
                                       [expected class], [actual class], [expected class]];
    // Return the message to be displayed when the match function returns `YES`.
  });

  failureMessageForNotTo(^NSString *{
    if(actualIsNil) return @"the actual value is nil/null";
    if(expectedIsNil) return @"the expected value is nil/null";
    return [NSString stringWithFormat:@"expected: not a kind of %@, "
                                       "got: an instance of %@, which is a kind of %@",
                                       [expected class], [actual class], [expected class]];
    // Return the message to be displayed when the match function returns `NO`.
  });
}
EXPMatcherImplementationEnd
```

## CONTRIBUTION

You can find the public Tracker project [here](https://www.pivotaltracker.com/projects/323267).

### CONTRIBUTION GUIDELINES

* Please use only spaces and indent 2 spaces at a time.
* Please prefix instance variable names with a single underscore (`_`).
* Please prefix custom classes and functions defined in the global scope with `EXP`.

### CONTRIBUTORS

* [kseebaldt](https://github.com/kseebaldt)
* [akitchen](https://github.com/akitchen)
* [joncooper](https://github.com/joncooper)
* [twobitlabs](https://github.com/twobitlabs)

## LICENSE

Copyright (c) 2011-2012 Peter Jihoon Kim. This software is licensed under the [MIT License](http://github.com/petejkim/expecta/raw/master/LICENSE).

