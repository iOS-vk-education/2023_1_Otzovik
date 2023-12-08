import UIKit

// MARK: 1st VC
class SearchViewController: UIViewController, UISearchBarDelegate {
    
    private let tableView = UITableView()
    
    private var teachers: [Teacher] = []
    private let teacherManager = TeacherManager()
    
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
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        loadData()
        view.addSubview(tableView)
        
        super.viewDidLoad()
    }
    
    func loadData() {
        teacherManager.loadTeachers { [weak self] teachers in
            self?.teachers = teachers
            self?.tableView.reloadData()
        }
    }
    
}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath)
        let mainCell = cell as? SearchTableViewCell
        
        mainCell?.configure(with: teachers[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(sourceIndexPath, destinationIndexPath)
        let sourceProduct = teachers[sourceIndexPath.row]
        teachers.remove(at: sourceIndexPath.row)
        teachers.insert(sourceProduct, at: destinationIndexPath.row)
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        teachers.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let teacherViewController = TeacherViewController(teacher: teachers[indexPath.row])
        let navigationController = UINavigationController(rootViewController: teacherViewController)
        
        present(navigationController, animated: true)
    }
}
