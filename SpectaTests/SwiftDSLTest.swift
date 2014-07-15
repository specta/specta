import XCTest
import Specta

class SwiftDSLTest: SPTSpec {
  override func spec() {
    self.specBegin()

    spt_describe("swift dsl") {
      var foo: Bool = false
      var bar: Bool = false

      spt_beforeAll {
        bar = true
      }

      spt_beforeEach {
        foo = true
      }

      spt_it("works") {
        XCTAssertEqual(foo, true, "foo is true")
        XCTAssertEqual(bar, true, "bar is true")
      }

      spt_it("really works") {
        spt_waitUntil { (done: DoneCallback!) in
          XCTAssertEqual(foo, true, "foo is true")
          XCTAssertEqual(bar, true, "bar is true")
          done()
        }
      }

      spt_afterEach {
        XCTAssertEqual(foo, true, "foo is true")
      }

      spt_afterAll {
        XCTAssertEqual(bar, true, "bar is true")
      }
    }
  }
}