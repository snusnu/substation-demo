$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'demo/web/routes'

run Demo::Web::App
