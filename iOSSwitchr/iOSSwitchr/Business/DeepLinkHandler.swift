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
        
        case .Edge:
            if let unwrappedURL = getEdgeURL(from: urlString) {
                newURL = unwrappedURL
            }
            
        case .Brave:
            if let unwrappedURL = getBraveURL(from: urlString) {
                newURL = unwrappedURL
            }

        case .Opera:
            if let unwrappedURL = getOperaURL(from: urlString) {
                newURL = unwrappedURL
            }
                   
        default:
            return
        }
       
        UIApplication.shared.open(newURL)
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
    
    private static func getEdgeURL(from oldURLString: String) -> URL? {
        let existingScheme = oldURLString.components(separatedBy: ":").first ?? "https"
        let edgeScheme = existingScheme == "http" ? "microsoft-edge-http" : "microsoft-edge-https"
        let newURLString = oldURLString.replacingOccurrences(of: existingScheme, with: edgeScheme)
        
        guard let url = URL(string: newURLString) else {
            return nil
        }
        
        return url
    }
    
    private static func getBraveURL(from oldURLString: String) -> URL? {
        let newString =  "brave://open-url?url=" + oldURLString
        guard let url = URL(string: newString) else {
            return nil
        }
        
        return url
    }
    
    private static func getOperaURL(from oldURLString: String) -> URL? {
        let existingScheme = oldURLString.components(separatedBy: ":").first ?? "https"
        let operaScheme = existingScheme == "http" ? "touch-http" : "touch-https"
        let newURLString = oldURLString.replacingOccurrences(of: existingScheme, with: operaScheme)
        
        guard let url = URL(string: newURLString) else {
            return nil
        }
        
        return url
    }
}

