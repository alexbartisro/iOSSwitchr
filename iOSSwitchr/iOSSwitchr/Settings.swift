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

    @Published var browsers = [Browser(name: "Firefox", id: .Firefox),
                           Browser(name: "Chrome", id: .Chrome),
                           Browser(name: "Vivaldi", id: .Vivaldi),
                           Browser(name: "Brave", id: .Brave),
                           Browser(name: "Opera", id: .Opera)]

    @Published var defaultBrowser: Browser {
        didSet {
            defaults.set(defaultBrowser.id.rawValue, forKey: defaultsKey)
        }
    }

    init() {
        guard let existingDefault = defaults.object(forKey: defaultsKey) as? String,
        let existingId = Browser.ID(rawValue: existingDefault)  else {
            self.defaultBrowser = Browser()

            return
        }

        self.defaultBrowser = Browser(name: existingDefault.capitalizingFirstLetter(), id: existingId)
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
