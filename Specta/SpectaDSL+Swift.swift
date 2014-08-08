import Foundation

func specBegin(file: String = __FILE__, line: Int = __LINE__) {
  (NSThread.currentThread().threadDictionary["SPTCurrentSpec"] as SPTSpec).dynamicType.spt_setCurrentTestSuiteFileName(file, lineNumber: line)
}

func describe(name: String, closure: (() -> ())? = nil) {
  spt_describe(name, closure)
}

func fdescribe(name: String, closure: (() -> ())? = nil) {
  spt_fdescribe(name, closure)
}

func context(name: String, closure: (() -> ())? = nil) {
  spt_describe(name, closure)
}

func fcontext(name: String, closure: (() -> ())? = nil) {
  spt_fdescribe(name, closure)
}

func it(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, line, closure)
}

func fit(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_fit_(name, file, line, closure)
}

func example(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, line, closure)
}

func fexample(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_fit_(name, file, line, closure)
}

func specify(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, line, closure)
}

func fspecify(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_fit_(name, file, line, closure)
}

func pending(name: String, file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, line, nil)
}

func xdescribe(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, line, nil)
}

func xcontext(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, line, nil)
}

func xexample(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, line, nil)
}

func xit(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, line, nil)
}

func xspecify(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, line, nil)
}

func beforeAll(closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_beforeAll(closure) // TODO: add file & line
}

func afterAll(closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_afterAll(closure) // TODO: add file & line
}

func before(closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_beforeEach(closure) // TODO: add file & line
}

func after(closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_afterEach(closure) // TODO: add file & line
}

func beforeEach(closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_beforeEach(closure) // TODO: add file & line
}

func afterEach(closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_afterEach(closure) // TODO: add file & line
}

func sharedExamplesFor(name: String, closure: (Dictionary<String, AnyObject>) -> ()) {
  let block = { (data: NSDictionary!) -> () in
    closure(data as Dictionary<String, AnyObject>)
  }
  spt_sharedExamplesFor(name, block)
}

func sharedExamples(name: String, closure: (Dictionary<String, AnyObject>) -> ()) {
  sharedExamplesFor(name, closure)
}

func itShouldBehaveLike(name: String, closure: @auto_closure () -> Dictionary<String, AnyObject>, file: String = __FILE__, line: Int = __LINE__) {
  let block = { () -> NSDictionary in
    let dict = closure()
    var nsdict = NSMutableDictionary.dictionary()
    for (key: String, val: AnyObject) in dict {
      nsdict.setObject(val as AnyObject, forKey: key)
    }
    return nsdict
  }
  spt_itShouldBehaveLike_block(file, line, name, block)
}

func itBehavesLike(name: String, closure: @auto_closure () -> Dictionary<String, AnyObject>, file: String = __FILE__, line: Int = __LINE__) {
  itShouldBehaveLike(name, closure, file: file, line: line)
}

func waitUntil(closure: (done: DoneCallback!) -> ()) {
  spt_waitUntil(closure)
}
