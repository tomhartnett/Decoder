//
//  Character+Extensions.swift
//  Decoder
//
//  Created by Tom Hartnett on 12/27/21.
//

import Foundation

extension Character {
    var upperBound: UInt8 {
        guard self.isLetter else { return 0 }

        if self.isUppercase {
            return Character("Z").asciiValue!
        } else {
            return Character("z").asciiValue!
        }
    }

    var lowerBound: UInt8 {
        guard self.isLetter else { return 0 }

        if self.isUppercase {
            return Character("A").asciiValue!
        } else {
            return Character("a").asciiValue!
        }
    }

    func encrypt(_ cipher: UInt8) -> Character {
        guard self.isLetter, let asciiValue = self.asciiValue else {
            return  self
        }

        let newAsciiValue: UInt8
        if asciiValue + cipher > self.upperBound {
            newAsciiValue = (self.lowerBound - 1) + (cipher - (self.upperBound - asciiValue))
        } else {
            newAsciiValue = asciiValue + cipher
        }

        return Character.init(.init(newAsciiValue))
    }

    func decrypt(_ cipher: UInt8) -> Character {
        guard self.isLetter, let asciiValue = self.asciiValue else {
            return  self
        }

        let newAsciiValue: UInt8
        if asciiValue - cipher < self.lowerBound {
            newAsciiValue = self.upperBound - (cipher - (asciiValue - self.lowerBound)) + 1
        } else {
            newAsciiValue = asciiValue - cipher
        }

        return Character.init(.init(newAsciiValue))
    }
}
