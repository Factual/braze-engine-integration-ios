LIB_VERSION=$(shell cat ../library/VERSION)
LIB_TARBALL=braze-engine-ios-$(LIB_VERSION).tar.gz

LIB_URL=https://factual.bintray.com/files/$(LIB_TARBALL)

LOCAL_POD_ROOT=./BrazeFactualEngineLocalPod

install-dev:
	cp Podfile.dev Podfile
	pod install

clean:
	rm -rf Podfile $(LOCAL_POD_ROOT) AnalyticsEngineDemo.xcworkspace/ Pods AnalyticsEngineDemo.xcodeproj/xcuserdata/ *.lock *~ AnalyticsEngineDemo.xcodeproj/project.xcworkspace/xcuserdata

clean-simulators:
	xcrun simctl erase all
