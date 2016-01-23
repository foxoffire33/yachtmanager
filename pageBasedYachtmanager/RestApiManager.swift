//
//  YachtManagerRestApi.swift
//  pageBasedYachtmanager
//
//  Created by Reinier on 20-01-16.
//  Copyright © 2016 Reinier. All rights reserved.
//

import Foundation

class RestApiManager {
    
    let baseUrl = "http://yachtmanager.nl/api/v1/"
    
    private func makeUrl(url:String) -> NSURL {
        return NSURL(string: self.baseUrl + url)!
    }
    
    func httpGetRequest(url:String) {
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(self.makeUrl(url)) { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
            }else {
                do{
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    print(jsonResult)
                } catch{
                    
                }
            }
        }
        
        print(task.resume())
        
        
    }
    
    func httpRequestWithAccessToken(url:String,token:String,completionHandler: (Array<YachtModel>) -> ()) -> (){
        let url = NSURL(string: String(baseUrl + url))//request url
        let session = NSURLSession.sharedSession()//start session
        //header toevoegen aan request
        let muableRequest = NSMutableURLRequest(URL: url!)
        muableRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        muableRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //maak task met completionhandeler
        var Yachts = Array<YachtModel>()
        let task = session.dataTaskWithRequest(muableRequest) { (data, response, error) -> Void in
            if(error == nil){//Heb ik een error
                do {//try catch
                    print(response)
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    for attributes in jsonResult{
                        let yachtModel = YachtModel(attributes: attributes as! Dictionary<String,AnyObject>)
                        Yachts.append(yachtModel)
                    }
                    //completionHandeler
                    completionHandler(Yachts)
                }catch{
                    //todo gebruiker moet een foutmelding kijgen
                }
            }else{// ik heb wel een error print dit in de logs
                print(error?.code)
            }
        }
        task.resume()
    }
    
    func httpDeleRequesttWithAccessToken(url:String,token:String,completionHandler: (Bool) -> ()) -> (){
        let url = NSURL(string: String(baseUrl + url))//request url
        let session = NSURLSession.sharedSession()//start session
        //header toevoegen aan request
        let muableRequest = NSMutableURLRequest(URL: url!)
        muableRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        muableRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        muableRequest.HTTPMethod = "DELETE"
        let task = session.dataTaskWithRequest(muableRequest) { (data, response, error) -> Void in
                completionHandler(true)
        }
        task.resume()
    }
}