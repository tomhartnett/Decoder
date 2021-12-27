//
//  CipherSelectionView.swift
//  Decoder
//
//  Created by Tom Hartnett on 12/27/21.
//

import SwiftUI

struct CipherSelectionView: View {
    @Binding var cipher: UInt8

    private var letters: [Character] = [
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
        "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
        "U", "V", "W", "X", "Y", "Z"
    ]

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(1..<27) { index in
                        Text("\(index)")
                            .onTapGesture {
                                cipher = UInt8(index)
                            }
                    }
                }
            }

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
}

//struct CipherSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CipherSelectionView(cipher: .constant(13))
//    }
//}
