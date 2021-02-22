import XCTest

import HelloPackageTests

var tests = [XCTestCaseEntry]()
tests += HelloPackageTests.allTests()
XCTMain(tests)
