//
//  ClassDetailGame.swift
//  SteamDosPantallas2020
//
//  Created by Usuario on 29/01/2020.
//  Copyright © 2020 net.azarquiel. All rights reserved.
//

import UIKit

class ClassDetailGame: UIViewController {

    @IBOutlet weak var lblIdDetail: UILabel!
    @IBOutlet weak var lblNombreDetail: UILabel!
    @IBOutlet weak var lblDetalleDetail: UILabel!
    var idg: Int = 0
    var idgString: String = ""
    var nameg: String = ""
    var gameName: String = "gameName"
    var resultDetail: ResultDetail?
    //var dataToString: String = ""
    //var stringToData: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idgString = String(idg)

        jsonDecoding()
        // Do any additional setup after loading the view.
    }
    
    func jsonDecoding() {
        let  urlTxt="http://store.steampowered.com/api/appdetails/?appids=\(idg)"
        guard let url = URL(string: urlTxt) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {return}
            //Convertir de data a string
            let dataAsString = String(decoding: data, as: UTF8.self)
            //Reemplazar el id por un nombre fijo
            let stringConverter = dataAsString.replacingOccurrences(of: "{\"\(self.idgString)\":", with: "{\"gameName\":")
            //print(stringConverter)
            //Convertir de string a data
            let stringAsData = stringConverter.data(using: .utf8)
            guard let stingAsDataUNW = stringAsData else {return}
                do {
                    self.resultDetail =  try JSONDecoder().decode(ResultDetail.self, from: stingAsDataUNW)
                    DispatchQueue.main.async {
                        self.pintaSegundaPantalla()
                    }
                } catch let jsonErr {
                    print("Error serializing json", jsonErr)
                }
        }.resume()
    }
    
    func pintaSegundaPantalla(){
        
        //resultDetail?.idGameDetail = gameName
        //let seconSreen = resultDetail?.gameID?.juegoSeleccionado![0]
        //print(seconSreen)
        //let desc = seconSreen!.descripcion
        //guard let descUNW = desc else {return}
        DispatchQueue.main.async {
            self.lblIdDetail.text = self.idgString
            self.lblNombreDetail.text = self.nameg
            self.lblDetalleDetail.text = self.resultDetail?.gameID?.juegoSeleccionado![1].descripcion
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
