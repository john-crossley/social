# Social App

This is a basic application that demonstrates how an iOS app might interact with **Firebase** to display a stream of content.

It features a minimal set of requirements that allow the following:

- Sign up, sign in and Sign out
- Users are able to create posts and delete posts *they own*
- View them on a time line
- Minimal and attractive UI

Social also includes a minimal set of frameworks, one of which I have developed called *[GyozaKit](https://cocoapods.org/pods/GyozaKit)* used for displaying messages to the user in an unobtrusive way.

## Running

To run simply `pod install` and then open the `Social.xcworkspace`

## Testing

I developed this using the new XCode 10 build system so to run the tests you should have XCode 10 and an iOS 12 simulator (device).

```bash
xcodebuild \
  -workspace Social.xcworkspace \
  -scheme Social \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone X,OS=latest' \
  test
```

If you would like to run this on a version `< iOS 12` simply clean the project and build it using XCode 9, everything should work fine.

![Auth Screen](https://github.com/john-crossley/social/blob/master/assets/auth-screen.png?raw=true "Auth Screen")

![Creating account with error](https://github.com/john-crossley/social/blob/master/assets/create-account-screen.png?raw=true "Create Account")

![Creating account with valid input](https://github.com/john-crossley/social/blob/master/assets/create-account-screen-valid.png?raw=true "Create Account")

![Sign in screen with error](https://github.com/john-crossley/social/blob/master/assets/signin-screen.png?raw=true "Sign In")

![Stream screen showing content](https://github.com/john-crossley/social/blob/master/assets/stream-screen.png?raw=true", "Stream Screen")

![Options showing signout and cancel](https://github.com/john-crossley/social/blob/master/assets/signout-prompt.png?raw=true", "Sign Out Prompt")

![Form error showing Gyoza (Message)](https://github.com/john-crossley/social/blob/master/assets/error-gyoza.png?raw=true", "Error with feedback")