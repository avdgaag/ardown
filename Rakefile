require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/test_*.rb']
end

desc 'Start IRB session with Ardown loaded'
task :console do
  $LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
  require 'ardown'
  require 'irb'
  require 'irb/completion'
  ARGV.clear
  IRB.start
end

desc 'Run benchmark of Ardown and Kramdown against same document'
task :benchmark do
  $LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
  require 'ardown'
  require 'kramdown'
  require 'benchmark'

  content = File.read(File.expand_path('../test/fixtures/page.md', __FILE__))
  n = 500
  Benchmark.bm(10) do |x|
    x.report('Ardown')   { n.times { Ardown::Document.new(content).to_html } }
    x.report('Kramdown') { n.times { Kramdown::Document.new(content).to_html } }
  end
end

task default: :test
