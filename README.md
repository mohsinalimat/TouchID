# TouchID

`TouchID` is an iOS TouchID library.

> Also see [MXTouchID](https://github.com/Meniny/MXTouchID-in-Objective-C) for Objective-C version.

## Installation

#### CocoaPods

```
pod 'TouchID'
```

## Usage

```swift
import TouchID
```

```swift
if !TouchID.isEnabled {
  print("TouchID is not enabled")
}
```

```swift
TouchID.evaluate(reason: "fot framework testing") { (success, error) in
  // code here...
}
```
