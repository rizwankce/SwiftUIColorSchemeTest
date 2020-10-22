//
//  ContentView.swift
//  Shared
//
//  Created by Rizwan on 12/07/20.
//

import SwiftUI

struct PreferredColorSchemeModifier: ViewModifier {
    var colorScheme: ColorScheme?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let colorScheme = colorScheme {
            content
                .environment(\.colorScheme, colorScheme)
        } else {
            content
        }
    }
}

extension View {
    func applyPreferredColorScheme(_ colorScheme: ColorScheme?) -> some View {
        self.modifier(PreferredColorSchemeModifier(colorScheme: colorScheme))
    }
}

struct ContentView: View {
//    private let lightColorScheme: ColorScheme = ColorScheme(UIUserInterfaceStyle.light)!
//    private let darkColorScheme: ColorScheme = ColorScheme(UIUserInterfaceStyle.dark)!
//    private let automaticColorScheme: ColorScheme = ColorScheme(UIUserInterfaceStyle.unspecified)! // crash here!!!
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
        .applyPreferredColorScheme(preferredColorScheme)
        .navigationBarTitle("ColorScheme Test")
    }

    var selectedImage: some View {
        Image(systemName: "checkmark")
            .foregroundColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
