//
//  Constants.swift
//  UChat
//
//

import Foundation

struct K {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    //colors
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
    }
    struct FStore{
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}

