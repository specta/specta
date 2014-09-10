require 'tmpdir'

WORKSPACE = 'Specta.xcworkspace'
CONFIGURATION = 'Release'

def execute(command, stdout=nil)
  puts "Running #{command}..."
  command += " > #{stdout}" if stdout
  system(command) or raise "** BUILD FAILED **"
end

def build(scheme, sdk)
  execute "xcodebuild -workspace #{WORKSPACE} -scheme #{scheme} -sdk #{sdk} -configuration #{CONFIGURATION} SYMROOT=build"
end

def clean(scheme)
  execute "xcodebuild -workspace #{WORKSPACE} -scheme #{scheme} clean"
end

desc 'clean'
task :clean do |t|
  puts '=== CLEAN ==='
  clean('Specta')
  clean('Specta-iOS')
end

desc 'build'
task :build => :clean do |t|
  puts "=== BUILD ==="
  build('Specta', 'macosx')
  build('Specta-iOS', 'iphonesimulator')
  build('Specta-iOS', 'iphoneos')

  macosx_binary = "Specta/build/#{CONFIGURATION}/Specta.framework"
  iphoneos_binary = "Specta/build/#{CONFIGURATION}-iphoneos/Specta.framework"
  iphonesimulator_binary = "Specta/build/#{CONFIGURATION}-iphonesimulator/Specta.framework"
  universal_binary = "Specta/build/#{CONFIGURATION}-ios-universal/Specta.framework"

  puts "\n=== GENERATE UNIVERSAL iOS BINARY (Device/Simulator) ==="
  execute "yes | rm -rf '#{universal_binary}'"
  execute "mkdir -p 'Specta/build/#{CONFIGURATION}-ios-universal'"
  execute "cp -a '#{iphoneos_binary}' '#{universal_binary}'"
  execute "lipo -create '#{iphoneos_binary}'/Specta '#{iphonesimulator_binary}'/Specta -output '#{universal_binary}'/Specta"

  puts "\n=== CODESIGN ==="
  execute "/usr/bin/codesign --force --sign 'iPhone Developer' --resource-rules='#{universal_binary}'/ResourceRules.plist '#{universal_binary}'"

  puts "\n=== COPY PRODUCTS ==="
  execute "yes | rm -rf Products"
  execute "mkdir -p Products/ios"
  execute "mkdir -p Products/osx"
  execute "mv #{macosx_binary} Products/osx"
  execute "mv #{universal_binary} Products/ios"
  puts "\n** BUILD SUCCEEDED **"
end

namespace 'templates' do
  install_directory = File.expand_path("~/Library/Developer/Xcode/Templates/File Templates/Specta")
  templates_directory = File.expand_path("../templates/Specta", __FILE__)

  desc "Uninstall Specta templates"
  task :uninstall do
    rm_rf install_directory
  end

  desc "Install Specta templates"
  task :install do
    if File.exists?(install_directory)
      puts "Templates already installed at #{install_directory}"
    else
      mkdir_p install_directory
      cp_r templates_directory, install_directory
    end
  end

  desc "Remove and re-install Specta templates"
  task :reinstall => [:uninstall, :install]
end

task :default => [:build]

