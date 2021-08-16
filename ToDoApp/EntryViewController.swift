//
//  EntryViewController.swift
//  ToDoApp
//
//  Created by kms on 2021/08/16.
//
import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(didTapSaveButton))
        textField.becomeFirstResponder()
        textField.delegate = self
    
        setDatePicker()
        
    }
    
    private func setDatePicker() {
        datePicker.setDate(Date(), animated: true)
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.preferredDatePickerStyle = .inline
        datePicker.contentMode = .scaleAspectFit
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    @objc func didTapSaveButton() {
        if let text = textField.text, !text.isEmpty {
                let date = self.datePicker.date
                
                self.realm.beginWrite()
                
                let newItem = ToDoListItem()
                newItem.date = date
                newItem.item = text
                self.realm.add(newItem)
                try! self.realm.commitWrite()
                self.completionHandler?()
            
                self.navigationController?.popToRootViewController(animated: true)

        }else {
            print("Add something")
        }
    }
}
