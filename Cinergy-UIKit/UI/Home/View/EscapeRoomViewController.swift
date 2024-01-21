//
//  EscapeRooViewController.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 20/01/2024.
//

import UIKit
import SDWebImage

// MARK: - EscapeRoomViewController
class EscapeRoomViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: EscapeRoomViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        bindViewModel()
    }
}

// MARK: - UICollectionViewDataSource
extension EscapeRoomViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getMovieCount() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCellId", for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Unable to dequeue reusable cell")
        }

        configureCell(cell, at: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension EscapeRoomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 20) / 2 // Assuming 10pt spacing on each side
        let cellHeight: CGFloat = 450
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Assuming you have a method to get the selected data from the viewModel
        let data = viewModel?.getMovie(index: indexPath.row)

//        // Instantiate PopupViewController from the storyboard
//        if let popupViewController = storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as? PopupViewController {
//            popupViewController.image = UIImage(named: data?.imageUrl ?? "")
//            popupViewController.text = data?.description
//            popupViewController.buttonTitle = "Action"

            // Instantiate the view controller to be presented
            let viewControllerToPresent = DetailViewController()
        if let viewControllerToPresent = storyboard?.instantiateViewController(withIdentifier: "DetailViewControllerId") as? DetailViewController {
            // Configure the sheet presentation controller
            if let data = viewModel?.getMovie(index: indexPath.row) {
                viewControllerToPresent.movie = data
            }
           
            viewControllerToPresent.presentationController?.delegate = self
            viewControllerToPresent.sheetPresentationController?.detents = [.medium()]  // Set preferred height
            viewControllerToPresent.sheetPresentationController?.prefersGrabberVisible = true  // Show grabber
            
            // Present the view controller
            self.present(viewControllerToPresent, animated: true)
        }
        }
    }



// MARK: - Private Functions
private extension EscapeRoomViewController {
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func bindViewModel() {
        viewModel?.EscapeMovieListView.bindAndFire { [weak self] success in
            if success {
                self?.collectionView.reloadData()
            }
        }
    }

    func configureCell(_ cell: CustomCollectionViewCell, at indexPath: IndexPath) {
        if let data = viewModel?.getMovie(index: indexPath.row) {
            cell.titleLabel.text = data.title

            // Safely set the image only if the URL is valid
            if let url = URL(string: data.imageUrl) {
                cell.imageView?.sd_setImage(with: url, completed: nil)
            }
        } else {
            // Handle the case where data is nil (optional is not set)
            cell.titleLabel.text = "No Title"
        }
    }
}
