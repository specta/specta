import XCTest
import Specta

class SwiftDSLTest: SPTSpec {
  override func spec() {
    self.specBegin()

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

      it("really works") {
        waitUntil { (done: DoneCallback!) in
          XCTAssertEqual(foo, true, "foo is true")
          XCTAssertEqual(bar, true, "bar is true")
          done()
        }
      }

      afterEach {
        XCTAssertEqual(foo, true, "foo is true")
      }

      afterAll {
        XCTAssertEqual(bar, true, "bar is true")
      }
    }
  }
}