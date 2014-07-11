extension SPTSpec {
  func specBegin(file: String = __FILE__, line: Int = __LINE__) {
    self.dynamicType.spt_setCurrentTestSuiteFileName(file, lineNumber: line)
  }
}
