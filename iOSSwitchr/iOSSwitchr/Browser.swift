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
    var key = Keys.none

    enum Keys: String {
        case none = "none"
        case Firefox = "firefox"
        case Chrome = "chrome"
        case Vivaldi = "vivaldi"
        case Brave = "brave"
    }

    init(name: String = "none", key: Keys = Keys.none) {
        self.name = name
        self.key = key
    }
}

extension Browser: ObservableObject, Hashable {
    public static func == (lhs: Browser, rhs: Browser) -> Bool {
        return lhs.key == rhs.key && lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
