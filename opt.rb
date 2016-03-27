require 'yaml'
options = {behaviour: 'loop'}
puts options
y = YAML.dump(options)
f = File.new('config.yaml', 'w')
    f.write(y)
    f.close