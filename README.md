# SwiftUIColorSchemeTest

Test project for SwiftUI's preferredColorScheme modifier

## Goal

Trying to get in-app color scheme change based on user selection. Idea is app will give 3 options to choose from.

- Automatic: respects system color scheme and changes whenever user switching between light and dark mode from the OS
- Light: Light mode for the whole app and didn't respect the system color scheme
- Dark: Dark mode for the whole app and didn't respect the system color scheme

## UIKit

In UIKit apps it's kind of straight forward to get the above things by simply setting the window's `overrideUserInterfaceStyle` property. Working example code below on UIKit

```swift
func updateUserInterfaceStyle() {
  switch AppDefaults.userInterfaceColorPalette {
    case .automatic:
      window!.overrideUserInterfaceStyle = .unspecified
    case .light:
      window!.overrideUserInterfaceStyle = .light
    case .dark:
      window!.overrideUserInterfaceStyle = .dark
  }
}
```

setting `.unspecified` will make the UI respect the system color scheme.

## SwiftUI

To get above behaviour in SwiftUI, there are two possible ways which I found.

- Set `.environment()` on View
- Set `.preferredColorScheme()` on View

Setting `.environment` accepts only `.dark` and `.light` color schemes. So can't really use it for my app expectations.

Setting `.preferredColorScheme` should be working since it's accpeting nullable `ColorScheme`.

My initial expectations were setting `nil` to `.preferredColorScheme` should respect system wide color scheme. But its' not.

```swift
struct ContentView: View {
    @State var preferredColorScheme: ColorScheme? = nil

    var body: some View {
        List {
            Button(action: {
                preferredColorScheme = nil
            }) {
                HStack {
                    Text("Automatic")
                    Spacer()
                    if preferredColorScheme == nil {
                        selectedImage
                    }
                }
            }

            Button(action: {
                preferredColorScheme = .light
            }) {
                HStack {
                    Text("Light")
                    Spacer()
                    if preferredColorScheme == .light {
                        selectedImage
                    }
                }
            }

            Button(action: {
                preferredColorScheme = .dark
            }) {
                HStack {
                    Text("Dark")
                    Spacer()
                    if preferredColorScheme == .dark {
                        selectedImage
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .preferredColorScheme(preferredColorScheme)
        .navigationBarTitle("ColorScheme Test")
    }

    var selectedImage: some View {
        Image(systemName: "checkmark")
            .foregroundColor(.blue)
    }
}
```

I was able to get `.light` and `.dark` mode switching working but can't really find a way to get `.automatic` working (i.e, make the whole app respects the system wide color scheme)

### What I have tried

- Setting `.preferredColorScheme` to `nil`
- Created a modifier to set content's preferredColorScheme and pass `nil`
- Try creating `ColorScheme` from `UIUserInterfaceStyle`.
  - Getting `nil` when I try to create color scheme from `UIUserInterfaceStyle.unspecified`
  - Able to creat color scheme from `UIUserInterfaceStyle` for light and dark though
