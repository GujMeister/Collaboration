import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create View Models
        let populationViewModel = PopulationViewModel()
        let speciePageVM = SpeciePageVM()
        let weatherVM = WeatherPageVM()
        
        // Create Main the view controllers
        let firstVC = AirQualityPageVC()
        let secondVC = SolarResourcePageVC()
        let thirdVC = SpeciePageVC(viewModel: speciePageVM)
        let fourthVC = WeatherPageVC(viewModel: weatherVM)
        let fifthVC = PopulationPageVC(viewModel: populationViewModel)
        
        // Create the tab bar controller and add view controllers to it
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstVC, secondVC, thirdVC, fourthVC, fifthVC]
        tabBarController.tabBar.backgroundColor = UIColor(hex: "262A34")
        
        // Create tab bar items with colors
        if let items = tabBarController.tabBar.items {
            setTabBarItemImage(for: items[0], systemName: "wind", selectedColor: UIColor(hex: "FDEA00"), normalColor: .systemGray4)
            setTabBarItemImage(for: items[1], systemName: "light.panel.fill", selectedColor: .orange, normalColor: .systemGray4)
            setTabBarItemImage(for: items[2], systemName: "bird.fill", selectedColor: UIColor(hex: "#32cd32"), normalColor: .systemGray4)
            setTabBarItemImage(for: items[4], systemName: "person.3.fill", selectedColor: .cyan, normalColor: .systemGray4)
            
        }
        
        if let items = tabBarController.tabBar.items {
            let yellowColor = UIColor(hex: "#FDEA00")
            let grayColor = UIColor.systemGray4
            
            if #available(iOS 15.0, *) {
                let configuration = UIImage.SymbolConfiguration(paletteColors: [grayColor, yellowColor])
                let multicolorImage = UIImage(systemName: "cloud.sun.fill", withConfiguration: configuration)
                let grayImage = UIImage(systemName: "cloud.sun.fill")?.withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
                
                items[3].selectedImage = multicolorImage
                items[3].image = grayImage
            } else {
                let yellowImage = UIImage(systemName: "cloud.sun.fill")?.withTintColor(yellowColor, renderingMode: .alwaysOriginal)
                let grayImage = UIImage(systemName: "cloud.sun.fill")?.withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
                
                items[3].selectedImage = yellowImage
                items[3].image = grayImage
            }
        }
        
        // Set the tab bar controller as root view controller
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    private func setTabBarItemImage(for tabBarItem: UITabBarItem, systemName: String, selectedColor: UIColor, normalColor: UIColor) {
        let selectedImage = UIImage(systemName: systemName)?.withTintColor(selectedColor, renderingMode: .alwaysOriginal)
        let normalImage = UIImage(systemName: systemName)?.withTintColor(normalColor, renderingMode: .alwaysOriginal)
        
        tabBarItem.selectedImage = selectedImage
        tabBarItem.image = normalImage
    }
}

