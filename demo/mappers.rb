Dir[Pathname(File.dirname(__FILE__)).join('mappers/**/*.rb')].each do |file|
  require file
end
