import XCTest
import Specta

class SwiftDSLTestSharedExamples: SPTSharedExampleGroups {
  override class func defineSharedExampleGroups() {
    sharedExamplesFor("swift shared") { (data: Dictionary<String, AnyObject>) in
      it("can read data") {
        XCTAssertEqual(data["foo"] as NSString, "bar", "data[foo] is bar")
      }

      it("can really read data") {
        XCTAssertEqual(data["bar"] as NSNumber, 123, "data[bar] is 123")
      }
    }
  }
}

class SwiftDSLTest: SPTSpec {
  override func spec() {
    specBegin()

    describe("swift dsl") {
      var foo: Bool = false
      var bar: Bool = false

      beforeAll {
        bar = true
      }

      beforeEach {
        foo = true
      }

      it("works") {
        XCTAssertEqual(foo, true, "foo is true")
        XCTAssertEqual(bar, true, "bar is true")
      }

      specify("also works") {
        XCTAssertEqual(foo, true, "foo is true")
        XCTAssertEqual(bar, true, "bar is true")
      }

      example("really works") {
        waitUntil { (done: DoneCallback!) in
          XCTAssertEqual(foo, true, "foo is true")
          XCTAssertEqual(bar, true, "bar is true")
          done()
        }
      }

      context("nested") {
        before {
          foo = false
        }

        it("works") {
          XCTAssertEqual(foo, false, "foo is false")
          XCTAssertEqual(bar, true, "bar is true")
        }

        after {
          foo = true
        }
      }

      xdescribe("pending") {
        it("should not execute") {
          XCTFail("fail")
        }
      }

      pending("something something")

      xit("excluded") {
        XCTFail("fail")
      }

      itBehavesLike("swift shared", ["foo":"bar", "bar":123])

      afterEach {
        XCTAssertEqual(foo, true, "foo is true")
      }

      afterAll {
        XCTAssertEqual(bar, true, "bar is true")
      }
    }
  }
}