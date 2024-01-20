//
//  LoginViewController.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 20/01/2024.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var textStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create and add text views with leading star icon
               addTextWithLeadingIcon(text: "\("Enjoy a free popcorn on sign up.")")
        addTextWithLeadingIcon(text: "Enjoy a $5.00 Elite reward after 300 \n points to spend however you want.")

               addTextWithLeadingIcon(text: "Enjoy a special birthday movie \n ticket offer.")
                addTextWithLeadingIcon(text: "Enjoy exclusive content, sneak peaks,\n and special offers!.")
               // Add as many lines as needed
    }
    func addTextWithLeadingIcon(text: String) {
        // Create an UIImageView for the leading star icon
        let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
        starImageView.contentMode = .scaleAspectFit
        starImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true  // Set the width as needed

        // Create a UILabel for the text
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.numberOfLines = 0  // Allow multiple lines
        textLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)  // Allow the text to expand horizontally
        textLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)  // Allow the text to be compressed when necessary

        // Create a horizontal stack view for the icon and text
        let horizontalStackView = UIStackView(arrangedSubviews: [starImageView, textLabel])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8  // Adjust the spacing between icon and text

        // Add the horizontal stack view to the main stack view
        textStackView.addArrangedSubview(horizontalStackView)
    }
   
}
