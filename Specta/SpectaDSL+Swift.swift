import Foundation

public func specBegin(file: String = __FILE__, line: Int = __LINE__) {
  (NSThread.currentThread().threadDictionary["SPTCurrentSpec"] as SPTSpec).dynamicType.spt_setCurrentTestSuiteFileName(file, lineNumber: UInt(line))
}

public func describe(name: String, closure: (() -> ())? = nil) {
  spt_describe(name, closure)
}

public func fdescribe(name: String, closure: (() -> ())? = nil) {
  spt_fdescribe(name, closure)
}

public func context(name: String, closure: (() -> ())? = nil) {
  spt_describe(name, closure)
}

public func fcontext(name: String, closure: (() -> ())? = nil) {
  spt_fdescribe(name, closure)
}

public func it(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, UInt(line), closure)
}

public func fit(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_fit_(name, file, UInt(line), closure)
}

public func example(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, UInt(line), closure)
}

public func fexample(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_fit_(name, file, UInt(line), closure)
}

public func specify(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, UInt(line), closure)
}

public func fspecify(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_fit_(name, file, UInt(line), closure)
}

public func pending(name: String, file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, UInt(line), nil)
}

public func xdescribe(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, UInt(line), nil)
}

public func xcontext(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, UInt(line), nil)
}

public func xexample(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, UInt(line), nil)
}

public func xit(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, UInt(line), nil)
}

public func xspecify(name: String, closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_it_(name, file, UInt(line), nil)
}

public func beforeAll(closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_beforeAll(closure) // TODO: add file & line
}

public func afterAll(closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_afterAll(closure) // TODO: add file & line
}

public func before(closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_beforeEach(closure) // TODO: add file & line
}

public func after(closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_afterEach(closure) // TODO: add file & line
}

public func beforeEach(closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_beforeEach(closure) // TODO: add file & line
}

public func afterEach(closure: (() -> ()), file: String = __FILE__, line: Int = __LINE__) {
  spt_afterEach(closure) // TODO: add file & line
}

public func sharedExamplesFor(name: String, closure: (Dictionary<String, AnyObject>) -> ()) {
  let block = { (data: NSDictionary!) -> () in
    closure(data as Dictionary<String, AnyObject>)
  }
//TODO  spt_sharedExamplesFor(name, block)
}

public func sharedExamples(name: String, closure: (Dictionary<String, AnyObject>) -> ()) {
  sharedExamplesFor(name, closure)
}

public func itShouldBehaveLike(name: String, closure: @autoclosure () -> Dictionary<String, AnyObject>, file: String = __FILE__, line: Int = __LINE__) {
  let block = { () -> NSDictionary in
    let dict = closure()
    var nsdict = NSMutableDictionary.dictionary()
    for (key: String, val: AnyObject) in dict {
      nsdict.setObject(val as AnyObject, forKey: key)
    }
    return nsdict
  }
//TODO  spt_itShouldBehaveLike_block(file, UInt(line), name, block)
}

public func itBehavesLike(name: String, closure: @autoclosure () -> Dictionary<String, AnyObject>, file: String = __FILE__, line: Int = __LINE__) {
  itShouldBehaveLike(name, closure, file: file, line: line)
}

public func waitUntil(closure: (done: DoneCallback!) -> ()) {
  spt_waitUntil(closure)
}
