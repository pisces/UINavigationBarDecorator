# UINavigationBarDecorator

![Swift](https://img.shields.io/badge/Swift-5-orange.svg)
[![CI Status](http://img.shields.io/travis/pisces/UINavigationBarDecorator.svg?style=flat)](https://travis-ci.org/pisces/UINavigationBarDecorator)
[![Version](https://img.shields.io/cocoapods/v/UINavigationBarDecorator.svg?style=flat)](http://cocoapods.org/pods/UINavigationBarDecorator)
[![License](https://img.shields.io/cocoapods/l/UINavigationBarDecorator.svg?style=flat)](http://cocoapods.org/pods/UINavigationBarDecorator)
[![Platform](https://img.shields.io/cocoapods/p/UINavigationBarDecorator.svg?style=flat)](http://cocoapods.org/pods/UINavigationBarDecorator)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Compatible UINavigationBarAppearance for all iOS versions

## Features
- Provide AdvancedNavigationBar is able to change size
- Easy to apply navigation bar style for all iOS versions
- Apply navigation bar style as one interface for all iOS versions
- Provide compatible UINavigationBarAppearance for versions below iOS 13
- Provide CompatibleNavigationBarAppearance like UINavigationBarAppearance that is available on iOS 13 higher
- Automatically apply appearance to navigation bar through the view controller life cycle

## Demo
<img src="Images/RPReplay-Final1604664543.gif"/>

### Normal title on iOS 10.x
<p valign="top">
<img src="Images/ScreenShot01.png" width="400"/>
<img src="Images/ScreenShot02.png" width="400"/>
</p>

### Large title on iOS 11.x
<p valign="top">
<img src="Images/ScreenShot03.png" width="400"/>
<img src="Images/ScreenShot04.png" width="400"/>
</p>

### Large title on iOS 13 higher
<p valign="top">
<img src="Images/ScreenShot05.png" width="400"/>
<img src="Images/ScreenShot06.png" width="400"/>
</p>

## Custom NavigationBar

### AdvancedNavigationBar with Interface Builder
<p valign="top">
<img src="Images/ScreenShot07.png" width="400"/>
<img src="Images/ScreenShot08.png" width="400"/>
</p>

### PageSheetNavigationBar with Interface Builder
<p valign="top">
<img src="Images/ScreenShot09.png" width="400"/>
<img src="Images/ScreenShot10.png" width="400"/>
</p>

### Using Programacally
```swift
let navigationController = UINavigationController(
    rootViewController: #{YourVC}, 
    navigationBarClass: PageSheetNavigationBar.self)
```

## UINavigationBarDecorator

### Using with factory
```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBarDecorator.isAllowsSwizzleLifeCycleOfViewController = true
        UINavigationBarDecorator.factory = SampleNavigationBarDecoratorFactory()
        return true
    }
}
```

```swift
struct SampleNavigationBarDecoratorFactory: UINavigationBarDecoratorFactory {
    func create(of vc: UIViewController) -> UINavigationBarDecorator? {
        switch vc {
        case is RootViewController:
            return .init(standard: .orange, compact: .orange, scrollEdge: .orange)
        case is SecondViewController:
            return .init(standard: .purple, compact: .purple, scrollEdge: .purple)
        default:
            return nil
        }
    }
}

extension CompatibleNavigationBarAppearance {
    static var purple: CompatibleNavigationBarAppearance {
        let appearance = CompatibleNavigationBarAppearance()
        appearance.backgroundColor = .purple
        appearance.tintColor = .white
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font : UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        return appearance
    }
    static var orange: CompatibleNavigationBarAppearance {
        let appearance = CompatibleNavigationBarAppearance()
        appearance.backgroundColor = .orange
        appearance.tintColor = .black
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font : UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        return appearance
    }
}
```

### Using without factory
- set the decorator directly on the view controller
```swift
final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarDecorator = .init(standard: .orange, compact: .orange, scrollEdge: .orange)
    }
}
```

### Apply decorator manually
```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBarDecorator.isAllowsSwizzleLifeCycleOfViewController = false
        UINavigationBarDecorator.factory = SampleNavigationBarDecoratorFactory()
        return true
    }
}

final class SampleNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        topViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension SampleNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationBarDecorator?.decorate(to: viewController)
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        viewController.navigationBarDecorator?.decorate(to: viewController, by: viewController.view.frame.size)
    }
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS SDK 10.0 equal or higher

## Installation

UINavigationBarDecorator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UINavigationBarDecorator"
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Alamofire into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "pisces/UINavigationBarDecorator" ~> 1.0.5
```

Run `carthage update` to build the framework and drag the built `UINavigationBarDecorator.framework` into your Xcode project.

## Author

Steve Kim, hh963103@gmail.com

## License

UINavigationBarDecorator is available under the BSD license. See the LICENSE file for more info.
