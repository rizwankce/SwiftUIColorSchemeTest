//
//  ContentView.swift
//  Shared
//
//  Created by Rizwan on 12/07/20.
//

import SwiftUI

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
        .preferredColorScheme(preferredColorScheme)
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
