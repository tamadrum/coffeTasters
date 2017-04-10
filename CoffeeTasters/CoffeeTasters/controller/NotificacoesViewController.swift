//
//  NotificacoesViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NotificacoesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?APPID=5bcaf752f78fcba6b4dc5f9d36e9df2e&units=metric"
    var activityIndicator: UIActivityIndicatorView?
    @IBOutlet var tableView:UITableView?
    var notificacoes:[Notificacao] = []
    
    // MARK: Ciclo de vida
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        tableView?.tableHeaderView = activityIndicator
        activityIndicator?.startAnimating()
        notificacoes.removeAll()
        tableView?.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let param = ["lon" : 0, "lat" : 0]
        let alamofire = Alamofire.request(URL_BASE , parameters: param)
        alamofire.responseJSON(completionHandler: {
            response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
//                let j = JSON as! NSDictionary
                //let temp = Temperatura(JSON: j as! [String : Any])
                //print(temp?.condicao!)
                
                let m = "{\"tipo\":2, \"mensagem\": \"Um texto legal....\"}"
                let n = Notificacao(JSONString: m)
                
                self.notificacoes.append(n!)
                
                self.tableView?.reloadData()
                
                self.activityIndicator?.stopAnimating()
            }
        })
    }
    
    // MARK: Coisas de tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificacoes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! NotificacaoCustomCell
        
        cell.statusNotificacao.image = #imageLiteral(resourceName: "cafe")
        cell.textoNotificacao.text = notificacoes[indexPath.row].mensagem
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
