//
//  HomeView.swift
//  Decoder
//
//  Created by Tom Hartnett on 12/26/21.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var text: String = ""
    @State private var cipher: UInt8 = 13
    @State private var isPresentingCopied = false

    private var letters: [Character] = [
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
        "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
        "U", "V", "W", "X", "Y", "Z"
    ]

    var ciphers: [UInt8] = [
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25
    ]

    var body: some View {
        VStack {
            TextEditor(text: $text)
                .padding()

            Divider()

            HStack {
                Picker(selection: $cipher,
                       label: Text("\(cipher)")
                ) {
                    ForEach(ciphers, id: \.self) {
                        Text("\($0)")
                    }
                }
                .padding(.horizontal, 25)

                VStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(letters, id: \.self) { letter in
                                VStack {
                                    Text("\(String(letter))")
                                    Text("\(String(letter.encrypt(cipher)))")
                                }
                                .frame(width: 15)
                            }
                        }
                        .padding(.trailing)
                    }
                }
            }

            HStack {
                Button(action: {
                    encrypt()
                }) {
                    Image(systemName: "lock")
                    Text("Encrypt")
                        .hideIf(horizontalSizeClass == .compact)
                }

                Spacer()

                Button(action: {
                    decrypt()
                }) {
                    Image(systemName: "lock.open")
                    Text("Decrypt")
                        .hideIf(horizontalSizeClass == .compact)
                }

                Spacer()

                Button(action: {
                    copy()
                }) {
                    Image(systemName: "doc.on.doc")
                    Text("Copy")
                        .hideIf(horizontalSizeClass == .compact)
                }

                Spacer()

                Button(action: {
                    share()
                }) {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share")
                        .hideIf(horizontalSizeClass == .compact)
                }

                Spacer()

                Button(action: {
                    clear()
                }) {
                    Image(systemName: "clear")
                    Text("Clear")
                        .hideIf(horizontalSizeClass == .compact)
                }
            }
            .padding()
            .disabled(text.isEmpty)
        }
        .alert("Copied to clipboard", isPresented: $isPresentingCopied) {
            Button("OK", role: .cancel) {}
        }
    }

    func encrypt() {
        let encodedCharacters = text.map { $0.encrypt(cipher) }
        text = String(encodedCharacters)
    }

    func decrypt() {
        let decodedCharacters = text.map { $0.decrypt(cipher) }
        text = String(decodedCharacters)
    }

    func copy() {
        UIPasteboard.general.string = text
        isPresentingCopied.toggle()
    }

    func share() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        let shareController = UIActivityViewController(activityItems: [text], applicationActivities: nil)

        let popover = shareController.popoverPresentationController
        popover?.permittedArrowDirections = .any
        popover?.sourceRect = CGRect.zero
        popover?.sourceView = rootViewController.view

        rootViewController.present(shareController,
                                   animated: true,
                                   completion: nil)
    }

    func clear() {
        text = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
