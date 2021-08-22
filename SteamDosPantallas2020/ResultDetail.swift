//
//  ResultDetail.swift
//  SteamDosPantallas2020
//
//  Created by Usuario on 30/01/2020.
//  Copyright © 2020 net.azarquiel. All rights reserved.
//

import UIKit

class ResultDetail: Codable {
    var idGameDetail: String = ""
    let gameID:DetalleGame?
    private enum CodingKeys: String, CodingKey{
        case gameID = "idGameDetail"
    }
}

struct DetalleGame: Codable {
    let juegoSeleccionado:[GameSelected]?
    private enum CodingKeys: String, CodingKey{
        case juegoSeleccionado = "data"
    }
}

struct GameSelected: Codable {
    let descripcion:String?
    private enum CodingKeys: String, CodingKey{
        case descripcion = "short_description"
    }
}
