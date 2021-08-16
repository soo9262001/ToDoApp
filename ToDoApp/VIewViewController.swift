//
//  VIewViewController.swift
//  ToDoApp
//
//  Created by kms on 2021/08/16.
//
import RealmSwift
import UIKit

class VIewViewController: UIViewController {

    public var item: ToDoListItem?
    
    public var deletionHandler: (() -> Void)?
    
    private let realm = try! Realm()
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemLabel.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete() {
        guard let item = self.item else {
            return
        }
        
        realm.beginWrite()
        realm.delete(item)
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
}
