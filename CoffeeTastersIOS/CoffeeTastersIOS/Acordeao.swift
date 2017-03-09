//
//  Acordeao.swift
//  MapaExemplo
//
//  Created by Ettore Luglio on 3/2/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit

public enum State {
    /// Acordeao Fechado
    case collapsed
    /// Acordeao Aberto
    case expanded
}

public enum NumberOfCellExpanded {
    /// Um expandido por vez
    case one
    /// Todos podem ser expandidos
    case several
}

/// Item do Acordeao
public struct Parent {
    var state: State
    var item: AnyObject
    
    init(state: State, item: AnyObject) {
        self.state = state
        self.item = item
    }
}

public func != (lhs: (Int, Int), rhs: (Int, Int)) -> Bool {
    return lhs.0 != rhs.0 && rhs.1 != lhs.1
}

/// Classe filha de UIViewController e implementa UITableViewDelegate e UITableViewDataSource para fazer o efeito de acordeao nas listas que tem somente **UM** filho
class Acordeao: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    open var total = 0
    var parentCellIdentifier = "header"
    var childCellIdentifier = "details"
    var heightParent = 100
    var heightChild = 50
    open var dataSource: [Parent]!
    open var numberOfCellsExpanded: NumberOfCellExpanded = .one
    let NoCellExpanded = (-1, -1)
    var lastCellExpanded : (Int, Int)!
    
    /**
     Expande o Item adicionando linhas à tableView
     
     - Parameter tableView: A lista
     - Parameter index: Posicao que será inserido na lista
     - Parameter parent: Posicao do ITEM completo
     
     */
    open func expandItemAtIndex(tableView: UITableView, index : Int, parent: Int) {
        self.dataSource[parent].state = .expanded
        var insertPos = index + 1
        
        let indexPaths = (0..<1).map { _ -> IndexPath in
            let indexPath = IndexPath(row: insertPos, section: 0)
            insertPos += 1
            return indexPath
        }
        
        tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        self.total += 1
    }
    
    /**
     Colapsa o Item removendo linhas da tableView
     
     - Parameter tableView: A lista
     - Parameter index: Posicao que será inserido na lista
     - Parameter parent: Posicao do ITEM completo
     
     */
    open func collapseSubItemsAtIndex(tableView: UITableView, index : Int, parent: Int) {
        var indexPaths = [IndexPath]()
        let numberOfChilds = 1
        self.dataSource[parent].state = .collapsed
        
        guard index + 1 <= index + numberOfChilds else { return }
        
        indexPaths = (index + 1...index + numberOfChilds).map { IndexPath(row: $0, section: 0)}
        
        tableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        
        self.total -= numberOfChilds
    }
    
    /**
     Atualiza as células com relação a colapsar e expandir
     
     - Parameter tableView: A lista
     - Parameter index: Posicao que será inserido na lista
     - Parameter parent: Posicao do ITEM completo
     
     */
    open func updateCells(tableView: UITableView, parent: Int, index: Int) {
        
        switch (self.dataSource[parent].state) {
            
        case .expanded:
            self.collapseSubItemsAtIndex(tableView: tableView, index: index, parent: parent)
            self.lastCellExpanded = NoCellExpanded
            
        case .collapsed:
            switch (numberOfCellsExpanded) {
            case .one:
                if self.lastCellExpanded != NoCellExpanded {
                    
                    let (indexOfCellExpanded, parentOfCellExpanded) = self.lastCellExpanded
                    
                    self.collapseSubItemsAtIndex(tableView: tableView, index: indexOfCellExpanded, parent: parentOfCellExpanded)
                    
                    if parent > parentOfCellExpanded {
                        let newIndex = index - 1
                        self.expandItemAtIndex(tableView: tableView, index:newIndex, parent: parent)
                        self.lastCellExpanded = (newIndex, parent)
                    }
                    else {
                        self.expandItemAtIndex(tableView: tableView, index: index, parent: parent)
                        self.lastCellExpanded = (index, parent)
                    }
                }
                else {
                    self.expandItemAtIndex(tableView: tableView, index: index, parent: parent)
                    self.lastCellExpanded = (index, parent)
                }
            case .several:
                self.expandItemAtIndex(tableView: tableView, index: index, parent: parent)
            }
        }
    }
    
    /**
     Acha o item no delegate
     
     - Parameter index: posicao na tabela
     - Returns posicao do item, se é o header ou o details e a posicao atual na lista, caso seja um child
     
     */
    open func findParent(_ index : Int) -> (parent: Int, isParentCell: Bool, actualPosition: Int) {
        
        var position = 0, parent = 0
        guard position < index else { return (parent, true, parent) }
        
        var item = self.dataSource[parent]
        
        repeat {
            
            switch (item.state) {
            case .expanded:
                position += 1 + 1
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
        return (parent - 1, position == index, position - 2)
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
