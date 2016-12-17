# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

# To be removed once we upgrade to Rails 3.0.9. See http://stackoverflow.com/questions/8702504/rails-how-do-i-resolve-the-rake-rdoctask-is-deprecated-warning
Rake.application.options.ignore_deprecate = true

# To be removed once we upgrade to Rails 3.0.8. See http://stackoverflow.com/a/6106931/9195
class Rails::Application
	include Rake::DSL if defined?(Rake::DSL)
end

Mine::Application.load_tasks
