//
//  BookViewController.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 21/01/2024.
//

import UIKit
import SDWebImage

struct DateModel {
    let date: Date
    let title: String
}

struct TimeModel {
    let time: String
}


class BookViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var runTime: UILabel!
    
    // MARK: - Properties
    var viewModel: MovieBookingViewModel?

    @IBOutlet weak var dateCollectionView: UICollectionView!
    
    @IBOutlet weak var timeCollectionView: UICollectionView!
    
    var dateModels: [DateModel] = []
        var timeModels: [TimeModel] = []

        var selectedDate: Date? {
            didSet {
                // Update the UI and fetch corresponding time slots
                updateTimeSlots(for: selectedDate)
            }
        }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a custom back button
                let backButton = UIButton(type: .system)
                backButton.setTitle("Back", for: .normal)
                backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

                // Set the position of the button (adjust the frame as needed)
                backButton.frame = CGRect(x: 16, y: 40, width: 60, height: 30)

                // Add the button to the view
                view.addSubview(backButton)
        setupViews()
        
        
        setupDateCollectionView()
        setupTimeCollectionView()

        // Populate dateModels and timeModels with your data
        dateModels = [DateModel(date: Date(), title: "Date 1"), DateModel(date: Date().addingTimeInterval(86400), title: "Date 2")]
        timeModels = [TimeModel(time: "9:00 AM"), TimeModel(time: "1:00 PM"), TimeModel(time: "5:00 PM")]

        // Initial setup (assuming the first date is selected initially)
        selectedDate = dateModels.first?.date

        
        
    }
    func setupViews() {
        self.titleText.text = viewModel?.movie.title
        
        guard let runTime = viewModel?.movie.runTime else {
            return
        }
        self.runTime.text = runTime  + "Mins"
        if let url = URL(string: viewModel?.movie.imageURL ?? "") {
            imageView.sd_setImage(with: url, completed: nil)
        }
    }
    @objc func backButtonTapped() {
       
        dismiss(animated: true, completion: nil)
    }
    @IBAction func continueButtonPressed(_ sender: Any) {
    }
    func updateTimeSlots(for date: Date?) {
            // Fetch time slots based on the selected date and update the time selection view
            // Reload your time selection detail view or collection view with new time slots
            timeCollectionView.reloadData()
        }

        func setupDateCollectionView() {
            dateCollectionView.dataSource = self
            dateCollectionView.delegate = self
//            dateCollectionView.register(UINib(nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "DateCell")
        }

        func setupTimeCollectionView() {
            timeCollectionView.dataSource = self
            timeCollectionView.delegate = self
//            timeCollectionView.register(UINib(nibName: "TimeCell", bundle: nil), forCellWithReuseIdentifier: "TimeCell")
        }

        // MARK: - UICollectionViewDataSource

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return collectionView == dateCollectionView ? dateModels.count : timeModels.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == dateCollectionView {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
                let dateModel = dateModels[indexPath.item]
                cell.configure(with: dateModel)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! TimeCell
                let timeModel = timeModels[indexPath.item]
                cell.view.layer.borderColor = UIColor(red: 162/255, green: 198/255, blue: 88/255, alpha: 1.0).cgColor
                cell.view.layer.masksToBounds = true
                cell.configure(with: timeModel)
                return cell
            }
        }

        // MARK: - UICollectionViewDelegate

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == dateCollectionView {
                let selectedDateModel = dateModels[indexPath.item]
                selectedDate = selectedDateModel.date
                if let cell = collectionView.cellForItem(at: indexPath) {
                            // Customize the appearance of the selected cell
                            cell.contentView.backgroundColor = UIColor(red: 162/255, green: 198/255, blue: 88/255, alpha: 0.8)
                            // Add any other custom styling you need
                        }
            } else {
                // Handle time selection
            }
        }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            // Get the deselected cell
        if collectionView == dateCollectionView {
            
            if let cell = collectionView.cellForItem(at: indexPath) {
                // Revert the appearance of the deselected cell
                cell.contentView.backgroundColor = UIColor.clear
                // Add any other custom styling you need
            }
        }
        else {
            // Handle time selection
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dateCollectionView {
            return CGSize(width: 130, height: 80)
        } else {
            return CGSize(width: 130, height: 80)
        }
           
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 10  // Adjust the vertical spacing between cells
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 10  // Adjust the horizontal spacing between cells
       }
    }


