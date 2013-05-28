Dir[Pathname(File.dirname(__FILE__)).join('models/**/*.rb')].each do |file|
  require file
end
