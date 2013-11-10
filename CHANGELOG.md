V0.2.1
======

* Workaround for Xcode truncating console output when tests run too quickly. [petejkim]

v0.2.0
======

* Added support for XCTest and dropped support for OCUnit (SenTestingKit). [petejkim]
* ARC [tonyarnold]
* Modern Objective-C syntax [tonyarnold]
* Fixed after hooks not running when an exception is raised in an example. [nerdyc]
* New nested custom reporter [nerdyc]

v0.1.11
=======

* Disable Async Testing when Specta is not compiled with Clang. [petejkim]
* Fixed failWithException: not passing thru to current test case. [rhgills]
* Fixed unused data dictionary crashing shared examples. [rhgills]
* Removed Warnings under LLVM GCC. [petejkim]
* Fixed release build not compiling due to implicitly synthesized properties. [kastiglione]

v0.1.10
=======

* Fixed Accessibility Inspector causing crash [wonga00]
* Fail when non-existent shared example is called [brow]

v0.1.9
======

* New Reporter [nerdyc]
* Focused Specs [nerdyc]
* Added PENDING macro for compatibility with Cedar-style pending specs. (Requires SPT\_CEDAR\_SYNTAX to be defined) [nerdyc]
* Xcode templates [nerdyc]
* Added Cedar-style global +beforeEach and +afterEach [petejkim]

v0.1.8
======

* Use atomic variables for async blocks [jspahrsummers]
* Fail instead of skipping when exceptions get thrown outside actual tests. [petejkim]
* itShouldBehaveLike should fail when called inside an it() block. [petejkim]

v0.1.7
======

* Async Testing [danpalmer]

v0.1.6
======

* Allow a custom subclass for test cases [joshabar]
* Xcode 4.4 fixes [jspahrsummers]
* Added a way to allow lazy evaluation of shared examples' context [petejkim]

v0.1.5
======

* Shared examples [petejkim]
* Sanitize description on exception [meiwin]

v0.1.4
======

* Pending specs [petejkim]
* Include SpectaTypes.h in the build output [strangemonad]

v0.1.3
======

* Fixed unexpected exceptions not being caught in iOS4 simulator [petejkim]
* Map unexpected exceptions to correct spec file [petejkim]

v0.1.2
======

* Fixed compiled example names being incorrectly generated [petejkim]

v0.1.1
======

* Prevented SPTSenTest class from running [petejkim]

v0.1.0
======

* First Release [petejkim]

