//
//  SyncUtil.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 2/28/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class SyncUtil {
    
    var busyAlertController: UIAlertController?
    var presentingViewController: UIViewController?
    var activityIndicator: UIActivityIndicatorView?
    
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

    func trataJson(jsonData:Data) -> String {
        let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
            if let countries_list = json as? Array<Any> {
                for i in 0 ..< countries_list.count {
                    if let country_obj = countries_list[i] as? NSDictionary {
                        if let country_name = country_obj["country"] as? String {
                            if let country_code = country_obj["code"] as? String {
                                print("\(country_name) [\(country_code)]")
                            }
                        }
                    }
                }
            }
        DispatchQueue.main.async(execute: {
            return
        })
        return jsonData.description
    }
    
    
    
    
    
    
    func submitAction(sender: AnyObject) {
        
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        
        let parameters = ["name": "Ettore", "password": "amor"] as Dictionary<String, String>
        
        //create the url with URL
        let url = URL(string: "http://myServerName.com/api")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    
    
    
    
    

    
    func criaAlerta (title:String, message:String, presentingViewController: UIViewController, onCancel: @escaping () -> Void) {
        busyAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                busyAlertController!.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel Button"), style: UIAlertActionStyle.cancel, handler:{(alert: UIAlertAction!) in
                    onCancel()
                }))
        
        self.presentingViewController = presentingViewController
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        busyAlertController!.view.addSubview(activityIndicator!)
    }
    
    func display(toDo: @escaping () -> Void) {
        DispatchQueue.main.async(execute: {
            self.presentingViewController!.present(self.busyAlertController!, animated: true, completion: {
                self.activityIndicator!.translatesAutoresizingMaskIntoConstraints = false
                
                self.busyAlertController!.view.addConstraint(NSLayoutConstraint(item: self.activityIndicator!, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.busyAlertController!.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
                
                self.busyAlertController!.view.addConstraint(NSLayoutConstraint(item: self.activityIndicator!, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.busyAlertController!.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
                
                self.activityIndicator!.startAnimating()
                
                toDo()
            })
        })
    }
    
    func dismiss() {
        DispatchQueue.main.async(execute: {
            self.busyAlertController?.dismiss(animated: true, completion: nil)
        })
    }
}
