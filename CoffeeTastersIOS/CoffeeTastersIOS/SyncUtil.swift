//
//  SyncUtil.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 2/28/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class SyncUtil {
    
//    var TableData:Array<String> = Array<String>()
    
    func getDadosFrom(url: String, trataJson: @escaping (_ result: Data) -> String, finish: @escaping (_ dados: Any) -> Void, onError: @escaping () -> Void){
        
        guard let url2 = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest2 = URLRequest(url: url2)
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 3
        config.timeoutIntervalForResource = 3
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest2 as URLRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                onError()
                return
            }
            
            finish(dados: trataJson(data!))
            
        })
        task.resume()
    }

    func extract_json(jsonData:Data) -> String {
//        let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
//            if let countries_list = json as? Array<Any> {
//                for i in 0 ..< countries_list.count {
//                    if let country_obj = countries_list[i] as? NSDictionary {
//                        if let country_name = country_obj["country"] as? String {
//                            if let country_code = country_obj["code"] as? String {
//                                TableData.append(country_name + " [" + country_code + "]")
//                                print("\(country_name) [\(country_code)]")
//                            }
//                        }
//                    }
//                }
//            }
        DispatchQueue.main.async(execute: {
            //self.tableView.reloadData()
            return
        })
        return ""
    }
    
    
    //    override func viewDidLoad() {
    //        let busyAlertController: BusyAlert = {
    //            let busyAlert = BusyAlert(title: "Carregando...", message: "\n\nAguarde por favor!", presentingViewController: self)
    //            return busyAlert
    //        }()
    //
    //        busyAlertController.display()
    //
    //        SyncUtil().getDadosFrom(url: "http://www.kaleidosblog.com/tutorial/tutorial.json",
    //                                trataJson: { (result: Data) in
    //                                    let r = SyncUtil().extract_json(jsonData: result)
    //                                    print("got back: \(r)")
    //                                    return ""
    //        },
    //                                finish: { (dados: Any) in
    //                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
    //
    //                                        self.data = ProdutoDao().getProdutos(comOferta: false)
    //                                        self.tableView?.reloadData()
    //                                        busyAlertController.dismiss()
    //                                    })
    //        })
    //    }
        
}
