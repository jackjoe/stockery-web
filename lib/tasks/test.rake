tasks = Rake.application.instance_variable_get '@tasks'

tasks.delete 'test:units'
tasks.delete 'test:functionals'
tasks.delete 'test:integration'

namespace :test do
  task :units do
  end
  task :functionals do
  end
  task :integration do
  end
end
