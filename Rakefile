require 'tmpdir'

def execute(command, stdout=nil)
  puts "Running #{command}..."
  command += " > #{stdout}" if stdout
  system(command) or raise "** BUILD FAILED **"
end

def xcodebuild(target, sdk, configuration='Release')
  "xcodebuild -target #{target} -sdk #{sdk} -configuration #{configuration}"
end

desc 'clean'
task :clean do |t|
  puts '=== CLEAN ==='
  execute "xcodebuild -alltargets clean"
end

desc 'build'
task :build => :clean do |t|
  puts "=== BUILD ==="
  configuration = 'Release'
  execute xcodebuild('Specta', 'macosx', configuration)
  execute xcodebuild('Specta-iOS', 'iphonesimulator', configuration)
  execute xcodebuild('Specta-iOS', 'iphoneos', configuration)
  macosx_binary = "build/#{configuration}/libSpecta.a"
  iphoneos_binary = "build/#{configuration}-iphoneos/libSpecta-ios.a"
  iphonesimulator_binary = "build/#{configuration}-iphonesimulator/libSpecta-ios.a"
  universal_binary = "build/libSpecta-ios-universal.a"
  puts "=== GENERATE UNIVERSAL iOS BINARY (Device/Simulator) ==="
  execute "lipo -create '#{iphoneos_binary}' '#{iphonesimulator_binary}' -output '#{universal_binary}'"
  puts "\n=== COPY PRODUCTS ==="
  execute "yes | rm -f products/*.h products/*.a products/LICENSE products/README.md"
  execute "cp #{macosx_binary} products/libSpecta-macosx.a"
  execute "mv #{universal_binary} products/"
  execute "cp build/#{configuration}/*.h products/"
  execute "cp LICENSE products/"
  execute "cp README.md products/"
  puts "\n** BUILD SUCCEEDED **"
end

task :default => [:build]

