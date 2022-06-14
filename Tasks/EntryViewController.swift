//
//  EntryViewController.swift
//  Tasks
//
//  Created by Fırat Kahvecioğlu on 11.06.2022.
//

import UIKit

class EntryViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var taskNameField: UITextField!

    var update : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskNameField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         saveTask()
        return true
    }

    @objc func saveTask(){
        
        guard let text = taskNameField.text, !text.isEmpty else {
            return
        }
        
        guard let  count = UserDefaults.standard.value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults.standard.set(newCount, forKey: "count")
        UserDefaults.standard.set(text, forKey: "task_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
        
    }

}
