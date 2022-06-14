//
//  ViewController.swift
//  Tasks
//
//  Created by Fırat Kahvecioğlu on 11.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup
        if !UserDefaults().bool(forKey: "setUp"){
            UserDefaults.standard.set(true, forKey: "setUp")
            UserDefaults.standard.set(0, forKey: "count")
            
            
            
        }
        updateTasks()
    }
    
    func updateTasks (){
        
        tasks.removeAll()
        
        guard let count = UserDefaults.standard.value(forKey: "count") as? Int else{
            return
        }
        
        for x in 0..<count{
            if let task = UserDefaults.standard.value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        
        tableView.reloadData()
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
        let entryVC = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        entryVC.title = "New Task"
        entryVC.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
            
            
        }
        navigationController?.pushViewController(entryVC, animated: true)
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        let taskVC = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskViewController
        taskVC.title = "Task"
        taskVC.task = tasks[indexPath.row]
        navigationController?.pushViewController(taskVC, animated: true)
    
    
    }
    
    
}

extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
}
