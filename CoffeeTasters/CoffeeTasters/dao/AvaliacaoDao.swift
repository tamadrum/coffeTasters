//
//  AvaliacaoDao.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 4/10/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class AvaliacaoDao: Dao<Avaliacao> {
    
    func getListaCafeterias () -> [String] {
        var retorno:[String] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: banco!)
        fetchRequest.propertiesToFetch = ["localPreparo"]
        fetchRequest.returnsDistinctResults = true
        fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            let resultsDict = results as! [[String: String]]
            
            for r in resultsDict {
                retorno.append(r["localPreparo"]!)
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return retorno
    }
    
}
