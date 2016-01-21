//
//  YachtModel.swift
//  pageBasedYachtmanager
//
//  Created by Reinier on 20-01-16.
//  Copyright © 2016 Reinier. All rights reserved.
//

import Foundation

class YachtModel {
    var name: String?
    var model_id: Int?
    var sail_number:String?
    var year_build: Int?
    var callsign:String?
    var type:Int?
    var length:Double?
    var width:Double?
    var height:Double?
    var depth:Double?
    var weight:Int?
    
    
    
    init(attributes:Dictionary<String,AnyObject>){
        //init attributes
        if let name = attributes["name"] as? String { self.name = name }
        if let model_id = attributes["model_id"] as? Int { self.model_id = model_id }
        if let sail_number = attributes["sail_number"] as? String { self.sail_number = sail_number }
        if let year_build = attributes["year_build"] as? Int { self.year_build = year_build }
        if let callSign = attributes["callsign"] as? String { self.callsign = callSign }
        if let type = attributes["type"] as? Int { self.type = type }
        if let length = attributes["length"] as? Double { self.length = length }
        if let width = attributes["width"] as? Double { self.width = width }
        if let height = attributes["height"] as? Double { self.height = height }
        if let depth = attributes["depth"] as? Double { self.depth = depth }
        if let weight = attributes["weight"] as? Int { self.weight = weight }
    }
    
    func getLabelLable(name:String) -> String? {
        let attributeLables = self.attributeLabels()
            return attributeLables[name]
    }
    
    
    private func attributeLabels() -> [String:String]{
        return [
            "name":"Naam",
            "model_id":"Model",
            "sail_number":"Sail nummer",
            "year_build":"Bouw jaar",
            "callsign":"callsign",
            "type":"Soort",
            "length":"Lengte",
            "width":"Breete",
            "height":"Hoogte",
            "depth":"Diepte",
            "weight":"Gewicht"
        ]
        
    }
}