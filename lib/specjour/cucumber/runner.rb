module Specjour
  module Cucumber
    module Runner
      def self.run(feature, output, tags)
        args = ['--format', 'Specjour::Cucumber::DistributedFormatter', feature]
        args = args.unshift("--tags",  tags.join(" ")) if tags
        cli = ::Cucumber::Cli::Main.new(args, output)

        if CUCUMBER_09x
          Cucumber.runtime.instance_variable_set(:@configuration, cli.configuration)
          Cucumber.runtime.instance_eval do
            tree_walker = @configuration.build_tree_walker(self)
            self.visitor = tree_walker
            tree_walker.visit_features(features)
          end
        else
          cli.execute!(::Cucumber::Cli::Main.step_mother)
        end
      end
    end
  end
end
