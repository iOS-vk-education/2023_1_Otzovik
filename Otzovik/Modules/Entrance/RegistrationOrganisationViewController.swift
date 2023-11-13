//
//  RegistrationOrganisationViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class RegistrationOrganisationViewController: BaseEntranceViewController {

    let separator1View: UIView = UIView()
    let separator2View: UIView = UIView()
    let heiTextField: InsetTextField = InsetTextField()
    let heiLabel: UILabel = UILabel()
    let facultyTextField: InsetTextField = InsetTextField()
    let facultyTextFieldLabel: UILabel = UILabel()
    let departmentTextField: InsetTextField = InsetTextField()
    let departmentTextFieldLabel: UILabel = UILabel()
    let textFieldsView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tryToResineFirstResponder(_:))))
        view.addSubview(textFieldsView)
        textFieldsView.layer.cornerRadius = 12
        textFieldsView.layer.masksToBounds = true
        
        textFieldsView.addSubview(heiTextField)
        heiTextField.autocorrectionType = .no
        heiTextField.autocapitalizationType = .none
        //heiTextField.placeholder = "ВУЗ"
        heiTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        heiTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        heiTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(facultyTextField)
        facultyTextField.autocorrectionType = .no
        facultyTextField.autocapitalizationType = .none
        //facultyTextField.placeholder = "факультет"
        facultyTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        facultyTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        facultyTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(departmentTextField)
        departmentTextField.autocorrectionType = .no
        departmentTextField.autocapitalizationType = .none
        //departmentTextField.placeholder = "кафедра"
        departmentTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        departmentTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        departmentTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        
        textFieldsView.addSubview(separator1View)
        textFieldsView.addSubview(separator2View)
        heiTextField.addSubview(heiLabel)
        facultyTextField.addSubview(facultyTextFieldLabel)
        departmentTextField.addSubview(departmentTextFieldLabel)
        heiLabel.text = "ВУЗ"
        facultyTextFieldLabel.text = "Факультет"
        departmentTextFieldLabel.text = "Кафедра"
        heiLabel.textAlignment = .left
        facultyTextFieldLabel.textAlignment = .left
        departmentTextField.textAlignment = .left
        setIcon()
        setTitle()
        
        setColor()
        setConstraints()
    }
    
    private func setTitle() {
        super.setTitle(title: "Учебное заведение")
    }
    private func setIcon() {
        if let image = UIImage(systemName: "person.fill") {
            super.setIcon(image: image)
        }
    }
    
    private func setColor() {
        textFieldsView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        separator1View.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.36)
        separator2View.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.36)
        heiTextField.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        facultyTextField.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        departmentTextField.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        heiLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        facultyTextFieldLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        departmentTextFieldLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    @objc
    private func tryToResineFirstResponder(_ sender: UITapGestureRecognizer) {
        tryToResineFirstResponder()
    }
    private func tryToResineFirstResponder() {
        if heiTextField.isFirstResponder {
            heiTextField.resignFirstResponder()
        }
        if facultyTextField.isFirstResponder {
            facultyTextField.resignFirstResponder()
        }
        if departmentTextField.isFirstResponder {
            departmentTextField.resignFirstResponder()
        }
    }
    public override func nextVC() {
        print(#function)
        print("следующий шаг")
    }
}
extension RegistrationOrganisationViewController {
    @objc
    private func textFieldDidChanged(textField: UITextField) {
        print(textField.text)
        
    }
    @objc
    private func textFieldDidBeginEditing(textField: UITextField) {
        print(textField.text)
        
    }
    @objc
    private func textFieldDidEndEditing(textField: UITextField) {
        print(textField.text)
    }
    @objc
    private func onReturn(textField: UITextField) {
        print(textField.text)
    }
}
extension RegistrationOrganisationViewController {
    private func setConstraints() {
        
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        heiTextField.translatesAutoresizingMaskIntoConstraints = false
        facultyTextField.translatesAutoresizingMaskIntoConstraints = false
        departmentTextField.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        heiLabel.translatesAutoresizingMaskIntoConstraints = false
        facultyTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        departmentTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: super.titleLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 35).isActive = true
        
        NSLayoutConstraint(item: heiTextField, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: heiTextField, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: heiTextField, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: separator1View, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: heiTextField, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: separator1View, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: separator1View, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: separator1View, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 1).isActive = true
        
        NSLayoutConstraint(item: facultyTextField, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: separator1View, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: facultyTextField, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: facultyTextField, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: separator2View, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: facultyTextField, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: separator2View, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: separator2View, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: separator2View, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 1).isActive = true
        
        NSLayoutConstraint(item: departmentTextField, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: separator2View, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: departmentTextField, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: departmentTextField, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: departmentTextField, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: heiTextField, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
        NSLayoutConstraint(item: facultyTextField, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
        NSLayoutConstraint(item: departmentTextField, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
        
        NSLayoutConstraint(item: heiLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: heiTextField, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: heiLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: heiTextField, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15).isActive = true
        NSLayoutConstraint(item: facultyTextFieldLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: facultyTextField, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: facultyTextFieldLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: facultyTextField, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15).isActive = true
        NSLayoutConstraint(item: departmentTextFieldLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: departmentTextField, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: departmentTextFieldLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: departmentTextField, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15).isActive = true
        
        
    }
}
