//
//  Colors.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 03.12.2023.
//

import UIKit

struct Colors {
    enum ColorScheme: String {
        case system
        case light
        case dark
    }
    static var colorScheme: ColorScheme {
        get {
            if let savedColorScheme = UserDefaults.standard.string(forKey: "colorScheme"),
                let colorScheme = ColorScheme(rawValue: savedColorScheme) {
                return colorScheme
            } else {
                let defaultColorScheme = ColorScheme.system.rawValue
                UserDefaults.standard.set(defaultColorScheme, forKey: "colorScheme")
                return .system
            }
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "colorScheme")
        }
    }
    public static func getColorSchemeForSegmentedControl() -> Int {
        switch Colors.colorScheme {
        case .light:
            return 0
        case .dark:
            return 2
        case .system:
            return 1
        }
    }
    /// 242 242 247 1.0
    static var background: UIColor {
        get {
            switch colorScheme {
            case .light:
                return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
            case .dark:
                return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
            case .system:
                if #available(iOS 12.0, *) {
                    if UIScreen.main.traitCollection.userInterfaceStyle == .light {
                        return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
                    } else {
                        return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
                    }
                } else {
                    return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
                }
            }
        }
    }
    /// 0 122 255 1.0
    static var buttonBackground: UIColor {
        get {
            switch colorScheme {
            case .light:
                return UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
            case .dark:
                return UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
            case .system:
                if #available(iOS 12.0, *) {
                    if UIScreen.main.traitCollection.userInterfaceStyle == .light {
                        return UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
                    } else {
                        return UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
                    }
                } else {
                    return UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
                }
            }
        }
    }
    /// 255 255 255 1.0
    static var buttonText: UIColor {
        get {
            switch colorScheme {
            case .light:
                return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            case .dark:
                return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            case .system:
                if #available(iOS 12.0, *) {
                    if UIScreen.main.traitCollection.userInterfaceStyle == .light {
                        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                    } else {
                        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                    }
                } else {
                    return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                }
            }
        }
    }
    /// 255 255 255 1.0
    static var textFieldsViewBackground: UIColor {
        get {
            switch colorScheme {
            case .light:
                return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            case .dark:
                return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            case .system:
                if #available(iOS 12.0, *) {
                    if UIScreen.main.traitCollection.userInterfaceStyle == .light {
                        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                    } else {
                        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                    }
                } else {
                    return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                }
            }
        }
    }
    /// 60 60 67 1.0
    static var separatorViewBackground: UIColor {
        get {
            switch colorScheme {
            case .light:
                return UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.36)
            case .dark:
                return UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.36)
            case .system:
                if #available(iOS 12.0, *) {
                    if UIScreen.main.traitCollection.userInterfaceStyle == .light {
                        return UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.36)
                    } else {
                        return UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.36)
                    }
                } else {
                    return UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.36)
                }
            }
        }
    }
    /// 0 0 0 1.0
    static var textFieldText: UIColor {
        get {
            switch colorScheme {
            case .light:
                return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
            case .dark:
                return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
            case .system:
                if #available(iOS 12.0, *) {
                    if UIScreen.main.traitCollection.userInterfaceStyle == .light {
                        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                    } else {
                        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                    }
                } else {
                    return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                }
            }
        }
    }
    /// 0 0 0 1.0
    static var labelText: UIColor {
        get {
            switch colorScheme {
            case .light:
                return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
            case .dark:
                return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
            case .system:
                if #available(iOS 12.0, *) {
                    if UIScreen.main.traitCollection.userInterfaceStyle == .light {
                        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                    } else {
                        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                    }
                } else {
                    return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                }
            }
        }
    }
    /// 0 0 0 1.0
    static var labelReadyText: UIColor {
        get {
            switch colorScheme {
            case .light:
                return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
            case .dark:
                return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
            case .system:
                if #available(iOS 12.0, *) {
                    if UIScreen.main.traitCollection.userInterfaceStyle == .light {
                        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                    } else {
                        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                    }
                } else {
                    return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                }
            }
        }
    }
    static var labelBackText: UIColor {
        get {
            switch colorScheme {
            case .light:
                return .blue
            case .dark:
                return .blue
            case .system:
                if #available(iOS 12.0, *) {
                    if UIScreen.main.traitCollection.userInterfaceStyle == .light {
                        return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
                    } else {
                        return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
                    }
                } else {
                    return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
                }
            }
        }
    }
    static var labelTitleText: UIColor {
        get {
            switch colorScheme {
            case .light:
                return .blue
            case .dark:
                return .blue
            case .system:
                if #available(iOS 12.0, *) {
                    if UIScreen.main.traitCollection.userInterfaceStyle == .light {
                        return .blue
                    } else {
                        return .blue
                    }
                } else {
                    return .blue
                }
            }
        }
    }
}
