//
//  SyncUtil.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 2/28/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class SyncUtil {
    
    var TableData:Array<String> = Array<String>()
    
//    get_data_from_url("http://www.kaleidosblog.com/tutorial/tutorial.json")
    
    func get_data_from_url(url:String) {
        guard let url2 = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest2 = URLRequest(url: url2)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest2 as URLRequest, completionHandler: { (data, response, error) in
            self.extract_json(jsonData: data!)
        })
        task.resume()

    }

    func extract_json(jsonData:Data){
        let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
            if let countries_list = json as? Array<Any> {
                for i in 0 ..< countries_list.count {
                    if let country_obj = countries_list[i] as? NSDictionary {
                        if let country_name = country_obj["country"] as? String {
                            if let country_code = country_obj["code"] as? String {
                                TableData.append(country_name + " [" + country_code + "]")
                                print("\(country_name) [\(country_code)]")
                            }
                        }
                    }
                }
            }
        DispatchQueue.main.async(execute: {
            //self.tableView.reloadData()
            return
        })
    }
        
}
