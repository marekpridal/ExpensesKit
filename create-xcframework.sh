xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "generic/platform=iOS" \
-archivePath "$PWD/archives/ExpensesKit-iOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "generic/platform=iOS Simulator" \
-archivePath "$PWD/archives/ExpensesKit-iOS-Simulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "generic/platform=watchOS" \
-archivePath "$PWD/archives/ExpensesKit-watchOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "generic/platform=watchOS Simulator" \
-archivePath "$PWD/archives/ExpensesKit-watchOS-Simulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "generic/platform=tvOS" \
-archivePath "$PWD/archives/ExpensesKit-tvOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "generic/platform=tvOS Simulator" \
-archivePath "$PWD/archives/ExpensesKit-tvOS-Simulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "platform=macOS,arch=x86_64" \
-archivePath "$PWD/archives/ExpensesKit-macOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild -create-xcframework \
-framework "$PWD/archives/ExpensesKit-iOS.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-debug-symbols "$PWD/archives/ExpensesKit-iOS.xcarchive/dSYMs/ExpensesKit.framework.dSYM" \
-framework "$PWD/archives/ExpensesKit-iOS-Simulator.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-debug-symbols "$PWD/archives/ExpensesKit-iOS-Simulator.xcarchive/dSYMs/ExpensesKit.framework.dSYM" \
-framework "$PWD/archives/ExpensesKit-watchOS.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-debug-symbols "$PWD/archives/ExpensesKit-watchOS.xcarchive/dSYMs/ExpensesKit.framework.dSYM" \
-framework "$PWD/archives/ExpensesKit-watchOS-Simulator.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-debug-symbols "$PWD/archives/ExpensesKit-watchOS-Simulator.xcarchive/dSYMs/ExpensesKit.framework.dSYM" \
-framework "$PWD/archives/ExpensesKit-tvOS.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-debug-symbols "$PWD/archives/ExpensesKit-tvOS.xcarchive/dSYMs/ExpensesKit.framework.dSYM" \
-framework "$PWD/archives/ExpensesKit-tvOS-Simulator.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-debug-symbols "$PWD/archives/ExpensesKit-tvOS-Simulator.xcarchive/dSYMs/ExpensesKit.framework.dSYM" \
-framework "$PWD/archives/ExpensesKit-macOS.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-debug-symbols "$PWD/archives/ExpensesKit-macOS.xcarchive/dSYMs/ExpensesKit.framework.dSYM" \
-output artifacts/ExpensesKit.xcframework
