//
//  AvaliacoesViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit


class AvaliacoesViewController:Acordeao {
    
    @IBOutlet var tableView:UITableView?
    
    override func viewWillAppear(_ animated: Bool) {
        self.lastCellExpanded = NoCellExpanded
        tableView?.tableFooterView = UIView()
        
        let busyAlertController: BusyAlert = {
            let busyAlert = BusyAlert(title: "Carregando...", message: "\n\nAguarde por favor!", presentingViewController: self)
            return busyAlert
        }()
        
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
                                        
                                        self.parentCellIdentifier = "header"
                                        self.childCellIdentifier = "details"
                                        self.heightParent = 130
                                        self.heightChild = 400
                                        self.self.dataSource = items
                                        self.self.numberOfCellsExpanded = .one
                                        self.self.total = self.dataSource.count
                                        
                                        self.tableView?.reloadData()
                                        
                                        busyAlertController.dismiss()
                                    })
        })
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let (_, isParentCell, _) = self.findParent(indexPath.row)
            
            if isParentCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: parentCellIdentifier , for: indexPath) as! AvaliacoesCustomViewCellHeader
                
                let a = self.dataSource[indexPath.row].item as! Avaliacao
                    cell.nome?.text = a.cafe.nome
                    cell.tipo.text = a.metodoPreparo
                    cell.data.text = a.data.description
                    //cell.gostei.stars.count =
                    
                
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: childCellIdentifier, for: indexPath) as! AvaliacoesCustomViewCellDetails
                
                let a = self.dataSource[indexPath.row-1].item as! Avaliacao
                cell.descricao?.text = a.obs
                cell.flavor.flavorUsuario = a.flavor
                cell.flavor.flavorTorrador = a.cafe.flavor
                cell.flavor.updateConstraints()
                
                let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(mostraDetalhes))
                cell.addGestureRecognizer(longPressRecognizer)
                
                return cell
            }
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
