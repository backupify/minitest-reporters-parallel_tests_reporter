# Minitest::Reporters::ParallelTestsReporter

a [minitest-reporter](https://github.com/kern/minitest-reporters) extension 
for integrating with [parallel_tests](https://github.com/grosser/parallel_tests).
Designed to integrate with [parallel_tests-extensions](https://github.com/backupify/parallel_tests-extensions)

## Installation

```rb
gem 'minitest-reporters-parallel_tests_reporter'
gem 'parallel_tests-extensions'
```

## Usage

In the example below we integrate with [parallel_tests-extensions](https://github.com/backupify/parallel_tests-extensions) to
compile the reports from each process and print out the failed tests:

```rb
require 'parallel_tests/extensions'
require 'minitest/reporters/parallel_tests_reporter'

ParallelTests.after_tests do 
  if ParallelTests.first_process?
    report = Minitest::Reporters::ParallelTestsReporter.compile_reports! 
    failed = report.select {|r| r[:failures].any?}
    if failed.any?
      puts "\nThe following tests failed:"
      puts failed.map {|f| f[:location]}.join("\n")
    end
  end
end

if ParallelTests.is_running?
  Minitest::Reporters.use!(Minitest::Reporters::ParallelTestsReporter.new)
end
```
