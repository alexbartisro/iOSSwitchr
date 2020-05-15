//
//  Browser.swift
//  iOSSwitchr
//
//  Created by alexandru.bartis on 13/05/2020.
//  Copyright © 2020 Alex Bartis. All rights reserved.
//

import Foundation

class Browser {
    var name = ""
    var id = ID.none

    enum ID: String {
        case none = "none"
        case Firefox = "firefox"
        case Chrome = "chrome"
        case Vivaldi = "vivaldi"
        case Brave = "brave"
        case Opera = "opera"
        case Edge = "edge"
    }

    init(name: String = "none", id: ID = ID.none) {
        self.name = name
        self.id = id
    }
}

extension Browser: ObservableObject, Hashable {
    public static func == (lhs: Browser, rhs: Browser) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
