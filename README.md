# UDClient

Super easy to use Udacity Auth and Classroom APIs client for iOS

[![Swift](https://img.shields.io/badge/Swift-3.2-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-8.3-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)


# Usage

Get User's basic info, Courses, Nanodegrees, and much more with few lines of code


## Get Access Token

Fetch a story, comment, job, Ask HN, poll or poll part for a given id:
```swift
UDClient.shared.requestToken(email: email, password: password) { error, jwtoken in
  if error != nil {
    // handle error
    return
  }

  // get token
  let token = jwtoken?.string

  // get token expiry date
  let expiryDate = jwtoken?.expiresAt

  // check if token is expirted
  let expired = jwtoken?.expired

  // store the token.
}
```

## Get User Info
```swift

// basic user info
let fields: [UDUserField] = [.id, .firstName, .lastName, .email]
// and more ..

// user Nanodegrees
let fields: [UDUserField] = [.nanodegrees(fields: [.title, .summary])]
// and more ..

// Nanodegree hero image
let fields: [UDUserField] = [.nanodegrees(fields: [.heroImage(fields: [.url])])]
// and more

UDClient.shared.fetchUserInfo(token: token, fields: fields) { error, user in
  if error != nil {
    // handle error
    return
  }

  // print user debug description for easy debugging
  print(user?.debugDescription)

  // do something else with user
}

```


# Structure

## Model:
  - [UDUser.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Model/UDUser.swift)
  - [UDUserField.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Model/UDUserField.swift)
  - [UDNanodegree.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Model/UDNanodegree.swift)
  - [UDNanodegreeField.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Model/UDNanodegreeField.swift)
  - [UDImage.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Model/UDImage.swift)
  - [UDImageField.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Model/UDImageField.swift)

## Services:
  - [UDClient.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Services/UDClient.swift)

## Common:
- [ISO8601ExtendedDateTransform.swift](https://github.com/omaralbeik/UDClient/blob/master/Sources/Common/ISO8601ExtendedDateTransform.swift)


## Udacity Classroom API:
 - This project relies on [Udacity Classroom API](https://classroom-content.udacity.com/api/v1/graphql)

## Dependencies:
  - UDClient uses [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper) for networking and mapping JSON to native objects.


# Requirements:
- iOS 9.0+
- Xcode 8.1+
- Swift 3.0+


# Installation

## CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate UDClient into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'UDClient', :git => 'https://github.com/omaralbeik/UDClient.git'
end
```

Then, run the following command:

```bash
$ pod install
```

## Manually

Add the [Sources](https://github.com/omaralbeik/UDClient/blob/master/Sources/) folder to your Xcode project.

Don't forget to add all dependencies from the [Podfile](https://github.com/omaralbeik/UDClient/blob/master/Podfile)


## License

UDClient is released under the MIT license. See [LICENSE](https://github.com/omaralbeik/UDClient/blob/master/LICENSE) for details.
