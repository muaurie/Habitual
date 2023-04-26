//
//  Habit.swift
//  Habitual
//
//  Created by Cherish Spikes on 3/20/23.
//

import UIKit

//store a single struct or class in a file with the same as the class or struct defined in that file.
//nsme structs with an uppercase letter
struct Habit: Codable {
    enum Images: Int, CaseIterable, Codable{
           case book
           case bulb
           case clock
           case code
           case drop
           case food
           case grow
           case gym
           case heart
           case lotus
           case other
           case pet
           case pill
           case search
           case sleep
           case tooth

           var image: UIImage {
               guard let image = UIImage(named: String(describing: self)) else {
                   fatalError("image \(self) not found")
               }

               return image
           }
       }
    var title: String
    let dateCreated: Date = Date() //1. notice this is a let property 2. given a default value
    var selectedImage: Habit.Images
    
    var currentStreak: Int = 0
    var bestStreak: Int = 0
    var lastCompletionDate: Date? //AN OPTIONAL -> only true when you've completed the task.
    var numberOfCompletions: Int = 0 //updated whenever you complete a habit
  
    var completedToday: Bool {
        return lastCompletionDate?.isToday ?? false
        //returns true if lastCompletionDate date is today
    }
    init(title: String, image: Habit.Images) {
        self.title = title
        self.selectedImage = image
    }
}


    
