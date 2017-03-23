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
    
    override func viewDidAppear(_ animated: Bool)  {
        self.lastCellExpanded = NoCellExpanded
        

        let syncUtil = SyncUtil()
        
        syncUtil.criaAlerta(title: "Aguarde o carregamento...", message: "\n\n", presentingViewController: self) {
            // Faz algo quando dá cancel
        }
        
        syncUtil.display {
            syncUtil.getDadosFrom(url: "http://www.kaleidosblog.com/tutorial/tutorial.json", trataJson: { (result:Data) in
                // Trata o Json
                let resposta = syncUtil.trataJson(jsonData: result)
                return "\(resposta)"
            }, finish: {
                (dados: Any) in
                // Faz algo com o resultado do tratamento
                var items = Array<Parent>()
                
                for a:Avaliacao in Dao<Avaliacao>().list() {
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
                
                syncUtil.dismiss()
            }, onError: {
                () in
                // Fal algo quando dá erro
                syncUtil.dismiss()
            })
        }

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let avaliacao = self.dataSource[indexPath.row].item as! Avaliacao
            
            if avaliacao.cafe != nil { Dao<Cafe>().delete(avaliacao.cafe!) }
            if avaliacao.flavor != nil { Dao<Flavor>().delete(avaliacao.flavor!) }
            if avaliacao.flavorMedia != nil { Dao<Flavor>().delete(avaliacao.flavorMedia!) }
            Dao<Avaliacao>().delete(avaliacao)
            
            var items = Array<Parent>()
            for a:Avaliacao in Dao<Avaliacao>().list() {
                items.append(Parent(state: .collapsed, item: a))
            }
            self.dataSource = items
            self.self.total = self.dataSource.count

            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let (parent, isParentCell, _) = self.findParent(indexPath.row)
            
            if isParentCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: parentCellIdentifier , for: indexPath) as! AvaliacoesCustomViewCellHeader
                
                let a = self.dataSource[parent].item as! Avaliacao
                cell.nome?.text = a.cafe?.nome
                cell.tipo.text = a.metodoPreparo
                cell.data.text = a.data?.description
                //cell.gostei.stars.count =
                
                
                let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(mostraDetalhes))
                cell.addGestureRecognizer(longPressRecognizer)
                
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: childCellIdentifier, for: indexPath) as! AvaliacoesCustomViewCellDetails
                
                let a = self.dataSource[parent].item as! Avaliacao
                cell.descricao?.text = a.obs
                cell.flavor.flavorUsuario = a.flavor
                cell.flavor.flavorTorrador = a.cafe?.flavorTorrador
                cell.flavor.flavorMedia = a.flavorMedia
                cell.flavor.updateConstraints()
                
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
