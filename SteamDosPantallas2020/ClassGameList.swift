//
//  ClassGameList.swift
//  SteamDosPantallas2020
//
//  Created by Usuario on 29/01/2020.
//  Copyright © 2020 net.azarquiel. All rights reserved.
//

import UIKit

class ClassGameList: UITableViewController {


    @IBOutlet var tvTableView: UITableView!
    var result: Result?
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonDecoding()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func jsonDecoding() {
        let  urlTxt="http://api.steampowered.com/ISteamApps/GetAppList/v0002/"
        guard let url = URL(string: urlTxt) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {return}
                do {
                    self.result =  try JSONDecoder().decode(Result.self, from: data)
                    //self.pintaCurrent()
                    DispatchQueue.main.async {
                        self.tvTableView.reloadData()
                    }
                } catch let jsonErr {
                    print("Error serializing json", jsonErr)
                }
        }.resume()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let n = result?.datos?.listadeJuegos?.count{
            return n
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaID", for: indexPath) as! ClassCeldaGame
        
        let juegos = result?.datos?.listadeJuegos![indexPath.row]
        //Datos TableView
        DispatchQueue.main.async {
            //Resto de datos
            guard let identificador = juegos?.idGame else {return}
            celda.lblIDCelda.text = "\(identificador)"
            guard let nombre = juegos?.nombre else {return}
            celda.lblNombreCelda.text = nombre
        }
        return celda
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        let game = result!.datos?.listadeJuegos![indexPath!.row]
        let controller = segue.destination as! ClassDetailGame
        
        controller.idg = (game?.idGame)!
        controller.nameg = (game?.nombre)!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
