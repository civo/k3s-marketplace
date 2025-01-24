#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'yaml'

exit_code = 0

Dir.glob('**/*.png').each do |filename|
  next if filename[/^vendor\//]

  image_size = ImageSize.path(filename)
  if image_size.format != :png
    puts "#{filename} isn't in PNG format"
    exit_code = 1
  end
  if image_size.width > 512
    puts "#{filename} is wider than 512px"
    exit_code = 1
  end
  if image_size.height > 512
    puts "#{filename} is taller than 512px"
    exit_code = 1
  end
  if File.size(filename) > 20_480
    puts "#{filename} is larger than 20KB"
    exit_code = 1
  end
end

Dir.glob("*").each do |dirname|
  next unless File.directory?(dirname)
  next if File.basename(dirname) == "bin"
  next if File.basename(dirname) == "vendor"

  unless File.exist?("#{dirname}/logo.png")
    puts "#{dirname} doesn't contain a logo.png"
    exit_code = 1
  end

  unless File.exist?("#{dirname}/manifest.yaml")
    puts "#{dirname} doesn't contain a manifest.yaml"
    exit_code = 1
  end

  unless (File.exist?("#{dirname}/uninstall.sh") || File.exist?("#{dirname}/app.yaml"))
    puts "#{dirname} doesn't contain an app.yaml or uninstall.sh (one or the other is required)"
    exit_code = 1
  end

  unless (File.exist?("#{dirname}/install.sh") || File.exist?("#{dirname}/app.yaml"))
    yaml = YAML.load_file("#{dirname}/manifest.yaml")

    next if yaml && yaml["default"]

    puts "#{dirname} doesn't contain an app.yaml or install.sh (one or the other is required)"
    exit_code = 1
  end
end

exit exit_code
