require 'pp'
pp $LOAD_PATH
puts File.dirname(__FILE__)
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'demo/web/routes'

run Demo::Web::App
