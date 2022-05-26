//
//  EditEventViewController.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 25.5.22..
//

import UIKit
import Combine

class EditEventViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var editButtonYConstraint: NSLayoutConstraint!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var discountContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var discountQuantityValidationLabel: UILabel!
    @IBOutlet weak var discountTextField: UITextField!
    @IBOutlet weak var discountContainer: UIView!
    @IBOutlet weak var discountValidationLabel: UILabel!
    @IBOutlet weak var discountSwitch: UISwitch!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var discountQuantityTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var quantityValidationLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceValidationMessageLabel: UILabel!
    @IBOutlet weak var dateValidationMessageLabel: UILabel!
    @IBOutlet weak var desciptionTextView: UITextView!
    @IBOutlet weak var placeNavigationMessageLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var nameValidationMessageLabel: UILabel!
    var viewModel: EditEventViewModel?
    @IBOutlet weak var dateTextField: UITextField!
    private var cancellableSet: Set<AnyCancellable> = []
    
    var enableUpdateButton: Bool {
        return priceValidationMessageLabel.isHidden && dateValidationMessageLabel.isHidden && placeNavigationMessageLabel.isHidden && placeNavigationMessageLabel.isHidden && nameValidationMessageLabel.isHidden
            && quantityValidationLabel.isHidden
            && (discountContainer.isHidden || discountValidationLabel.isHidden)
            && (discountContainer.isHidden || discountQuantityValidationLabel.isHidden)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleSubviews()
        if viewModel?.eventDiscountPair != nil {
            populateSubviews()
        }
        
        setupObservers()
    }
    
    private func styleSubviews() {
    
        self.view.backgroundColor = UIColor.appGray
        let titleLabel = UILabel()
        titleLabel.text = viewModel?.eventDiscountPair != nil ? "Edit" : "Create"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.appBoldFontOfSize(size: 22)
        self.navigationItem.titleView = titleLabel
        
        setCustomBack()
    
        self.eventImage.contentMode = .scaleAspectFill
        self.eventImage.sd_setImage(with: URL(string: viewModel!.imageURL))
        
        
        self.editButton.layer.cornerRadius = 5
        self.editButton.layer.masksToBounds = true
        
        self.discountContainer.layer.cornerRadius = 5
        self.discountContainer.layer.masksToBounds = true
        
        self.nameTextField.makeRoundedWithGrayBorder()
        self.desciptionTextView.makeRoundedWithGrayBorder()
        self.placeTextField.makeRoundedWithGrayBorder()
        self.dateTextField.makeRoundedWithGrayBorder()
        self.priceTextField.makeRoundedWithGrayBorder()
        self.quantityTextField.makeRoundedWithGrayBorder()
        self.discountTextField.makeRoundedWithGrayBorder()
        self.discountQuantityTextField.makeRoundedWithGrayBorder()
        self.discountContainer.makeRounded()
        self.editButton.makeRounded()
        
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .dateAndTime
        dateTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        datePickerView.minimumDate = Date.now
        
        let buttonTitle = self.viewModel?.eventDiscountPair != nil ? "Edit" : "Create"
        self.editButton.setTitle(buttonTitle, for: .normal)
        
    }
    
    private func populateSubviews() {
        self.nameTextField.text = self.viewModel?.name
        self.desciptionTextView.text = self.viewModel?.eventDescription
        self.placeTextField.text = self.viewModel?.place
        self.dateTextField.text = FormatUtils.formatDate(date: viewModel!.date)
        self.priceTextField.text = viewModel?.price
        self.quantityTextField.text = viewModel?.quantity
        
        if viewModel!.discountOn {
            self.discountTextField.text = viewModel?.discount
            self.discountQuantityTextField.text = viewModel?.discountQuantity
        } else {
            self.discountSwitch.isOn = false
            hideDiscountViewOnLoad()
        }
        
    }
    
    private func setupObservers() {
        
        viewModel?.$isNameValid.sink{ [weak self] valid in
            self?.nameValidationMessageLabel.isHidden = valid
            self?.updateEditButtonState()
        }.store(in: &cancellableSet)
        
        viewModel?.$isPlaceValid.sink{ [weak self] valid in
            self?.placeNavigationMessageLabel.isHidden = valid
            self?.updateEditButtonState()
        }.store(in: &cancellableSet)
        
        viewModel?.$isPriceValid.sink{ [weak self] valid in
            self?.priceValidationMessageLabel.isHidden = valid
            self?.updateEditButtonState()
        }.store(in: &cancellableSet)
        
        viewModel?.$isQuantityValid.sink{ [weak self] valid in
            self?.quantityValidationLabel.isHidden = valid
            self?.updateEditButtonState()
        }.store(in: &cancellableSet)
        
        viewModel?.$isDiscountValid.sink{ [weak self] valid in
            self?.discountValidationLabel.isHidden = valid
            self?.updateEditButtonState()
        }.store(in: &cancellableSet)
        
        viewModel?.$isDiscountQuantityValid.sink{ [weak self] valid in
            self?.discountQuantityValidationLabel.isHidden = valid
            self?.updateEditButtonState()
        }.store(in: &cancellableSet)
        
    }

    @IBAction func nameValueChanged(_ sender: UITextField) {
        self.viewModel?.name = sender.text!
    }
    
    @IBAction func placeValueChanged(_ sender: UITextField) {
        self.viewModel?.place = sender.text!
    }
    
    @IBAction func dateValueChanged(_ sender: UITextField) {
        viewModel?.date = FormatUtils.date(from: sender.text!)
    }
    
    @IBAction func quantityValueChanged(_ sender: UITextField) {
        viewModel?.quantity = sender.text!
    }
    
    @IBAction func priceValueChanged(_ sender: UITextField) {
        viewModel?.price = sender.text!
    }
    
    
    @IBAction func discountSwitchValueChanged(_ sender: UISwitch) {
        self.viewModel?.discountOn = sender.isOn
        if !sender.isOn && !self.discountContainer.isHidden {
            hideDiscountsAnimated()
        } else if sender.isOn && self.discountContainer.isHidden {
            showDiscountsAnimated()
        }
    }
    
    private func hideDiscountViewOnLoad() {
        self.discountContainerHeightConstraint.constant = 0
        self.editButtonYConstraint.constant = 1060
        self.scrollView.layoutIfNeeded()
        self.discountContainer.isHidden = true
    }
    
    private func updateEditButtonState() {
        self.editButton.isEnabled = self.enableUpdateButton
    }
    
    @IBAction func discountValueChanged(_ sender: UITextField) {
        viewModel?.discount = sender.text!
    }
    
    @IBAction func discQValueChanged(_a sender: UITextField) {
        viewModel?.discountQuantity = sender.text!
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
        viewModel?.saveChanges()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    // MARK: TextView delegate method
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel?.eventDescription = textView.text
    }
    
    // MARK: Animatiomn
    
    private func hideDiscountsAnimated() {
        UIView.transition(with: scrollView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: {
            self.discountContainerHeightConstraint.constant = 0
            self.editButtonYConstraint.constant = 1060
            self.scrollView.layoutIfNeeded()
        }) { _ in
            self.discountContainer.isHidden = true
            self.updateEditButtonState()
        }
    }
    
    private func showDiscountsAnimated() {
        self.discountContainer.isHidden = false
        UIView.transition(with: scrollView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: {
            self.discountContainerHeightConstraint.constant = 250
            self.editButtonYConstraint.constant = 1310
            self.scrollView.layoutIfNeeded()
        })
        self.updateEditButtonState()
    }
    
}
