import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UI Components
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        // Load ảnh nền Kanha vừa tải lên
        iv.image = UIImage(named: "bg_image") 
        iv.backgroundColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Free Fire VN"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bundleLabel: UILabel = {
        let label = UILabel()
        label.text = "com.garena.ffvn"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let items = ["⦿ AIM", "📍 Định vị", "⚙️ MOD"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 2
        sc.backgroundColor = UIColor(white: 0.1, alpha: 0.6)
        sc.selectedSegmentTintColor = UIColor(red: 0.1, green: 0.5, blue: 0.9, alpha: 1.0)
        sc.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
        sc.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)], for: .selected)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    // Khung Menu Patch (Hiệu ứng kính mờ)
    private let menuContainer: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(white: 0.3, alpha: 0.5).cgColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let menuTitle: UILabel = {
        let label = UILabel()
        label.text = "⚙️ MENU PATCH"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let autoBadge: UILabel = {
        let label = UILabel()
        label.text = "AUTO"
        label.font = UIFont.boldSystemFont(ofSize: 10)
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
        btn.setTitle("▶  Mở ứng dụng", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.backgroundColor = UIColor(red: 0.1, green: 0.6, blue: 0.9, alpha: 1.0)
        btn.layer.cornerRadius = 25
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let bottomBar: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blur)
        view.layer.cornerRadius = 35
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(white: 0.3, alpha: 0.5).cgColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Data
    private let modItems = [
        ("AVATA HEAD (AIM)", "Bật lúc vào game Load 40%"),
        ("AVATA NỀCK ANTNEN", "Bật lúc vào game Load 40%"),
        ("AVATA DRAG", "Bật lúc vào game Load 40%"),
        ("AVATA AIM BOT", "Bật lúc vào game Load 40%")
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        launchButton.addTarget(self, action: #selector(handleLaunch), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(bundleLabel)
        view.addSubview(segmentedControl)
        view.addSubview(menuContainer)
        view.addSubview(launchButton)
        view.addSubview(bottomBar)
        
        // Thêm contentView của Blur View để chứa các thành phần con
        let contentView = menuContainer.contentView
        contentView.addSubview(menuTitle)
        contentView.addSubview(autoBadge)
        contentView.addSubview(tableView)
        
        // Setup Tabbar fake
        let homeIcon = UIImageView(image: UIImage(systemName: "house.fill"))
        homeIcon.tintColor = .white
        homeIcon.translatesAutoresizingMaskIntoConstraints = false
        let homeLabel = UILabel()
        homeLabel.text = "Home"
        homeLabel.textColor = .white
        homeLabel.font = UIFont.systemFont(ofSize: 10)
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let appsIcon = UIImageView(image: UIImage(systemName: "square.grid.2x2.fill"))
        appsIcon.tintColor = .systemBlue
        appsIcon.translatesAutoresizingMaskIntoConstraints = false
        let appsLabel = UILabel()
        appsLabel.text = "Apps"
        appsLabel.textColor = .systemBlue
        appsLabel.font = UIFont.systemFont(ofSize: 10)
        appsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBar.contentView.addSubview(homeIcon)
        bottomBar.contentView.addSubview(homeLabel)
        bottomBar.contentView.addSubview(appsIcon)
        bottomBar.contentView.addSubview(appsLabel)
        
        NSLayoutConstraint.activate([
            // Background
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Header (Bỏ icon FF vì Kanha chưa có ảnh, chỉ để chữ giống ảnh)
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bundleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            bundleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Segmented
            segmentedControl.topAnchor.constraint(equalTo: bundleLabel.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            // Menu Container
            menuContainer.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            menuContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            menuContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            menuContainer.bottomAnchor.constraint(equalTo: launchButton.topAnchor, constant: -25),
            
            menuTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            menuTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            autoBadge.centerYAnchor.constraint(equalTo: menuTitle.centerYAnchor),
            autoBadge.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            autoBadge.widthAnchor.constraint(equalToConstant: 55),
            autoBadge.heightAnchor.constraint(equalToConstant: 22),
            
            tableView.topAnchor.constraint(equalTo: menuTitle.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            // Launch Button
            launchButton.bottomAnchor.constraint(equalTo: bottomBar.topAnchor, constant: -20),
            launchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            launchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            launchButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Bottom Bar
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            bottomBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomBar.widthAnchor.constraint(equalToConstant: 220),
            bottomBar.heightAnchor.constraint(equalToConstant: 70),
            
            homeIcon.topAnchor.constraint(equalTo: bottomBar.contentView.topAnchor, constant: 15),
            homeIcon.centerXAnchor.constraint(equalTo: bottomBar.contentView.leadingAnchor, constant: 55),
            homeLabel.topAnchor.constraint(equalTo: homeIcon.bottomAnchor, constant: 2),
            homeLabel.centerXAnchor.constraint(equalTo: homeIcon.centerXAnchor),
            
            appsIcon.topAnchor.constraint(equalTo: bottomBar.contentView.topAnchor, constant: 15),
            appsIcon.centerXAnchor.constraint(equalTo: bottomBar.contentView.trailingAnchor, constant: -55),
            appsLabel.topAnchor.constraint(equalTo: appsIcon.bottomAnchor, constant: 2),
            appsLabel.centerXAnchor.constraint(equalTo: appsIcon.centerXAnchor)
        ])
    }
    
    @objc private func handleLaunch() {
        if let url = URL(string: "garena-ffvn://") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - TableView
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
        return 80
    }
}

// MARK: - Custom Cell (Bỏ khung viền, phẳng như ảnh)
class ModCell: UITableViewCell {
    private let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.4, alpha: 0.6)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let icon = UIImageView(image: UIImage(systemName: "cube.box.fill"))
        icon.tintColor = UIColor(red: 0.3, green: 0.6, blue: 1.0, alpha: 1.0)
        icon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 22),
            icon.heightAnchor.constraint(equalToConstant: 22)
        ])
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
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleSwitch: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = .systemBlue
        sw.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
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
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(toggleSwitch)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 46),
            iconView.heightAnchor.constraint(equalToConstant: 46),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
            statusLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            toggleSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            toggleSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    func configure(title: String, subtitle: String, isOn: Bool, tag: Int) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        toggleSwitch.isOn = isOn
        toggleSwitch.tag = tag
        toggleSwitch.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
        
        statusLabel.text = isOn ? "● Đang bật · 4 quy tắc" : "● Đang tắt · 4 quy tắc"
        statusLabel.textColor = isOn ? .systemGreen : .gray
    }
    
    @objc private func toggleChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "mod_\(sender.tag)")
        statusLabel.text = sender.isOn ? "● Đang bật · 4 quy tắc" : "● Đang tắt · 4 quy tắc"
        statusLabel.textColor = sender.isOn ? .systemGreen : .gray
    }
}
