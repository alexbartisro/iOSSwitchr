//
//  Settings.swift
//  iOSSwitchr
//
//  Created by alexandru.bartis on 13/05/2020.
//  Copyright © 2020 Alex Bartis. All rights reserved.
//

import Foundation
import Combine

class Settings: ObservableObject {

    private let defaults = UserDefaults.standard
    private let defaultsKey = "DefaultBrowser"

    @Published var browsers = [Browser(name: "Firefox", key: .Firefox),
                           Browser(name: "Chrome", key: .Chrome),
                           Browser(name: "Vivaldi", key: .Vivaldi),
                           Browser(name: "Brave", key: .Brave)]

    @Published var defaultBrowser: Browser {
        didSet {
            defaults.set(defaultBrowser.key.rawValue, forKey: defaultsKey)
        }
    }

    init() {
        guard let existingDefault = defaults.object(forKey: defaultsKey) as? String,
        let existingKey = Browser.Keys(rawValue: existingDefault)  else {
            self.defaultBrowser = Browser()

            return
        }

        self.defaultBrowser = Browser(name: existingDefault.capitalizingFirstLetter(), key: existingKey)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
