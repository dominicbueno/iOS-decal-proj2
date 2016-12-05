//
//  String+Indexing.swift
//  Hangman
//
//  Created by Gera Groshev on 11/5/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import Foundation
extension String {
    /*
     let string = "Hello,World!"
     string.substring(from: 1, to: 7)gets you: ello,Wo
     string.substring(to: 7)gets you: Hello,Wo
     string.substring(from: 3)gets you: lo,World!
     string.substring(from: 1, length: 4)gets you: ello
     string.substring(length: 4, to: 7)gets you: o,Wo
     string.substring(atIndex: 1) gets you: e
     */
    
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.characters.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.characters.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return self[startIndex ..< endIndex]
    }
    
    func substring(atIndex: Int) -> String {
        return self.substring(from: atIndex, to: atIndex)
    }
    
    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }
    
    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }
    
    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }
        
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length
        }
        
        return self.substring(from: from, to: end)
    }
    
    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }
        
        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }
        
        return self.substring(from: start, to: to)
    }
}
