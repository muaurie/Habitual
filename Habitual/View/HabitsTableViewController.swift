//
//  MainViewController.swift
//  Habitual
//
//  Created by Cherish Spikes on 3/13/23.
//

import UIKit

class HabitsTableViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHabit = persistence.habits[indexPath.row]
           let habitDetailVC = HabitDetailViewController.instantiate()
           habitDetailVC.habit = selectedHabit
           habitDetailVC.habitIndex = indexPath.row
           navigationController?.pushViewController(habitDetailVC, animated: true)
       
    }
    private var persistence = PersistenceLayer()
   //reload data
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        persistence.setNeedsToReloadHabits()
        tableView.reloadData()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar() // Call the new method
        tableView.register( //register the cell
          HabitTableViewCell.nib,
          forCellReuseIdentifier: HabitTableViewCell.identifier
        )

        // Do any additional setup after loading the view.
        }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistence.habits.count //change to reference the array
        //tells table view how many rows to display
        }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.identifier, for: indexPath) as! HabitTableViewCell
        let habit = persistence.habits[indexPath.row]
           cell.configure(habit)
           return cell
        
       }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      switch editingStyle {
      case .delete:
        // handling the delete action
          let habitToDelete = persistence.habits[indexPath.row]
          let habitIndexToDelete = indexPath.row
          // Create an instance of UIAlertController
          let deleteAlert = UIAlertController(habitTitle: habitToDelete.title) {
            // The alert is confirmed delete the habit
            self.persistence.delete(habitIndexToDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
          }
          // Show the Alert Controller
          self.present(deleteAlert, animated: true)
      default:
        break
      }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
      persistence.swapHabits(habitIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
   }

        //A "cell" is one row displayed by the tableview. In this case, all of the rows display the same thing: "Hello, world!"
       
        //configure a cell with a string from the array/update with text equal to the string at that indexPath.row.
    // Add the extension
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


extension HabitsTableViewController {
    func setupNavBar() {
        title = "Habitual" // Add a title to the nav bar
        // Create a UIBarButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddHabit(_:)))
        // Add the barbuttonitem to the navbar on the right side
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // This function handle taps on the bar button item, see #selector above
        @objc func pressAddHabit(_ sender: UIBarButtonItem) {
            //create new instance of addhabit view.
            let addHabitVC = AddHabitViewController.instantiate()
            //instance of ui navigation controller to switch between views
            let navigationController = UINavigationController(rootViewController: addHabitVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
           
        }
        //inserts a new row at the given IndexPath. In our case, it'll add a new row to the top of the table view.
       //[info] You must update the dataSource, in our case the names array, BEFORE you use tableView.insertRows(at:with:). Otherwise, you'll get an inconsistency error in your debugger. The table view will fact-check by invoking the number of rows.
    }

extension UIAlertController {
  convenience init(habitTitle: String, comfirmHandler: @escaping () -> Void) {
    self.init(title: "Delete Habit", message: "Are you sure you want to delete \(habitTitle)?", preferredStyle: .actionSheet)

    let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
      comfirmHandler()
    }
    self.addAction(confirmAction)

    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    self.addAction(cancelAction)
  }
}





