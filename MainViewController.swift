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
        view.backgroundColor = UIColor(red: 0.1, green: 0.0, blue: 0.05, alpha: 0.75)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Free Fire VN"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.systemPink.cgColor
        label.layer.shadowRadius = 5.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let items = ["⦿ AIM", "📍 Định vị", "⚙️ MOD"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 2
        sc.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
        sc.selectedSegmentTintColor = UIColor.systemPink
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
        label.textColor = UIColor.systemPink
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemPink.cgColor
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
        btn.backgroundColor = .systemPink
        btn.layer.cornerRadius = 12
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let gradientLayer = CAGradientLayer()
    
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
        setupSnow()
        tableView.delegate = self
        tableView.dataSource = self
        launchButton.addTarget(self, action: #selector(handleLaunch), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = launchButton.bounds
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
        
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemRed.cgColor,
            UIColor.systemPink.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        launchButton.layer.insertSublayer(gradientLayer, at: 0)
        
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
    
    // MARK: - Snow Effect
    private func setupSnow() {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.center.x, y: -50)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        emitter.zPosition = -1
        
        let cell = CAEmitterCell()
        cell.birthRate = 15
        cell.lifetime = 10.0
        cell.velocity = 120
        cell.velocityRange = 40
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 4
        cell.scale = 0.04
        cell.scaleRange = 0.02
        cell.color = UIColor(red: 1.0, green: 0.8, blue: 0.9, alpha: 0.7).cgColor
        
        let size = CGSize(width: 20, height: 20)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.fillEllipse(in: CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        cell.contents = image?.cgImage
        emitter.emitterCells = [cell]
        view.layer.addSublayer(emitter)
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
        view.backgroundColor = UIColor(red: 0.15, green: 0.05, blue: 0.08, alpha: 0.85)
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemPink.withAlphaComponent(0.3).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
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
        label.textColor = .systemRed
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
        sw.onTintColor = .systemPink
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
        statusLabel.textColor = isOn ? .systemPink : .gray
    }
    
    @objc private func toggleChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "mod_\(sender.tag)")
        statusLabel.text = sender.isOn ? "● Đang bật · 4 quy tắc" : "● Đang tắt · 4 quy tắc"
        statusLabel.textColor = sender.isOn ? .systemPink : .gray
    }
}
