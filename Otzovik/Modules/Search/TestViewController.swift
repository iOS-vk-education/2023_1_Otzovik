//
//  TestViewController.swift
//  Otzovik
//
//  Created by Сергей Мирошниченко on 25.12.2023.
//

import UIKit
protocol TestDeligate: AnyObject{
    func didReceiveData(_ data: String)
}
class TestViewController: UIViewController{
    weak var delegate: TestDeligate?
    var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        //activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.stopAnimating()
        delegate?.didReceiveData("data")
    }
}
