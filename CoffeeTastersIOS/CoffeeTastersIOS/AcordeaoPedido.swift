//
//  Acordeao.swift
//  MapaExemplo
//
//  Created by Ettore Luglio on 3/2/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit

class AcordeaoPedido: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    open var total = 0
    var parentCellIdentifier = "header"
    var childCellIdentifier = "details"
    var heightParent = 100
    var heightChild = 50
    open var dataSource: [Parent]!
    open var numberOfCellsExpanded: NumberOfCellExpanded = .one
    let NoCellExpanded = (-1, -1)
    var lastCellExpanded : (Int, Int)!
    
    open func expandItemAtIndex(tableView: UITableView, index : Int, parent: Int) {
        let pedido = self.dataSource[parent].item as! Pedido
        let items = pedido.items?.allObjects as! [Item]
        
        let currentSubItems = items.count
        self.dataSource[parent].state = .expanded
        var insertPos = index + 1
            
        let indexPaths = (0..<currentSubItems).map { _ -> IndexPath in
            let indexPath = IndexPath(row: insertPos, section: 0)
            insertPos += 1
            return indexPath
        }
        tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        
        total += currentSubItems
        print("ACD Expandindo: \(currentSubItems)")
    }
    
    open func collapseSubItemsAtIndex(tableView: UITableView, index : Int, parent: Int) {
        var indexPaths = [IndexPath]()
        let pedido = self.dataSource[parent].item as! Pedido
        let numberOfChilds = pedido.items?.count
        self.dataSource[parent].state = .collapsed
        
        guard index + 1 <= index + numberOfChilds! else { return }
        
        indexPaths = (index + 1...index + numberOfChilds!).map { IndexPath(row: $0, section: 0)}
        
        tableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        
        self.total -= numberOfChilds!
        print("ACD Colapsando: \(numberOfChilds!)")
    }
    
    open func updateCells(tableView: UITableView, parent: Int, index: Int) {
        
        switch (self.dataSource[parent].state) {
            
        case .expanded:
            self.collapseSubItemsAtIndex(tableView: tableView, index:index, parent: parent)
            self.lastCellExpanded = NoCellExpanded
            
        case .collapsed:
            switch (numberOfCellsExpanded) {
            case .one:
                // exist one cell expanded previously
                if self.lastCellExpanded != NoCellExpanded {
                    
                    let (indexOfCellExpanded, parentOfCellExpanded) = self.lastCellExpanded
                    
                    self.collapseSubItemsAtIndex(tableView: tableView, index:indexOfCellExpanded, parent: parentOfCellExpanded)
                    
                    // cell tapped is below of previously expanded, then we need to update the index to expand.
                    if parent > parentOfCellExpanded {
                        let pedido = self.dataSource[parentOfCellExpanded].item as! Pedido
                        let newIndex = index - (pedido.items?.count)!
                        self.expandItemAtIndex(tableView: tableView, index:newIndex, parent: parent)
                        self.lastCellExpanded = (newIndex, parent)
                    }
                    else {
                        self.expandItemAtIndex(tableView: tableView, index:index, parent: parent)
                        self.lastCellExpanded = (index, parent)
                    }
                }
                else {
                    self.expandItemAtIndex(tableView: tableView, index:index, parent: parent)
                    self.lastCellExpanded = (index, parent)
                }
            case .several:
                self.expandItemAtIndex(tableView: tableView, index:index, parent: parent)
            }
        }
    }
    
    open func findParent(_ index : Int) -> (parent: Int, isParentCell: Bool, actualPosition: Int) {
        
        var position = 0, parent = 0
        guard position < index else { return (parent, true, parent) }
        
        var item = self.dataSource[parent]
        var pedido = item.item as! Pedido
        
        repeat {
            
            switch (item.state) {
            case .expanded:
                position += (pedido.items?.count)! + 1
            case .collapsed:
                position += 1
            }
            
            parent += 1
            
            if parent < self.dataSource.count {
                item = self.dataSource[parent]
            }
            
        } while (position < index)
        
        if position == index {
            return (parent, position == index, position)
        }
        
        item = self.dataSource[parent - 1]
        pedido = item.item as! Pedido
        return (parent - 1, position == index, position - pedido.items!.count - 1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return !self.findParent(indexPath.row).isParentCell ? CGFloat(heightChild) : CGFloat(heightParent)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let (parent, isParentCell, _) = self.findParent(indexPath.row)
        
        guard isParentCell else {
            return
        }
        
        tableView.beginUpdates()
        updateCells(tableView: tableView, parent: parent, index: indexPath.row)
        tableView.endUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.lastCellExpanded = NoCellExpanded
    }
    
}
