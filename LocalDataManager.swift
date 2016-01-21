//
//  LocalDataManager.swift
//  yachtmanager-iso9
//
//  Created by reinier de la parra on 15/10/15.
//  Copyright © 2015 Releaz. All rights reserved.
//

import Foundation

class LocalDataManager {
    
    private var accessToken:String? = nil
    private let accessTokenKey = "access_token"
    
    private func getUserDefaults() -> NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    
    func getAccessToken() -> String? {
        let defaults = self.getUserDefaults()
        if let token = defaults.stringForKey(accessTokenKey) {
            accessToken = token
        }
        return accessToken;
    }
    
    func setAccessToken(token:String) -> String?{
        let defaults = self.getUserDefaults()
        defaults.setObject(token, forKey: accessTokenKey);
        defaults.synchronize()
        return self.getAccessToken()
    }
    
    func deleteAccessToken(){
        let defaults = self.getUserDefaults()
         if defaults.stringForKey(accessTokenKey) != nil{
            defaults.removeObjectForKey(accessTokenKey)
        }
    }
    
}