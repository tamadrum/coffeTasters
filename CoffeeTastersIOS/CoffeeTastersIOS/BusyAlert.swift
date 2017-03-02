import Foundation
import UIKit

protocol BusyAlertDelegate {
    func didCancelBusyAlert()
}


class BusyAlert {
    
    var busyAlertController: UIAlertController?
    var presentingViewController: UIViewController?
    var activityIndicator: UIActivityIndicatorView?
    var delegate:BusyAlertDelegate?
    
    init (title:String, message:String, presentingViewController: UIViewController) {
        busyAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
//        busyAlertController!.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel Button"), style: UIAlertActionStyle.cancel, handler:{(alert: UIAlertAction!) in
//            self.delegate?.didCancelBusyAlert()
//        }))
        self.presentingViewController = presentingViewController
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        busyAlertController!.view.addSubview(activityIndicator!)
    }
    
    func display() {
        DispatchQueue.main.async(execute: {
            self.presentingViewController!.present(self.busyAlertController!, animated: true, completion: {
                self.activityIndicator!.translatesAutoresizingMaskIntoConstraints = false
                self.busyAlertController!.view.addConstraint(NSLayoutConstraint(item: self.activityIndicator!, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.busyAlertController!.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
                self.busyAlertController!.view.addConstraint(NSLayoutConstraint(item: self.activityIndicator!, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.busyAlertController!.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
                self.activityIndicator!.startAnimating()
                
            })
        })
        
    }
    
    func dismiss() {
        DispatchQueue.main.async(execute: {
            self.busyAlertController?.dismiss(animated: true, completion: nil)
        })
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
