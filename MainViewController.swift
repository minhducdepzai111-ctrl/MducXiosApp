import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.05, alpha: 0.85)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Free Fire VN"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let items = ["⦿ AIM", "📍 Định vị", "⚙️ MOD"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 2
        sc.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
        sc.selectedSegmentTintColor = .systemBlue
        sc.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        sc.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    private let menuTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "⚙️ MENU PATCH"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let autoLabel: UILabel = {
        let label = UILabel()
        label.text = "AUTO"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemBlue.cgColor
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.register(ModCell.self, forCellReuseIdentifier: "ModCell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let launchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("▶ Mở ứng dụng", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Data
    private let modItems = [
        ("AVATA HEAD (AIM)", "Bật lúc vào game Load 40%"),
        ("AVATA NỀCK ANTNEN", "Bật lúc vào game Load 40%"),
        ("AVATA DRAG", "Bật lúc vào game Load 40%"),
        ("AVATA AIM BOT", "Bật lúc vào game Load 40%")
    ]
    
    private var hasCheckedLicense = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        launchButton.addTarget(self, action: #selector(handleLaunch), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Kiểm tra license khi màn hình hiện lên
        if !hasCheckedLicense {
            hasCheckedLicense = true
            checkLicenseStatus()
        }
    }
    
    // MARK: - License Logic
    private func checkLicenseStatus() {
        let savedKey = UserDefaults.standard.string(forKey: "MducXios_SavedKey")
        if savedKey == nil {
            showKeyPrompt()
        }
    }
    
    private func showKeyPrompt() {
        let alert = UIAlertController(title: "KÍCH HOẠT KEY", message: "Nhập Key MducXios để sử dụng", preferredStyle: .alert)
        alert.addTextField { tf in
            tf.placeholder = "Nhập Key..."
            tf.autocapitalizationType = .none
        }
        
        let activeAction = UIAlertAction(title: "Kích hoạt", style: .default) { [weak self] _ in
            guard let key = alert.textFields?.first?.text, !key.isEmpty else { return }
            
            LicenseManager.shared.checkLicense(key: key) { success, msg, deviceId in
                if success {
                    UserDefaults.standard.set(key, forKey: "MducXios_SavedKey")
                    let okAlert = UIAlertController(title: "Thành công", message: "Hạn dùng: \(msg)", preferredStyle: .alert)
                    okAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(okAlert, animated: true)
                } else {
                    let errAlert = UIAlertController(title: "Lỗi", message: msg, preferredStyle: .alert)
                    errAlert.addAction(UIAlertAction(title: "Thử lại", style: .default, handler: { _ in
                        self?.showKeyPrompt()
                    }))
                    self?.present(errAlert, animated: true)
                }
            }
        }
        
        alert.addAction(activeAction)
        self.present(alert, animated: true)
    }

    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(backgroundImageView)
        view.addSubview(overlayView)
        view.addSubview(titleLabel)
        view.addSubview(segmentedControl)
        view.addSubview(menuTitleLabel)
        view.addSubview(autoLabel)
        view.addSubview(tableView)
        view.addSubview(launchButton)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            menuTitleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30),
            menuTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            autoLabel.centerYAnchor.constraint(equalTo: menuTitleLabel.centerYAnchor),
            autoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            autoLabel.widthAnchor.constraint(equalToConstant: 60),
            autoLabel.heightAnchor.constraint(equalToConstant: 24),
            
            tableView.topAnchor.constraint(equalTo: menuTitleLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: launchButton.topAnchor, constant: -20),
            
            launchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            launchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            launchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            launchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func handleLaunch() {
        if let url = URL(string: "garena-ffvn://") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

// MARK: - TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModCell", for: indexPath) as! ModCell
        let item = modItems[indexPath.row]
        let isOn = UserDefaults.standard.bool(forKey: "mod_\(indexPath.row)")
        cell.configure(title: item.0, subtitle: item.1, isOn: isOn, tag: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

// MARK: - Custom Cell
class ModCell: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.2, green: 0.3, blue: 0.5, alpha: 1.0)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "● Đang tắt · 4 quy tắc"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleSwitch: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = .systemBlue
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupCell()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupCell() {
        contentView.addSubview(containerView)
        containerView.addSubview(iconView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(statusLabel)
        containerView.addSubview(toggleSwitch)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 44),
            iconView.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
            statusLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            toggleSwitch.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            toggleSwitch.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ])
    }
    
    func configure(title: String, subtitle: String, isOn: Bool, tag: Int) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        toggleSwitch.isOn = isOn
        toggleSwitch.tag = tag
        toggleSwitch.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
        
        statusLabel.text = isOn ? "● Đang bật · 4 quy tắc" : "● Đang tắt · 4 quy tắc"
    }
    
    @objc private func toggleChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "mod_\(sender.tag)")
        statusLabel.text = sender.isOn ? "● Đang bật · 4 quy tắc" : "● Đang tắt · 4 quy tắc"
    }
}
