//
//  LoginViewController.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 20/01/2024.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    private var cancellables: Set<AnyCancellable> = []
    var viewModel : InitialViewModel?

    @IBOutlet weak var textStackView: UIStackView!

  
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Create and add text views with leading star icon
               addTextWithLeadingIcon(text: "\("Enjoy a free popcorn on sign up.")")
        addTextWithLeadingIcon(text: "Enjoy a $5.00 Elite reward after 300 \n points to spend however you want.")

               addTextWithLeadingIcon(text: "Enjoy a special birthday movie \n ticket offer.")
                addTextWithLeadingIcon(text: "Enjoy exclusive content, sneak peaks,\n and special offers!.")
               // Add as many lines as needed
        viewModel?.didLogin.bindAndFire { [weak self] success in
            if success {
                // Update UI or navigate to the next screen
                let escapeRoomViewModel = EscapeRoomViewModel()


                // Create an instance of Router
                let router: Router = Router()

                // Use the getViewController function to get an instance of EscapeRoomViewController
                DispatchQueue.main.async {
                    let escapeRoomViewController = router.getViewController(withIdentifier: "EscapeRoomViewControllerId", viewModel: escapeRoomViewModel)
                    
                    // Now, you can safely use the escapeRoomViewController on the main thread
                    self?.navigationController?.pushViewController(escapeRoomViewController!, animated: true)
                }


                
                   
                

            } else {
                print("Failed")
            }
        }
    }
    func addTextWithLeadingIcon(text: String) {
        // Create an UIImageView for the leading star icon
        let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
        starImageView.contentMode = .scaleAspectFit
        starImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true  // Set the width as needed

        // Create a UILabel for the text
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.numberOfLines = 2  // Allow multiple lines
        textLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)  // Allow the text to expand horizontally
        textLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)  // Allow the text to be compressed when necessary

        // Create a horizontal stack view for the icon and text
        let horizontalStackView = UIStackView(arrangedSubviews: [starImageView, textLabel])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8  // Adjust the spacing between icon and text

        // Add the horizontal stack view to the main stack view
        textStackView.addArrangedSubview(horizontalStackView)
    }
   
    @IBAction func guestButtonPressed(_ sender: Any) {
        // Subscribe to the data publisher
        viewModel?.fetchDataPublisher
                 .sink(receiveCompletion: { completion in
                     switch completion {
                     case .finished:
                         break
                     case .failure(let error):
                         // Handle the error
                         print("Error: \(error.localizedDescription)")
                     }
                 }, receiveValue: { [weak self] fetchedData in
                     // Update UI with the fetched data
//                     self?.updateUI(with: fetchedData)
                 })
                 .store(in: &cancellables)

             // Trigger the data fetch in the view model
        viewModel?.fetchPosts()
    }
}
