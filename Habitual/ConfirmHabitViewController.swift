//
//  ConfirmHabitViewController.swift
//  Habitual
//
//  Created by Cherish Spikes on 4/10/23.
//

import UIKit

class ConfirmHabitViewController: UIViewController {
    var habitImage: Habit.Images!
    
    @IBOutlet weak var habitImageView: UIImageView!
    
    @IBOutlet weak var habitNameInputField: UITextField!
    
    @IBAction func createHabitButtonPressed(_ sender: Any) {
        var persistenceLayer = PersistenceLayer()
        //instance persistence layer, where the habit data is stored
        guard let habitText = habitNameInputField.text else { return }
        //get text entered in habitNameInputField, optional. Use guard statement to unwrap text and exit function early.
        persistenceLayer.createNewHabit(name: habitText, image: habitImage)
        //then create a new habit and provide its name and image
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        //then dismiss modal view.
   
    }
    
    private func updateUI() {
        title = "New Habit"
        habitImageView.image = habitImage.image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
