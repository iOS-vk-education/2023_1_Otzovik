import UIKit
import Firebase

class SearchViewController: UIViewController, UISearchBarDelegate, SendFiltersToSearchDelegate, ReceiveTitleDelegate{
    private var noInternetConnection = false
    private var searchText = ""
    private var currentFilters: [String] = []
    private var isUniversityChanged: Bool = false
    private var titleObservation: NSKeyValueObservation?
    private let tableView = UITableView()
    private var allUniversities: [University] = []
    private var teachers: [Teacher] = []
    private let manager = Manager()
    
    private var ChangeUniversityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return button
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    private var TeachersNotFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "Преподаватели не найдены"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var InternetConnectionErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Отсутсвует интернет соединение"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var RetryConnectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Попробовать еще раз", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    func sendfilters(_ filters: [String]) {
        currentFilters = filters
        search(searchText: "")
    }
    func receiveTitle(_ title: String) {
        currentFilters = []
        navigationItem.title = title
        loadData()
        isUniversityChanged = true
        
    }
    
    func showRetryButton(){
        view.addSubview(InternetConnectionErrorLabel)
        NSLayoutConstraint.activate([
            InternetConnectionErrorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            InternetConnectionErrorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        view.addSubview(RetryConnectionButton)
        NSLayoutConstraint.activate([
            RetryConnectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            RetryConnectionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60)
        ])
        RetryConnectionButton.addTarget(self, action: #selector(retry_to_load_data), for: .touchUpInside)
        noInternetConnection = true
        activityIndicator.stopAnimating()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText: searchText)
        self.searchText = searchText
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = searchText
    }
    func search(searchText: String){
        if searchText.count == 0{
            loadData()
            return
        }
        
        self.teachers = []
        if let savedData = UserDefaults.standard.data(forKey: "all_univers"),
           let loadedArray = try? PropertyListDecoder().decode([University].self, from: savedData) {
            self.allUniversities = loadedArray
            
        }
        
        for university in self.allUniversities{
            if university.name == self.navigationItem.title{
                if currentFilters.count != 0{
                    for department in university.departments{
                        if currentFilters.contains(department.name){
                            for teacher in department.teachers{
                                if teacher.name.contains(searchText){
                                    let teacher_toShow = Teacher(fio: teacher.name, university: university.name, faculty: "", chair: department.name, imageURL: "", rating: Double(teacher.rating), degree: "Доцент", description: "description")
                                    self.teachers.append(teacher_toShow)
                                }
                            }
                        }
                    }
                }
                else{
                    for department in university.departments{
                        for teacher in department.teachers{
                            if teacher.name.contains(searchText){
                                let teacher_toShow = Teacher(fio: teacher.name, university: university.name, faculty: "", chair: department.name, imageURL: "", rating: Double(teacher.rating), degree: "Доцент", description: "description")
                                self.teachers.append(teacher_toShow)
                            }
                        }
                    }
                }
            }
        }
        self.tableView.reloadData()
    }
    @objc
    private func changeUniversity() {
        let universityController = ChooseUniversityViewController()
        universityController.delegate = self
        self.present(UINavigationController(rootViewController: universityController), animated: true, completion: nil)
        
    }
    @objc
    private func retry_to_load_data(){
        RetryConnectionButton.removeFromSuperview()
        InternetConnectionErrorLabel.removeFromSuperview()
        loadData()
    }
    @objc
    private func openFilters() {
        let filterViewController = FilterViewController()
        filterViewController.currentUniversity = self.navigationItem.title
        filterViewController.isUniversityChanged = isUniversityChanged
        filterViewController.filterDelegate = self
        navigationController?.pushViewController(filterViewController, animated: true)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        openFilters()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    func showNotFoundLabel(){
        view.addSubview(TeachersNotFoundLabel)
        NSLayoutConstraint.activate([
            TeachersNotFoundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            TeachersNotFoundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isUniversityChanged = false
    }
    override func viewDidLoad() {
        activityIndicator.center = view.center
        view.backgroundColor = .white
        title = "Поиск"
        navigationItem.title = "МГТУ им. Баумана"
        ChangeUniversityButton.addTarget(self,
                                         action: #selector(changeUniversity), for: .touchUpInside)
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: ChangeUniversityButton), animated: true)
        self.navigationItem.searchController = UISearchController(searchResultsController: nil)
        let searchBar = self.navigationItem.searchController?.searchBar
        
        self.navigationItem.searchController?.obscuresBackgroundDuringPresentation = true
        searchBar?.delegate = self
        searchBar?.showsBookmarkButton = true
        searchBar?.setImage(UIImage(systemName: "slider.horizontal.3"), for: .bookmark, state: .normal)
        searchBar?.placeholder = "Поиск"
        searchBar?.setValue("Отмена", forKey: "cancelButtonText")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        loadData()
        super.viewDidLoad()
    }
    
    func loadData() {
        activityIndicator.startAnimating()
        teachers = []
        if let savedData = UserDefaults.standard.data(forKey: "all_univers"),
           let loadedArray = try? PropertyListDecoder().decode([University].self, from: savedData) {
            self.allUniversities = loadedArray
        }
        if self.allUniversities.count != 0{
            for university in self.allUniversities{
                if university.name == self.navigationItem.title{
                    if currentFilters.count != 0{
                        for department in university.departments{
                            if currentFilters.contains(department.name){
                                for teacher in department.teachers{
                                    let teacher_toShow = Teacher(fio: teacher.name, university: university.name, faculty: "", chair: department.name, imageURL: "", rating: Double(teacher.rating), degree: "Доцент", description: "description")
                                    self.teachers.append(teacher_toShow)
                                }
                            }
                        }
                    }else{
                        for department in university.departments{
                            for teacher in department.teachers{
                                let teacher_toShow = Teacher(fio: teacher.name, university: university.name, faculty: "", chair: department.name, imageURL: "", rating: Double(teacher.rating), degree: "Доцент", description: "description")
                                self.teachers.append(teacher_toShow)
                            }
                        }
                    }
                }
            }
            activityIndicator.stopAnimating()
            self.tableView.reloadData()
            
        }
        else{
            manager.loadUniversities{ result in
                switch result {
                case .success(let universities):
                    self.noInternetConnection = false
                    self.allUniversities = universities
                    for university in self.allUniversities{
                        if university.name == self.navigationItem.title{
                            if self.currentFilters.count != 0{
                                for department in university.departments{
                                    if self.currentFilters.contains(department.name){
                                        for teacher in department.teachers{
                                            let teacher_toShow = Teacher(fio: teacher.name, university: university.name, faculty: "", chair: department.name, imageURL: "", rating: Double(teacher.rating), degree: "Доцент", description: "description")
                                            self.teachers.append(teacher_toShow)
                                        }
                                    }
                                }
                            }
                            else{
                                for department in university.departments{
                                    
                                    for teacher in department.teachers{
                                        let teacher_toShow = Teacher(fio: teacher.name, university: university.name, faculty: "", chair: department.name, imageURL: "", rating: Double(teacher.rating), degree: "Доцент", description: "description")
                                        self.teachers.append(teacher_toShow)
                                    }
                                }
                            }
                        }
                    }
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                    
                case .failure(_):
                    self.showRetryButton()
                }
            }
        }
    }
}



extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if teachers.count == 0 && !activityIndicator.isAnimating && !noInternetConnection{
            showNotFoundLabel()
        }
        else{
            TeachersNotFoundLabel.removeFromSuperview()
        }
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

extension SearchViewController: ChangeUniversityViewControllerDelegate {
    func setStartCheckmark() {
        
    }
    
    func recieveChoosenOption() {
        
    }
}
