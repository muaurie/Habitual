//
//  HabitDetailViewController.swift
//  Habitual
//
//  Created by Cherish Spikes on 4/12/23.
//

import UIKit

class HabitDetailViewController: UIViewController {
    
    var habit: Habit!
    var habitIndex: Int!
    
    private var persistence = PersistenceLayer()
    
    @IBOutlet weak var labelCurrentStreak: UILabel!
    @IBOutlet weak var labelTotalCompletions: UILabel!
    @IBOutlet weak var labelStartingDate: UILabel!
    @IBOutlet weak var buttonAction: UIButton!
    @IBOutlet weak var labelBestStreak: UILabel!
    
    @IBAction func pressActionButton(_ sender: Any) {
        //call this method
        habit = persistence.markHabitAsCompleted(habitIndex)
            updateUI()
    }
    @IBOutlet weak var imageViewIcon: UIImageView!
    
    private func updateUI() {
        //update UI when "task complete" button is tapped
        title = habit.title
        imageViewIcon.image = habit.selectedImage.image
        labelCurrentStreak.text = "\(habit.currentStreak) days"
        labelTotalCompletions.text = String(habit.numberOfCompletions)
        labelBestStreak.text = String(habit.bestStreak)
        labelStartingDate.text = habit.dateCreated.stringValue

        if habit.completedToday {
            buttonAction.setTitle("Completed for Today!", for: .normal)
        } else {
            buttonAction.setTitle("Mark as Completed", for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        //invoke updateUI
        updateUI()

       }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
