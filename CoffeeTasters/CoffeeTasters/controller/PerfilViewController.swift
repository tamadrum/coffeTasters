//
//  PerfilViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/30/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class PerfilViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var buscarCafes: UITextField!
    @IBOutlet weak var cabecalhoBuscaView: UIView!

    @IBOutlet weak var tableView: UITableView!
    var searchActive : Bool = false
    var data:[Cafe] = []
    var filtered:[Cafe] = []
    
    var tamanhoTabelaBusca:CGFloat = 0
    var alturaCabecalho:CGFloat = 110
    let alturaFixaNavigationBar:CGFloat = 64
    
    let usuario = Usuario()
    
    @IBOutlet weak var qtdAvaliacoes: UILabel!
    @IBOutlet weak var qtdCafes: UILabel!
    @IBOutlet weak var qtdCafeterias: UILabel!
    @IBOutlet weak var nomeUsuario: UILabel!
    @IBOutlet weak var sobrenomeUsuario: UILabel!
    @IBOutlet weak var emailUsuario: UILabel!
    @IBOutlet weak var imagemUsuario: UIImageView!
    
    @IBAction func irParaAvaliacoes(_ sender: UIButton) {
        if tabBarController != nil {
            tabBarController?.selectedIndex = 2;
        }
    }
    
    // MARK: Coisas da busca
    
    @IBAction func textoMudou(_ sender: UITextField) {
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.frame.origin.y = self.alturaCabecalho
        })
        
        filtered = data.filter({ (cafe) -> Bool in
            if cafe.nome?.lowercased().range(of: (sender.text?.lowercased())!) != nil {
                return true
            }
            else {
                return false
            }
        })
        
        if(filtered.count == 0){
            searchActive = true;
        } else {
            searchActive = true;
        }
        
        print("Vou carregar os dados na tabela")
        self.tableView?.reloadData()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchActive = false;
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchActive = true;
    }

    @IBAction func clicouBuscaCafe(_ sender: UITextField) {
        searchActive = false;
    }
    
    
    @IBAction func cancelarBuscaCafe(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.frame.origin.y = -(self.tamanhoTabelaBusca+self.alturaCabecalho)
            self.buscarCafes.text = ""
        })
        
        searchActive = false;
        dismissKeyboard()
    }
    
    // MARK: Ciclo de vida
    
    override func viewWillAppear(_ animated: Bool) {
        usuario.load()
        if ( usuario.perfilImg == "FOTO" ) {
            imagemUsuario.image = usuario.imagem
        } else {
            if usuario.perfilImg != "" {
                imagemUsuario.af_setImage(withURL: URL(string: usuario.perfilImg)!)
            }
        }
        
        nomeUsuario.text = usuario.nome
        sobrenomeUsuario.text = usuario.sobrenome
        emailUsuario.text = usuario.email
        
        qtdCafeterias.text = "\(AvaliacaoDao().getListaCafeterias().count)"
        qtdAvaliacoes.text = "\(AvaliacaoDao().count())"
        qtdCafes.text = "\(AvaliacaoDao().getListaCafes().count)"
        
        data = Dao<Cafe>().list()
//        qtdCafes.text = "\(data.count)"
        
        data.sort(by: {(cafe1, cafe2) -> Bool in
            return cafe1.nome!<cafe2.nome!
        })
        
        alturaCabecalho = cabecalhoBuscaView.frame.height + alturaFixaNavigationBar
        
        tableView?.reloadData()
    
        NotificationCenter.default.addObserver(self, selector: #selector(mostraTeclado(notification:)),
                    name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        buscarCafes.rightViewMode = .unlessEditing
        buscarCafes.rightView = UIImageView(image: #imageLiteral(resourceName: "search"))
    }
    
    func mostraTeclado(notification: Notification) {
        
        let info = notification.userInfo!
        let keyboardFrame:CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        tamanhoTabelaBusca = CGFloat(self.view.frame.height - keyboardFrame.height - alturaCabecalho)
        
        self.tableView.reloadData()
        self.tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: tamanhoTabelaBusca);
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Coisas da tabela
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count+1
        }
        return data.count+1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! BuscaResultCustomCell
        
        if(searchActive){
            if ( indexPath.row == filtered.count ) {
                cell.nome?.text = "Adicionar um Café"
                cell.imagemLogo?.image = #imageLiteral(resourceName: "cafe")
            } else {
                cell.nome?.text = filtered[indexPath.row].nome
                cell.imagemLogo?.image = filtered[indexPath.row].imagem as? UIImage
            }
        } else {
            if ( indexPath.row == data.count ) {
                cell.nome?.text = "Adicionar um Café"
                cell.imagemLogo?.image = #imageLiteral(resourceName: "cafe")
            } else {
                cell.nome?.text = data[indexPath.row].nome
                cell.imagemLogo?.image = data[indexPath.row].imagem as? UIImage
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.frame.origin.y = -(self.tamanhoTabelaBusca+self.alturaFixaNavigationBar)
        })
        
        dismissKeyboard()
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let viewDetalhes = storyboard.instantiateViewController(withIdentifier: "detalhesCafe") as! DetalhesCafeController
        let viewAvaliacao = storyboard.instantiateViewController(withIdentifier: "avaliacao") as! AvaliacaoViewController
        
        if(searchActive){
            print("filtered - \(indexPath.row) - \(filtered.count)")
            if ( indexPath.row < filtered.count ) {
                viewDetalhes.cafeAvaliado = filtered[indexPath.row]
                navigationController?.pushViewController(viewDetalhes, animated: true)
            } else {
                navigationController?.pushViewController(viewAvaliacao, animated: true)
            }
        } else {
            print("data - \(indexPath.row) - \(filtered.count)")
            if ( indexPath.row < filtered.count ) {
                viewDetalhes.cafeAvaliado = filtered[indexPath.row]
                navigationController?.pushViewController(viewDetalhes, animated: true)
            } else {
                navigationController?.pushViewController(viewAvaliacao, animated: true)
            }
        }
    }
}
