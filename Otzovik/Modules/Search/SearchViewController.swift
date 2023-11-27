import UIKit

// MARK: 1st VC
class SearchViewController: UIViewController, UISearchBarDelegate {
    private var ChangeUniversityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return button
    }()
    
    @objc
    private func changeUniversity() {
        let universityController = ChooseUniversityViewController()
        self.present(UINavigationController(rootViewController: universityController), animated: true, completion: nil)
        
    }
    @objc
    private func openFilters() {
        let filterViewController = FilterViewController()
        navigationController?.pushViewController(filterViewController, animated: true)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        print(#function)
        
        
    }
    @objc
    func keyboardWillHide(notification: NSNotification){
        print(#function)
        
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        openFilters()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        title = "Поиск"
        navigationItem.title = "МГТУ им. Баумана"
        
        ChangeUniversityButton.addTarget(self,
                                         action: #selector(changeUniversity), for: .touchUpInside)
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: ChangeUniversityButton), animated: true)
        self.navigationItem.searchController = UISearchController(searchResultsController: nil)
        let searchBar = self.navigationItem.searchController?.searchBar
        
        
        searchBar?.delegate = self
        searchBar?.showsBookmarkButton = true
        searchBar?.setImage(UIImage(systemName: "slider.horizontal.3"), for: .bookmark, state: .normal)
        searchBar?.placeholder = "Поиск"
        searchBar?.setValue("Отмена", forKey: "cancelButtonText")
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        super.viewDidLoad()
    }
    
}


