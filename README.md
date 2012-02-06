# Specta

A light-weight TDD / BDD framework for Objective-C & Cocoa.

### FEATURES

* RSpec-like BDD DSL
* Super quick and easy to set up
* Runs on top of OCUnit
* Excellent Xcode integration

### SCREENSHOT

![Specta Screenshot](http://github.com/petejkim/stuff/raw/master/images/specta-screenshot.png)

### SETUP

Use [CocoaPods](http://github.com/CocoaPods/CocoaPods)

```ruby
dependency 'Specta',      '~> 0.1.4'
# dependency 'Expecta',     '~> 0.1.3'   # expecta matchers
# dependency 'OCHamcrest',  '~> 1.6'     # hamcrest matchers
# dependency 'OCMock',      '~> 1.77.1'  # OCMock
```

or

1. Clone from Github.
2. Run `rake` in project root to build.
3. Add a "Cocoa/Cocoa Touch Unit Testing Bundle" target if you don't already have one.
4. Copy and add all header files in `products` folder to the Test target in your Xcode project.
5. For **OS X projects**, copy and add `libSpecta-macosx.a` in `products` folder to the Test target in your Xcode project.  
   For **iOS projects**, copy and add `libSpecta-ios-universal.a` in `products` folder to the Test target in your Xcode project.
6. Add the following to your test code.

```objective-c
#import "Specta.h"
```

Standard OCUnit matchers such as `STAssertEqualObjects` and `STAssertNil` work, but you probably want to add a nicer matcher framework - [Expecta](http://github.com/petejkim/expecta/) to your setup. Or if you really prefer, [OCHamcrest](https://github.com/jonreid/OCHamcrest) works fine too. Also, add a mocking framework: [OCMock](http://ocmock.org/).

## WRITING SPECS

```objective-c
#import "Specta.h"

SpecBegin(Thing)

describe(@"Thing", ^{
  beforeAll(^{
    // This is run once and only once before all of the examples
    // in this group and before any beforeEach blocks.
  });

  beforeEach(^{
    // This is run before each example.
  });

  it(@"should do stuff", ^{
    // This is an example block. Place your assertions here.
  });

  it(@"should do more stuff", ^{
    // ...
  });

  describe(@"Nested examples", ^{
    it(@"should do even more stuff", ^{
      // ...
    });
  });

  pending(@"pending example");

  pending(@"another pending example", ^{
    // ...
  });

  afterEach(^{
    // This is run after each example.
  });

  afterAll(^{
    // This is run once and only once after all of the examples
    // in this group and after any afterEach blocks.
  });
});

SpecEnd
```

* `beforeEach` and `afterEach` are also aliased as `before` and `after` respectively.
* `describe` is also aliased as `context`.
* `it` is also aliased as `example` and `specify`.
* Use `pending` or prepend `x` to `describe`, `context`, `example, `it`, and `specify` to mark examples or groups as pending.
* Do `#define SPT_CEDAR_SYNTAX` if you prefer to write `SPEC_BEGIN` and `SPEC_END` instead of `SpecBegin` and `SpecEnd`.

### FEATURES COMING SOON

* Shared Examples

### CONTRIBUTION GUIDELINES

* Please use only spaces and indent 2 spaces at a time.
* Please prefix instance variable names with a single underscore (`_`).
* Please prefix custom classes and functions defined in the global scope with `SPT`.

## LICENSE

Copyright (c) 2012 Peter Jihoon Kim. This software is licensed under the [MIT License](http://github.com/petejkim/specta/raw/master/LICENSE).

