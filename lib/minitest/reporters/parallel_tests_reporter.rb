require 'minitest/reporters'

module Minitest
  module Reporters
    class ParallelTestsReporter < BaseReporter
      VERSION = '0.0.1-pre'

      # Override if needed
      def self.compiled_report_filepath
        'tmp/test_output_compiled.yml'
      end

      # Override if needed
      def self.report_name_prefix
        'tmp/test_output'
      end

      # Use to read the report
      def self.load_compiled_report
        YAML.load_file(self.compiled_report_filepath)
      end

      # Call to compile all of the parallel reports together into one
      # Destroys each of the segment reports after compiling
      def self.compile_reports!
        outputs = Dir[self.report_name_prefix + '*.yml']
        outputs.delete self.compiled_report_filepath
        sorted = outputs
          .flat_map {|p| YAML.load_file(p)}
          .sort {|a,b| b[:time] <=> a[:time]}

        File.open(self.compiled_report_filepath, 'w') { |f| f.write sorted.to_yaml }
        logger.debug(self.name + "::compile_reports!") { "Compiled parallel test results written to #{self.compiled_report_filepath}" }

        FileUtils.rm(outputs)
        logger.debug(self.name + "::compile_reports!") { "Parallel segment test results deleted #{outputs}" }
        sorted
      end

      # Hook into BaseReporter
      def report
        super
        result = tests.map do |t|
          { test_class_name: t.class.name, failures: t.failures.map(&:location), location: t.location, time: t.time }
        end
        filename = self.class.report_name_prefix + ENV['TEST_ENV_NUMBER'] + '.yml'
        File.open(filename, 'w') do |f|
          f.write result.to_yaml
        end
        logger.debug("#{self.class.name}#report") { "Parallel segment test results written to #{filename}" }
      end

      def logger
        self.class.logger
      end

      def self.logger
        @logger ||= Logger.new($stdout)
      end
    end
  end
end
