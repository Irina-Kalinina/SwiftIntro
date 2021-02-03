import UIKit

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

// MARK: - класс Car

enum CarModel{
    case porsche
    case mercedes
    case BMW
    case audi
    case alfaRomeo
    }

enum CarActions: String{
    case startEngine = "\nДвигатель запущен"
    case stallEngine = "\nДвигатель заглушен"
    case openWindows = "\nОкна открыты"
    case closeWindows = "\nОкна закрыты"
}

class Car{
    
    // свойства
    let model: CarModel
    let yearMade: UInt
    let maxSpeed: Double
    var engineState: CarActions
    var windowsState: CarActions
    static var carReleased: UInt = 0 // кол-во выпущенных машин
    
    // метод
    func action(type: CarActions){
        switch type {
        case .startEngine:
            print(type.rawValue)
            self.engineState = .startEngine
        case .stallEngine:
            print(type.rawValue)
            self.engineState = .stallEngine
        case .openWindows:
            print(type.rawValue)
            self.windowsState = .openWindows
        case .closeWindows:
            print(type.rawValue)
            self.windowsState = .closeWindows
        }
    }
    
    // конструктор
    init (model: CarModel, yearMade: UInt){
        self.model = model
        self.yearMade = yearMade
        self.maxSpeed = 200
        self.engineState = .stallEngine
        self.windowsState = .closeWindows
        Car.carReleased += 1
    }
    
    deinit {
        Car.carReleased -= 1
    }
    
    // значения свойств экземпляров
    func carInfo(){
        print("\nИнформация о машине:")
        print("Модель: \(model)")
        print("Год выпуска: \(yearMade)")
        print("Максимальная скорость: \(maxSpeed)")
    }
    
    static func printReport(){
        print("Всего создано машин: \(carReleased)")
    }
}


var car1 = Car(model: .audi, yearMade: 2008)
car1.carInfo()
car1.action(type: .startEngine)
car1.action(type: .openWindows)
print("----------------------")
var car2 = Car(model: .BMW, yearMade: 2021)
car2.carInfo()
car2.action(type: .startEngine)
print("----------------------")

// MARK: - наследник trunkCar

class TrunkCar: Car{
    
    // свойство
    var safetyBelt: Bool
    
    //метод
    override func action(type: CarActions) {
        switch type {
        case .startEngine:
            if safetyBelt{
                print(type.rawValue)
                self.engineState = .startEngine
            } else {
                print("Пожалуйста, застегните ремень безопасности!")
            }
        case .stallEngine:
            print(type.rawValue)
            self.engineState = .stallEngine
        case .openWindows:
            if engineState == CarActions.startEngine{
                print(type.rawValue)
                self.windowsState = .openWindows
            } else {
                print("Чтобы открыть окна, нужно сначала завести машину!")
            }
        case .closeWindows:
            print(type.rawValue)
            self.windowsState = .closeWindows
        }
    }
    
    // конструктор
    init(model: CarModel, yearMade: UInt, safetyBelt: Bool) {
        self.safetyBelt = safetyBelt
        super.init(model: model, yearMade: yearMade)
    }
}

var trunkCar1 = TrunkCar(model: .mercedes, yearMade: 2020, safetyBelt: false)
trunkCar1.action(type: .startEngine)
trunkCar1.action(type: .openWindows)
print("----------------------")
var trunkCar2 = TrunkCar(model: .BMW, yearMade: 2021, safetyBelt: true)
trunkCar2.action(type: .startEngine)
trunkCar2.action(type: .openWindows)
print("----------------------")

// MARK: - наследник sportСar

final class SportСar: Car{
    
    enum SportCarActions: String {
        case speedUp = "Прибавим скорость на 5 км/ч"
        case slowDown = "Сбавим скорость на 5км/ч"
    }
    
    // свойства
    var gasoline: Double
    var maxGasoline: Double
    var gasolinePerHundred: Double
    var speed: Double
    
    // методы
    func gasolineCounter() {
        switch gasoline{
        case 0...5:
            print("Пора искать заправку! Бензина всего \(gasoline) литров")
        case 5.1...15:
            print("В баке \(gasoline) литров бензина. Этого пока достаточно, но очень скоро понадобится дозаправка")
        case 15.1...maxGasoline-5:
            print("В баке \(gasoline) литров бензина, дозаправка не нужна")
        case maxGasoline-4.99...maxGasoline:
            print("У вас \(gasoline) литров бензина. Это почти полный бак, дозаправка понадобится не скоро")
        default:
            print("Введено некорректное значение количества бензина")
        }
    }
    
    func distanceCheck() {
        let totalDistance = (gasoline / gasolinePerHundred) * 100
        if totalDistance > 0 && (maxGasoline >= gasoline) {
            print("С текущем количеством бензина машина сможет проехать еще \(totalDistance) километров")
        } else if totalDistance < 0 {
            print("Бензина осталось \(gasoline) литров, пора заправиться!")
        } else {
            print("Введено некорректное значение количества бензина, посчитать расстояние нельзя")
        }
    }

    
    func speedControl(type: SportCarActions) {
        switch type {
        case .speedUp:
            if maxSpeed >= speed && (engineState == CarActions.startEngine) {
                print(type.rawValue)
                self.speed += 5
                print("Текущая скорость: \(speed)км/ч")
            } else if maxSpeed < speed {
                print("Быстрее разогнаться нельзя. Максимальная скорость машины \(maxSpeed)км/ч")
            } else {
                print("Сначала запустите двигатель!")
            }
        case .slowDown:
            if speed != 0 {
                print(type.rawValue)
                self.speed -= 5
            } else {
                print("Машина не движется")
            }
        }
    }
    
    // конструктор
    init(model: CarModel, yearMade: UInt, gasoline: Double) {
        self.gasoline = gasoline
        self.speed = 0.0
        self.maxGasoline = 55.0
        self.gasolinePerHundred = 10.0
        super.init(model: model, yearMade: yearMade)
    }
}

var sportCar1 = SportСar(model: .alfaRomeo, yearMade: 2014, gasoline: 0)
sportCar1.distanceCheck()
sportCar1.gasolineCounter()
sportCar1.speedControl(type: .speedUp)
print("----------------------")
var sportCar2 = SportСar(model: .audi, yearMade: 2017, gasoline: 40.5)
sportCar2.action(type: .startEngine)
sportCar2.speedControl(type: .speedUp)
sportCar2.speedControl(type: .speedUp)
sportCar2.gasolineCounter()
sportCar2.distanceCheck()
print("----------------------")
var sportCar3 = SportСar(model: .mercedes, yearMade: 2008, gasoline: 60)
sportCar3.gasolineCounter()
sportCar3.distanceCheck()

