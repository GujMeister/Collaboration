import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Create the view controllers
        let firstVC = AirQualityPageVC()
        let secondVC = SolarResourcePageVC()
        let thirdVC = SpeciePageVC()
        let fourthVC = WeatherPageVC()
        let fifthVC = PopulationPageVC()

        // Set tab bar items
        firstVC.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "1.circle"), tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "2.circle"), tag: 1)
        thirdVC.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "3.circle"), tag: 2)
        fourthVC.tabBarItem = UITabBarItem(title: "Fourth", image: UIImage(systemName: "4.circle"), tag: 3)
        fifthVC.tabBarItem = UITabBarItem(title: "Fifth", image: UIImage(systemName: "5.circle"), tag: 4)

        // Create the tab bar controller and add view controllers to it
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstVC, secondVC, thirdVC, fourthVC, fifthVC]
        tabBarController.tabBar.backgroundColor = .white

        // Set the tab bar controller as root view controller
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
