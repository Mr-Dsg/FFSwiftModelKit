# FFSwiftModelKit

A lightweight and high-performance Swift model mapping framework built with Runtime and Reflection.

## ✨ Features

- JSON ↔ Model
- Runtime Reflection
- Zero Dependencies
- Optional Support
- Swift Package Manager

## 📦 Installation

### Swift Package Manager

```swift
dependencies: [
    .package(
        url: "https://github.com/Mr-Dsg/FFSwiftModelKit.git",
        from: "1.0.0"
    )
]
```

## 🚀 Usage

### Define Model

```swift
final class User: NSObject, FFModel {

    var name: String?
    var age: Int = 0
}
```

### Decode

```swift
let user = FFJSON.decode(
    User.self,
    from: json
)
```

### Encode

```swift
let dictionary = FFJSON.encode(user)
```

## ✅ Supported

| Feature | Status |
| :------ | :----: |
| JSON ↔ Model | ✅ |
| Model ↔ JSON | ✅ |
| Optional | ✅ |
| Runtime Cache | ✅ |
| Mirror Cache | ✅ |

## 📄 License

Released under the MIT License.
