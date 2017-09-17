# UDClient

Super easy to use Udacity Auth and Classroom APIs client for iOS

[![Swift](https://img.shields.io/badge/Swift-4-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-9-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

---

### ⚠️ To use with **Swift 3 / Xcode 8.x** please ensure you are using [**`v0.1.1`**](https://github.com/omaralbeik/UDClient/releases/tag/0.1.1).

### ⚠️ To use with **Swift 4 / Xcode 9.x** please ensure you are using  [**`v0.3.1`**](https://github.com/omaralbeik/UDClient/releases/tag/0.3.1)

---

# Usage


Get User's basic info, Courses, Nanodegrees, and much more with few lines of code


## Get Access Token

```swift
UDClient.shared.requestToken(email: email, password: password) { error, token in
  if error != nil {
    // handle error
    return
  }

  // get token
  let token = token?.string

  // get token expiry date
  let expiryDate = token?.expiryDate

  // check if token is expired
  let isExpired = token?.isExpired

  // store the token.
}
```

## Get User Info
```swift

// all user info
let fields: UDUser.allFields

// basic user info
let fields: [UDUser.fields] = [.id, .firstName, .lastName, .email]
// and more ..

// user Nanodegrees
let fields: [UDUser.fields] = [.nanodegrees(fields: [.title, .summary])]
// and more ..

// Nanodegree hero image
let fields: [UDUser.fields] = [.nanodegrees(fields: [.heroImage(fields: [.url])])]
// and more

UDClient.shared.fetchUserInfo(token: token, fields: fields) { error, user in
  if error != nil {
    // handle error
    return
  }

  // print user debug description for easy debugging
  print(user?.debugDescription)
  // do something else with user info
}

```


# Structure

## Model:
  - [UDAuthToken.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Model/UDAuthToken.swift)
  - [UDUser.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Model/UDUser.swift)
  - [UDNanodegree.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Model/UDNanodegree.swift)
  - [UDImage.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Model/UDImage.swift)
  - [UDError.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Model/UDError.swift)

## Services:
  - [UDClient.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/UDClient.swift)


## Udacity Classroom API:
 - This project relies on [Udacity Classroom API](https://classroom-content.udacity.com/api/v1/graphql)

## Dependencies:
  - UDClient uses [Alamofire](https://github.com/Alamofire/Alamofire) for networking.


# Requirements:
- iOS 8+
- Xcode 9+
- Swift 4


# Installation

## CocoaPods

To integrate UDClient into your Xcode project using [CocoaPods](http://cocoapods.org), specify it in your `Podfile`:

```ruby
pod 'UDClient'
```


## Manually

Add the [Sources](https://github.com/omaralbeik/UDClient/blob/master/Sources/) folder to your Xcode project.

Don't forget to install dependencies from the [Podfile](https://github.com/omaralbeik/UDClient/blob/master/Podfile)


# License

UDClient is released under the MIT license. See [LICENSE](https://github.com/omaralbeik/UDClient/blob/master/LICENSE) for details.
