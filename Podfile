# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'

workspace 'Watchlist.xcworkspace'
project 'Watchlist.xcodeproj'
project 'WatchlistViper/WatchlistViper.xcodeproj'

target 'WatchlistViper' do
  project 'WatchlistViper/WatchlistViper.xcodeproj'

  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod "PromiseKit", "~> 4.4"

  target 'WatchlistViperTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end

end

target 'Domain' do
  project 'Watchlist.xcodeproj'

  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod "PromiseKit", "~> 4.4"

  target 'DomainTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end

end

target 'LocalService' do
  project 'Watchlist.xcodeproj'

  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LocalService

  target 'LocalServiceTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end

end

target 'RemoteService' do
  project 'Watchlist.xcodeproj'

  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod "PromiseKit", "~> 4.4"

  target 'RemoteServiceTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end

end

target 'FoundationComponents' do
  project 'Watchlist.xcodeproj'

  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  target 'FoundationComponentsTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end

end
