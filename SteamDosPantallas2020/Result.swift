//
//  Result.swift
//  SteamDosPantallas2020
//
//  Created by Usuario on 29/01/2020.
//  Copyright © 2020 net.azarquiel. All rights reserved.
//

import UIKit

class Result: Codable {
    let datos:Datos?
    private enum CodingKeys: String, CodingKey{
        case datos = "applist"
    }
}
    
struct Datos: Codable {
    let listadeJuegos:[Apps]?
    private enum CodingKeys: String, CodingKey{
        case listadeJuegos = "apps"
    }
}
    
struct Apps: Codable {
    let nombre:String?
    let idGame:Int?
    private enum CodingKeys: String, CodingKey{
        case nombre = "name"
        case idGame = "appid"
    }
}
