//
//  ViewController.swift
//  Lista
//
//  Created by COTEMIG on 17/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var Listadetarefas:[String] = [];
    let listakey = "listadetarefas"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        
        if let lista = UserDefaults.standard.value(forKey: listakey) as?[String]{
            Listadetarefas.append(contentsOf: lista)
            tableView.reloadData();
        }
    }


    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "Nova tarefa",
                                      message: "Adicione uma nova tarefa",
                                      preferredStyle: .alert)
        
        let salvar = UIAlertAction(title: "Salvar", style: .default) { (action) in
            
        if let textField = alert.textFields?.first, let tarefa = textField.text{
            self.Listadetarefas.append(tarefa)
            UserDefaults.standard.set(self.Listadetarefas,forKey: self.listakey)
            self.tableView.reloadData()
        }
            
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addTextField()
        alert.addAction(salvar)
        alert.addAction(cancelar)
        
        present(alert,animated: true)
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Listadetarefas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Listadetarefas[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            Listadetarefas .remove(at: indexPath.row)
            UserDefaults.standard.set(self.Listadetarefas,forKey: self.listakey)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

