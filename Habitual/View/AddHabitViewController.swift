//
//  AddHabitViewController.swift
//  Habitual
//
//  Created by Cherish Spikes on 4/5/23.
//

import UIKit

class AddHabitViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func pickPhotoButtonPressed(_ sender: Any) {
        guard let selectedIndexPath = selectedIndexPath else { return }
       
        let confirmHabitVC = ConfirmHabitViewController.instantiate()
           confirmHabitVC.habitImage = habitImages[selectedIndexPath.row]
           navigationController?.pushViewController(confirmHabitVC, animated: true)
    }
    //add animation to show selection
    var selectedIndexPath: IndexPath? {
        didSet {
            var indexPaths: [IndexPath] = []
            if let selectedIndexPath = selectedIndexPath {
                //tracks which indexPath is selected, observer detects when the value changes
                indexPaths.append(selectedIndexPath)
            }
            if let oldValue = oldValue {
                //if it gets the same value, get to the second if statement.
                indexPaths.append(oldValue)
            }
            collectionView.performBatchUpdates({
                //reloads the corresponding items in the collection view
                self.collectionView.reloadItems(at: indexPaths)
            })
        }
    }
    
    let habitImages = Habit.Images.allCases
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(HabitImageCollectionViewCell.nib, forCellWithReuseIdentifier: HabitImageCollectionViewCell.identifier)
        // Do any additional setup after loading the view.
        setupNavBar()
    }
    func setupNavBar() {
        title = "Select Image"
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddHabit(_:)))
        navigationItem.leftBarButtonItem = cancelButton
    }
    @objc func cancelAddHabit(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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

extension AddHabitViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // Extension code here...
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //resposnible for telling the collection view how many items to display^
        return habitImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitImageCollectionViewCell.identifier, for: indexPath) as! HabitImageCollectionViewCell
        if indexPath == selectedIndexPath{
                cell.setImage(image: habitImages[indexPath.row].image, withSelection: true)
            }else{
                cell.setImage(image: habitImages[indexPath.row].image, withSelection: false)
            }
            return cell
        // to here!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //formatting and arranging cells in a collection view.
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //collection view wants to know the size of items at an indexpath.
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/4, height: collectionViewWidth/4) //calculate size of cells by looking at size of collection view and make it 1/4 of width. CGSize has properties of width and height so define both.
    }
    //add padding with insetForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        //Method returns a Boolean, recieves the indexpath of selected item.
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        return false
    }
    
}
