extension SPTSpec {
  public func specBegin(file: String = __FILE__, line: Int = __LINE__) {
    self.dynamicType.spt_setCurrentTestSuiteFileName(file, lineNumber: UInt(line))
  }
}
