source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def pods

end

def pods_test

	pods
	pod 'ESTestKit', '~> 0.3.4-beta1'

end

target :ESThread_OSX do

	platform :osx, '10.9'
	pods

end

target :ESThread_iOS do

	platform :ios, '8.0'
	pods

end

target :ESThread_OSXTests do

	platform :osx, '10.9'
	pods_test

end

target :ESThread_iOSTests do

	platform :ios, '8.0'
	pods_test

end
