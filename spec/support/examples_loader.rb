def example_file(filename)
  example_path = File.expand_path('../../examples', __FILE__)
  example_file = File.join(example_path, filename)
  File.open(example_file)
end
