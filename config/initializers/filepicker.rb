if File.exists? 'config/filepicker.yml'
  yml = IO.read(File.expand_path('../../filepicker.yml', __FILE__))
  FILEPICKER_KEYS = YAML.load(yml)
else
  FILEPICKER_KEYS = {
    'api_key' => ENV['FILEPICKER_KEY'],
  }
end