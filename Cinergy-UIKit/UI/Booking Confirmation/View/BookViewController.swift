//
//  BookViewController.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 21/01/2024.
//

import UIKit
import SDWebImage

class BookViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var dateCollectionView: UICollectionView!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    var viewModel: MovieBookingViewModel?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomBackButton()
        setupViews()
        setupDateCollectionView()
        setupTimeCollectionView()
        
        viewModel?.isClickedDate.bindAndFire { [weak self] success in
            if success {
                self?.timeCollectionView.reloadData()
            }
        }
        let defaultIndexPath = IndexPath(item: 0, section: 0)
            dateCollectionView.selectItem(at: defaultIndexPath, animated: false, scrollPosition: .centeredHorizontally)
            collectionView(dateCollectionView, didSelectItemAt: defaultIndexPath)
    }
    
    // MARK: - Setup
    
    func setupCustomBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.frame = CGRect(x: 16, y: 40, width: 60, height: 30)
        view.addSubview(backButton)
    }
    
    func setupViews() {
        guard let viewModel = viewModel else { return }
        
        titleText.text = viewModel.movie.title
        
        if viewModel.movie.runTime != nil {
            self.runTime.text = viewModel.movie.runTime + " Mins"
            }
        
        if let url = URL(string: viewModel.movie.imageURL ?? "") {
            imageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    // MARK: - Actions
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        // Handle continue button press
    }
    
    // MARK: - Collection View
    
    func setupDateCollectionView() {
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self

    }
    
    func setupTimeCollectionView() {
        timeCollectionView.dataSource = self
        timeCollectionView.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == dateCollectionView ? viewModel?.getDateCount() ?? 0 : viewModel?.getTimeCount() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
            cell.weekLabel.text = viewModel?.getWeek(index: indexPath.row)
            cell.dateLabel.text = viewModel?.getDate(index: indexPath.row)
            cell.isSelected = viewModel!.dateSelectedIndex == indexPath.row
            cell.contentView.backgroundColor = viewModel!.dateSelectedIndex == indexPath.row ?
                UIColor(red: 162/255, green: 198/255, blue: 88/255, alpha: 0.8) : UIColor.clear

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! TimeCell
            cell.view.layer.borderColor = UIColor(red: 162/255, green: 198/255, blue: 88/255, alpha: 1.0).cgColor
            cell.view.layer.masksToBounds = true
            cell.timeLabel.text = viewModel?.getShowTime(index: indexPath.row)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == dateCollectionView {
            viewModel?.setDateForSelectedIndex(index: indexPath.row)
            
            if let cell = collectionView.cellForItem(at: indexPath) as? DateCell {
                cell.contentView.backgroundColor = UIColor(red: 162/255, green: 198/255, blue: 88/255, alpha: 0.8)
            }
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.backgroundColor = UIColor(red: 162/255, green: 198/255, blue: 88/255, alpha: 0.8)
            }
        } else {
            viewModel?.setTimeForSelectedIndex(index: indexPath.row)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == dateCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.backgroundColor = UIColor.clear
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
