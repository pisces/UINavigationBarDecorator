# UINavigationBarDecorator

[![CI Status](http://img.shields.io/travis/pisces/UINavigationBarDecorator.svg?style=flat)](https://travis-ci.org/pisces/UINavigationBarDecorator)
[![Version](https://img.shields.io/cocoapods/v/UINavigationBarDecorator.svg?style=flat)](http://cocoapods.org/pods/UINavigationBarDecorator)
[![License](https://img.shields.io/cocoapods/l/UINavigationBarDecorator.svg?style=flat)](http://cocoapods.org/pods/UINavigationBarDecorator)
[![Platform](https://img.shields.io/cocoapods/p/UINavigationBarDecorator.svg?style=flat)](http://cocoapods.org/pods/UINavigationBarDecorator)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Compatible UINavigationBarAppearance for all ios versions

## Features
- Easy to apply navigation bar style for all ios versions
- Apply navigation bar style as one interface for all ios versions
- Provide compatible UINavigationBarAppearance for versions below ios 13
- Provide CompatibleNavigationBarAppearance like UINavigationBarAppearance that is available on ios 13 higher
- Automatically apply appearance to navigation bar through the view controller life cycle

## Demo
### Normal title
<p valign="top">
<img src="Images/ScreenShot01.png" width="400"/>
<img src="Images/ScreenShot02.png" width="400"/>
</p>

### Large title
<p valign="top">
<img src="Images/ScreenShot03.png" width="400"/>
<img src="Images/ScreenShot04.png" width="400"/>
</p>

### Configure UINavigationBarDecorator
```swift
import UINavigationBarDecorator

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // If true, navigation bar will decorate automacally it according to life cycle of view controller
        UINavigationBarDecorator.isAllowsSwizzleLifeCycleOfViewController = true
        
        // set if you have factory that implemented UINavigationBarDecoratorFactory
        UINavigationBarDecorator.factory = SampleNavigationBarDecoratorFactory()
        return true
    }
}
```

### Using with factory
```swift
import UINavigationBarDecorator

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
import UINavigationBarDecorator

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarDecorator = .init(standard: .orange, compact: .orange, scrollEdge: .orange)
    }
}
```

### Apply decorator manually
```swift
import UINavigationBarDecorator

// AppDelegate.swift
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBarDecorator.isAllowsSwizzleLifeCycleOfViewController = false
        UINavigationBarDecorator.factory = SampleNavigationBarDecoratorFactory()
        return true
    }
}

// SampleNavigationController.swift
final class SampleNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
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

iOS SDK 9.0 equal or higher

## Installation

SimpleLayout is available through [CocoaPods](http://cocoapods.org). To install
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
github "pisces/UINavigationBarDecorator" ~> 0.1.0
```

Run `carthage update` to build the framework and drag the built `SimpleLayout.framework` into your Xcode project.

## Author

Steve Kim, hh963103@gmail.com

## License

UINavigationBarDecorator is available under the BSD license. See the LICENSE file for more info.
