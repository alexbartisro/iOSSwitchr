//
//  DeepLinkHandler.swift
//  iOSSwitchr
//
//  Created by Alex Bartis on 13/05/2020.
//  Copyright © 2020 Alex Bartis. All rights reserved.
//

import Foundation
import UIKit

class DeepLinkHandler {
    static func handle(urlString: String, for browserType: Browser.ID) {
        
        var newURL: URL!
        
        switch browserType {
        case .Firefox:
            if let unwrappedURL = getFirefoxURL(from: urlString) {
                newURL = unwrappedURL
            }
            
        case .Chrome:
            if let unwrappedURL = getChromeURL(from: urlString) {
                newURL = unwrappedURL
            }

        case .Brave:
                   if let unwrappedURL = getBraveURL(from: urlString) {
                       newURL = unwrappedURL
                   }
    
        case .Edge:
            if let unwrappedURL = getEdgeURL(from: urlString) {
                newURL = unwrappedURL
            }
        default:
            return
        }
       
        UIApplication.shared.open(newURL)
    }
    
    /*
    *   Brave's URL scheme is the same as Firefox's URL scheme.
    */
    private static func getBraveURL(from oldURLString: String) -> URL? {
        let newString =  "brave://open-url?url=" + oldURLString
        guard let url = URL(string: newString) else {
            return nil
        }
        
        return url
    }
    
    
    private static func getFirefoxURL(from oldURLString: String) -> URL? {
        let newString =  "firefox://open-url?url=" + oldURLString
        guard let url = URL(string: newString) else {
            return nil
        }
        
        return url
    }
    
    
    private static func getChromeURL(from oldURLString: String) -> URL? {
        let existingScheme = oldURLString.components(separatedBy: ":").first ?? "https"
        let chromeScheme = existingScheme == "http" ? "googlechrome" : "googlechromes"
        let newURLString = oldURLString.replacingOccurrences(of: existingScheme, with: chromeScheme)
        
        guard let url = URL(string: newURLString) else {
            return nil
        }
        
        return url
    }
      
    //Edge URL scheme - and handling to endure that https: or http: in the URL
    //(often found with mail clients and safe link handling) dont get replaced
    
    private static func getEdgeURL(from oldURLString: String) -> URL? {
        let existingScheme = oldURLString.components(separatedBy: ":").first ?? "https"
        let stringIndex = oldURLString.index(oldURLString.startIndex, offsetBy: existingScheme.count)
        
        let slugString = oldURLString.suffix(from: stringIndex)
        let edgeScheme = existingScheme == "http" ? "microsoft-edge-http" : "microsoft-edge-https"
        let newURLString = edgeScheme + slugString
        
        guard let url = URL(string: newURLString) else {
            return nil
        }
        
        return url
    }
}
