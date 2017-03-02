//
//  AvaliacoesViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

public enum State {
    case collapsed
    case expanded
}

public enum NumberOfCellExpanded {
    case one
    case several
}

public struct Parent {
    var state: State
    var item: Avaliacao
    
    init(state: State, item: Avaliacao) {
        self.state = state
        self.item = item
    }
}

public func != (lhs: (Int, Int), rhs: (Int, Int)) -> Bool {
    return lhs.0 != rhs.0 && rhs.1 != lhs.1
}

class AvaliacoesViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView:UITableView?
    
    open var total = 0
    let parentCellIdentifier = "header"
    let childCellIdentifier = "details"
    open var dataSource: [Parent]!
    open var numberOfCellsExpanded: NumberOfCellExpanded = .one
    let NoCellExpanded = (-1, -1)
    var lastCellExpanded : (Int, Int)!
    
    override func viewWillAppear(_ animated: Bool) {
        let busyAlertController: BusyAlert = {
            let busyAlert = BusyAlert(title: "Carregando...", message: "\n\nAguarde por favor!", presentingViewController: self)
            return busyAlert
        }()
        
        self.lastCellExpanded = NoCellExpanded
        self.tableView?.tableFooterView = UIView()
        
        busyAlertController.display()
        
        SyncUtil().getDadosFrom(url: "http://www.kaleidosblog.com/tutorial/tutorial.json",
                                trataJson: { (result: Data) in
                                    let r = SyncUtil().extract_json(jsonData: result)
                                    print("got back: \(r)")
                                    return ""
        },
                                finish: { (dados: Any) in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                        
                                        var items = Array<Parent>()
                                        
                                        for a in AvaliacoesDao().getAvaliacoes() {
                                            items.append(Parent(state: .collapsed, item: a))
                                        }
                                        
                                        self.self.dataSource = items
                                        self.self.numberOfCellsExpanded = .one
                                        self.self.total = self.dataSource.count
                                        
                                        self.tableView?.reloadData()
                                        
                                        busyAlertController.dismiss()
                                    })
        })
        
    }

    /**
     *
     *
     */
    open func updateCells(_ parent: Int, index: Int) {
        
        switch (self.dataSource[parent].state) {
            
        case .expanded:
            self.collapseSubItemsAtIndex(index, parent: parent)
            self.lastCellExpanded = NoCellExpanded
            
        case .collapsed:
            switch (numberOfCellsExpanded) {
            case .one:
                // exist one cell expanded previously
                if self.lastCellExpanded != NoCellExpanded {
                    
                    let (indexOfCellExpanded, parentOfCellExpanded) = self.lastCellExpanded
                    
                    self.collapseSubItemsAtIndex(indexOfCellExpanded, parent: parentOfCellExpanded)
                    
                    // cell tapped is below of previously expanded, then we need to update the index to expand.
                    if parent > parentOfCellExpanded {
                        let newIndex = index - 1 //self.dataSource[parentOfCellExpanded].childs.count
                        self.expandItemAtIndex(newIndex, parent: parent)
                        self.lastCellExpanded = (newIndex, parent)
                    }
                    else {
                        self.expandItemAtIndex(index, parent: parent)
                        self.lastCellExpanded = (index, parent)
                    }
                }
                else {
                    self.expandItemAtIndex(index, parent: parent)
                    self.lastCellExpanded = (index, parent)
                }
            case .several:
                self.expandItemAtIndex(index, parent: parent)
            }
        }
    }
    
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
            
            // if is not outside of dataSource boundaries
            if parent < self.dataSource.count {
                item = self.dataSource[parent]
            }
            
        } while (position < index)
        
        // if it's a parent cell the indexes are equal.
        if position == index {
            return (parent, position == index, position)
        }
        
        item = self.dataSource[parent - 1]
        return (parent - 1, position == index, position - 2)//item.childs.count - 1)
    }

    
    open func expandItemAtIndex(_ index : Int, parent: Int) {
        //let currentSubItems = self.dataSource[parent].item
        self.dataSource[parent].state = .expanded
        var insertPos = index + 1
        
        let indexPaths = (0..<1).map { _ -> IndexPath in
            let indexPath = IndexPath(row: insertPos, section: 0)
            insertPos += 1
            return indexPath
        }
        
        self.tableView?.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        self.total += 1//currentSubItems.count
    }
    
    open func collapseSubItemsAtIndex(_ index : Int, parent: Int) {
        var indexPaths = [IndexPath]()
        let numberOfChilds = 1 //self.dataSource[parent].childs.count
        self.dataSource[parent].state = .collapsed
        
        guard index + 1 <= index + numberOfChilds else { return }
        
        indexPaths = (index + 1...index + numberOfChilds).map { IndexPath(row: $0, section: 0)}
        
        self.tableView?.deleteRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        
        self.total -= numberOfChilds
    }
    
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return total
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let (parent, isParentCell, _) = self.findParent(indexPath.row)
        
        guard isParentCell else {
//            NSLog("A child was tapped!!!")
//            
//            // The value of the child is indexPath.row - actualPosition - 1
//            NSLog("The value of the child is \(self.dataSource[parent].childs[indexPath.row - actualPosition - 1])")
            
            return
        }
        
        self.tableView?.beginUpdates()
        self.updateCells(parent, index: indexPath.row)
        self.tableView?.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let (_, isParentCell, _) = self.findParent(indexPath.row)
            
            if isParentCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: parentCellIdentifier , for: indexPath) as! AvaliacoesCustomViewCellHeader
                
                let a = self.dataSource[indexPath.row].item
                
                cell.nome?.text = a.cafe.nome
                cell.tipo.text = a.metodoPreparo
                cell.data.text = a.data.description
                //cell.gostei.stars.count =
                
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: childCellIdentifier, for: indexPath) as! AvaliacoesCustomViewCellDetails
                
                let a = self.dataSource[indexPath.row-1].item
                cell.descricao?.text = a.obs
                cell.flavor.flavorUsuario = a.flavor
                cell.flavor.flavorTorrador = a.cafe.flavor
                cell.flavor.updateConstraints()
                
                let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(mostraDetalhes))
                cell.addGestureRecognizer(longPressRecognizer)
                
                return cell
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return !self.findParent(indexPath.row).isParentCell ? 330 : 110
    }
    
    func mostraDetalhes(recognizer:UILongPressGestureRecognizer){
        if ( recognizer.state == UIGestureRecognizerState.began) {
            let cell = recognizer.view as! UITableViewCell
            if let indexPath = tableView?.indexPath(for: cell){
                let row = indexPath.row
                print("Linha selecionada \(row)")
                
                show(row, handler: { action in
                    self.tableView?.reloadData()
                })
            }
            
        }
    }
    
    func show(_ indice: Int, handler: @escaping (UIAlertAction) -> Void) {
        let details = UIAlertController(title: "Um Alerta", message: "Detalhes", preferredStyle: UIAlertControllerStyle.alert)
        
        let remove = UIAlertAction(title: "Remove", style: UIAlertActionStyle.destructive, handler: handler)
        details.addAction(remove)
        
        let acao = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        details.addAction(acao)
        
        self.navigationController?.present(details, animated: true, completion: nil)
        
    }
    
}
