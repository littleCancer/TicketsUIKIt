//
//  EditEventViewController.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 25.5.22..
//

import UIKit

class EditEventViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var discountContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var discountQuantityValidationLabel: UILabel!
    @IBOutlet weak var discountTextField: UITextField!
    @IBOutlet weak var discountContainer: UIView!
    @IBOutlet weak var discountValidationLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var discountQuantityTextField: UITextField!
    @IBOutlet var descriptionTextArea: [UITextView]!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var quantityValidationLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceValidationMessageLabel: UILabel!
    @IBOutlet weak var dateValidationMessageLabel: UILabel!
    @IBOutlet weak var placeNavigationMessageLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var nameValidationMessageLabel: UILabel!
    var viewModel: EditEventViewModel?
    @IBOutlet weak var dateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.scrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.self.height * 2)
//        self.scrollView.frame = self.view.bounds
        // Do any additional setup after loading the view.
    }
    

    @IBAction func nameValueChanged(_ sender: Any) {
    }
    
    @IBAction func placeValueChanged(_ sender: UITextField) {
    }
    @IBAction func dateValueChanged(_ sender: Any) {
    }
    
    @IBAction func priceEditingChanged(_ sender: Any) {
    }
    @IBAction func quantityValueChanged(_ sender: UITextField) {
    }
    @IBAction func discountSwitchValueChanged(_ sender: Any) {
    }
    @IBAction func discountValueChanged(_ sender: Any) {
    }
    @IBAction func discQValueChanged(_ sender: UITextField) {
    }
    @IBOutlet weak var discountEntityValueChanged: UITextField!
}
