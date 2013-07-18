v0.1.11
=======

* Disable Async Testing when Specta is not compiled with Clang.
* Fixed failWithException: not passing thru to current test case. [rhgills]
* Fixed unused data dictionary crashing shared examples. [rhgills]
* Removed Warnings under LLVM GCC.
* Fixed release build not compiling due to implicitly synthesized properties. [kastiglione]

v0.1.10
=======

* Fixed Accessibility Inspector causing crash[wonga00]
* Fail when non-existent shared example is called[brow]

v0.1.9
======

* New Reporter [nerdyc]
* Focused Specs [nerdyc]
* Added PENDING macro for compatibility with Cedar-style pending specs. (Requires SPT\_CEDAR\_SYNTAX to be defined) [nerdyc]
* Xcode templates [nerdyc]
* Added Cedar-style global +beforeEach and +afterEach

v0.1.8
======

* Use atomic variables for async blocks [jspahrsummers]
* Fail instead of skipping when exceptions get thrown outside actual tests.
* itShouldBehaveLike should fail when called inside an it() block.

v0.1.7
======

* Async Testing [danpalmer]

v0.1.6
======

* Allow a custom subclass for test cases [joshabar]
* Xcode 4.4 fixes [jspahrsummers]
* Added a way to allow lazy evaluation of shared examples' context

v0.1.5
======

* Shared examples
* Sanitize description on exception [meiwin]

v0.1.4
======

* Pending specs
* Include SpectaTypes.h in the build output [strangemonad]

v0.1.3
======

* Fixed unexpected exceptions not being caught in iOS4 simulator
* Map unexpected exceptions to correct spec file

v0.1.2
======

* Fixed compiled example names being incorrectly generated

v0.1.1
======

* Prevented SPTSenTest class from running

v0.1.0
======

* First Release

