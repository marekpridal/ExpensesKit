xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "generic/platform=iOS" \
-archivePath "archives/ExpensesKit-iOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "generic/platform=iOS Simulator" \
-archivePath "archives/ExpensesKit-iOS-Simulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "generic/platform=watchOS" \
-archivePath "archives/ExpensesKit-watchOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "generic/platform=watchOS Simulator" \
-archivePath "archives/ExpensesKit-watchOS-Simulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "generic/platform=tvOS" \
-archivePath "archives/ExpensesKit-tvOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "generic/platform=tvOS Simulator" \
-archivePath "archives/ExpensesKit-tvOS-Simulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild archive \
-project ExpensesKit.xcodeproj \
-scheme ExpensesKit-Package \
-configuration Release \
-destination "platform=macOS,arch=x86_64" \
-archivePath "archives/ExpensesKit-macOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES

xcodebuild -create-xcframework \
-framework "archives/ExpensesKit-iOS.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-framework "archives/ExpensesKit-iOS-Simulator.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-framework "archives/ExpensesKit-watchOS.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-framework "archives/ExpensesKit-watchOS-Simulator.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-framework "archives/ExpensesKit-tvOS.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-framework "archives/ExpensesKit-tvOS-Simulator.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-framework "archives/ExpensesKit-macOS.xcarchive/Products/Library/Frameworks/ExpensesKit.framework" \
-output artifacts/ExpensesKit.xcframework
