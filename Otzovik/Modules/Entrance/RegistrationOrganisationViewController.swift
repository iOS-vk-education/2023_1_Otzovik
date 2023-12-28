//
//  RegistrationOrganisationViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class RegistrationOrganisationViewController: BaseEntranceViewController {
    
    //private let universityViewController = ChooseUniversityViewController()
    //private let departmentViewController = FilterViewController()
    //private lazy var upperSeparatorView: EntranceSeparatorView = EntranceSeparatorView()
    //private lazy var bottomSeparatorView: EntranceSeparatorView = EntranceSeparatorView()
    private lazy var toHeiImageView: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.forward")
        iv.tintColor = .systemGray
        return iv
    }()
    private lazy var toDepartmentImageView: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.forward")
        iv.tintColor = .systemGray
        return iv
    }()
    private lazy var separatorView: EntranceSeparatorView = EntranceSeparatorView()
    private lazy var heiTextField: InsetTextField = {
        let textField = InsetTextField()
        textField.config(leftInset: 100.0, rightInset: 15.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        textField.text = RegistrationModel.shared.hei
        textField.attributedPlaceholder = NSAttributedString(
            string: "ВУЗ",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.placeholder = "ВУЗ"
        return textField
    }()
    private lazy var heiTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "ВУЗ"
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()
    /*private lazy var facultyTextField: InsetTextField = {
        let textField = InsetTextField()
        textField.config(leftInset: 100.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        textField.text = RegistrationModel.shared.faculty
        textField.placeholder = "факультет"
        return textField
    }()
    private lazy var facultyTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Факультет"
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()*/
    private lazy var departmentTextField: InsetTextField = {
        let textField = InsetTextField()
        textField.config(leftInset: 100.0, rightInset: 35.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        textField.text = RegistrationModel.shared.department
        textField.attributedPlaceholder = NSAttributedString(
            string: "кафедра",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.placeholder = "кафедра"
        return textField
    }()
    private lazy var departmentTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Кафедра"
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()
    private lazy var textFieldsView: EntranceTextFieldsView = EntranceTextFieldsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tryToResineFirstResponder(_:))))
        view.addSubview(textFieldsView)
        textFieldsView.addSubview(heiTextField)
        heiTextField.delegate = self
        heiTextField.addTarget(self, action: #selector(heiTextFieldTapped), for: .touchDown)
        //textFieldsView.addSubview(facultyTextField)
        //facultyTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        //facultyTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        //facultyTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(departmentTextField)
        departmentTextField.delegate = self
        departmentTextField.addTarget(self, action: #selector(departmentTextFieldTapped), for: .touchDown)
        textFieldsView.addSubview(separatorView)
        //textFieldsView.addSubview(upperSeparatorView)
        //textFieldsView.addSubview(bottomSeparatorView)
        heiTextField.addSubview(heiTextFieldLabel)
        //facultyTextField.addSubview(facultyTextFieldLabel)
        departmentTextField.addSubview(departmentTextFieldLabel)
        heiTextField.addSubview(toHeiImageView)
        //facultyTextField.addSubview(facultyTextFieldLabel)
        departmentTextField.addSubview(departmentTextFieldLabel)
        departmentTextField.addSubview(toDepartmentImageView)
        setIcon()
        setTitles()
        setConstraints()
    }
    
    private func setTitles() {
        super.setTitles(title: "Учебное заведение", buttonTitle: "Продолжить")
    }
    private func setIcon() {
        if let image = UIImage(systemName: "graduationcap.fill") {
            super.setIcon(image: image)
        }
    }
    @objc
    private func tryToResineFirstResponder(_ sender: UITapGestureRecognizer) {
        tryToResineFirstResponder()
    }
    private func tryToResineFirstResponder() {
        if heiTextField.isFirstResponder {
            heiTextField.resignFirstResponder()
        }
        /*if facultyTextField.isFirstResponder {
            facultyTextField.resignFirstResponder()
        }*/
        if departmentTextField.isFirstResponder {
            departmentTextField.resignFirstResponder()
        }
    }
    public override func nextVC() {
        let vc: RegistrationPasswordViewController = RegistrationPasswordViewController()
        self.present(vc, animated: true, completion: {vc.delegate = self.delegate})
    }
}
extension RegistrationOrganisationViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false;
    }
    @objc
    private func heiTextFieldTapped() {
        let universityViewController = ChooseUniversityViewController()
        universityViewController.delegate = self
        universityViewController.isCalledFromRegistration = true
        present(universityViewController, animated: true)
    }
    @objc
    private func departmentTextFieldTapped() {
        if heiTextField.text?.count == 0{
            return
        }
        let departmentViewController = FilterViewController()
        departmentViewController.isUniversityChanged = true
        departmentViewController.filterDelegate = self
        departmentViewController.isCalledFromRegistration = true
        departmentViewController.currentUniversity = heiTextField.text
        present(UINavigationController(rootViewController: departmentViewController), animated: true, completion: nil)
    }
}
extension RegistrationOrganisationViewController: ReceiveTitleDelegate, SendFiltersToSearchDelegate {

    func receiveTitle(_ title: String) {
        heiTextField.text = title
        departmentTextField.text = ""
        RegistrationModel.shared.hei = title
    }
    func sendfilters(_ filters: [String]) {
        print(#function)
        if !filters.isEmpty, let department = filters.first {
            departmentTextField.text = department
            RegistrationModel.shared.department = department
        }
    }
}
extension RegistrationOrganisationViewController {
    private func setConstraints() {
        
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        heiTextField.translatesAutoresizingMaskIntoConstraints = false
        //facultyTextField.translatesAutoresizingMaskIntoConstraints = false
        departmentTextField.translatesAutoresizingMaskIntoConstraints = false
        //upperSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        //bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        heiTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        //facultyTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        departmentTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        toHeiImageView.translatesAutoresizingMaskIntoConstraints = false
        toDepartmentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldsView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        textFieldsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        textFieldsView.topAnchor.constraint(equalTo: super.titleLabel.bottomAnchor, constant: 35).isActive = true
        
        heiTextField.topAnchor.constraint(equalTo: textFieldsView.topAnchor).isActive = true
        heiTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        heiTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        heiTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        /*upperSeparatorView.topAnchor.constraint(equalTo: heiTextField.bottomAnchor).isActive = true
        upperSeparatorView.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: 20).isActive = true
        upperSeparatorView.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        upperSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true*/
        
        /*facultyTextField.topAnchor.constraint(equalTo: upperSeparatorView.bottomAnchor).isActive = true
        facultyTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        facultyTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        facultyTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true*/
        
        /*bottomSeparatorView.topAnchor.constraint(equalTo: facultyTextField.bottomAnchor).isActive = true
        bottomSeparatorView.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: 20).isActive = true
        bottomSeparatorView.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true*/
        
        separatorView.topAnchor.constraint(equalTo: heiTextField.bottomAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: 20).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        departmentTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        //departmentTextField.topAnchor.constraint(equalTo: bottomSeparatorView.bottomAnchor).isActive = true
        departmentTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        departmentTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        departmentTextField.bottomAnchor.constraint(equalTo: textFieldsView.bottomAnchor).isActive = true
        departmentTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        heiTextFieldLabel.centerYAnchor.constraint(equalTo: heiTextField.centerYAnchor).isActive = true
        heiTextFieldLabel.leadingAnchor.constraint(equalTo: heiTextField.leadingAnchor, constant: 15).isActive = true
        
        toHeiImageView.centerYAnchor.constraint(equalTo: heiTextField.centerYAnchor).isActive = true
        toHeiImageView.trailingAnchor.constraint(equalTo: heiTextField.trailingAnchor, constant: -10).isActive = true
        toHeiImageView.widthAnchor.constraint(equalTo: heiTextField.heightAnchor, multiplier: 0.6).isActive = true
        toHeiImageView.heightAnchor.constraint(equalTo: heiTextField.heightAnchor, multiplier: 0.6).isActive = true
        
        /*facultyTextFieldLabel.centerYAnchor.constraint(equalTo: facultyTextField.centerYAnchor).isActive = true
        facultyTextFieldLabel.leadingAnchor.constraint(equalTo: facultyTextField.leadingAnchor, constant: 15).isActive = true*/
        
        departmentTextFieldLabel.centerYAnchor.constraint(equalTo: departmentTextField.centerYAnchor).isActive = true
        departmentTextFieldLabel.leadingAnchor.constraint(equalTo: departmentTextField.leadingAnchor, constant: 15).isActive = true
        
        toDepartmentImageView.centerYAnchor.constraint(equalTo: departmentTextField.centerYAnchor).isActive = true
        toDepartmentImageView.trailingAnchor.constraint(equalTo: departmentTextField.trailingAnchor, constant: -10).isActive = true
        toDepartmentImageView.widthAnchor.constraint(equalTo: departmentTextField.heightAnchor, multiplier: 0.6).isActive = true
        toDepartmentImageView.heightAnchor.constraint(equalTo: departmentTextField.heightAnchor, multiplier: 0.6).isActive = true
    }
}

extension RegistrationOrganisationViewController: ChangeUniversityViewControllerDelegate{
    func getUniversity() -> [String] {
        var str:[String] = []
        if let s1 = departmentTextField.text,
           let s2 = heiTextField.text,
           !s1.isEmpty && !s2.isEmpty {
            str = [s1, s2]
        }
        return str
    }
}
