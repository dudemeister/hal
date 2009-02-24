require 'test/unit/testsuite'
require 'model/test_filemodel' 
require 'test/unit/ui/console/testrunner'



class TS_MyTests
  def self.suite
    suite = Test::Unit::TestSuite.new
    suite << TestCaseFileModel.suite

    return suite
  end
end
Test::Unit::UI::Console::TestRunner.run(TS_MyTests)