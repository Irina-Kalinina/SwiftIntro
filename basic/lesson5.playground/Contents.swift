import UIKit

//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.


// MARK: - protocol & extension

enum CarModels{
    case audi
    case lada
    case nissan
    case toyota
}

enum CarActions: String{
    case startEngine = "\nДвигатель запущен."
    case stallEngine = "\nДвигатель заглушен."
    case safetyBeltOn = " Ремень безопасности будет застегнут автоматически"
    case safetyBeltOff = " Ремень безопасности расстегнут"
}

protocol Car: class {
    var model: CarModels {get set}
    var safetyBelt: CarActions {get set}
    var engineState: CarActions {get set}
    
    func changeEngineState(action: CarActions)
    
}

extension Car{
    func changeEngineState(action: CarActions){
        switch action{
        case .startEngine:
            self.engineState = .startEngine
            self.safetyBelt = .safetyBeltOn
            print(action.rawValue + safetyBelt.rawValue)
        case .stallEngine:
            self.engineState = .stallEngine
            self.safetyBelt = .safetyBeltOff
            print(action.rawValue + safetyBelt.rawValue)
        default:
            print("Что-то пошло не так. Пожалуйста, обратитесь в сервисный центр")
        }
    }
}


// MARK: -  класс TrunkCar

class TrunkCar: Car{
    
    // свойства протокола
    var model: CarModels
    var safetyBelt: CarActions
    var engineState: CarActions
    
    // свойства класса TrunkCar
    lazy var carInfo: String = ""
    var speed: UInt
    var maxSpeed: UInt
    
    // конструктор
    init(model: CarModels) {
        self.maxSpeed = 200
        self.model = model
        self.speed = 0
        self.safetyBelt = .safetyBeltOff
        self.engineState = .stallEngine
        self.carInfo = "\nМодель - \(self.model).\nМаксимальная скорость - \(self.maxSpeed)км/ч"
    }
    
    func changeSpeed(value: UInt){
        if value <= maxSpeed && (engineState == .startEngine){
            self.speed = value
            print("\nСкорость будет увеличена до \(speed) км/ч")
        } else if value > maxSpeed {
            print("\nЕзда на такой скорости невозможна. Максимальная скорость автомобиля - \(maxSpeed) км/ч")
        } else if engineState == .stallEngine {
            print("\nСначала нужно запустить двигатель")
        } else {
            print("\nСкорость автомобиля и так равна 0")
        }
    }
    
}

extension TrunkCar: CustomStringConvertible {
    var description: String{
        return "Информация об автомобиле: \(carInfo)"
    }
}

var trunkCar1 = TrunkCar(model: .audi)
trunkCar1.changeEngineState(action: .startEngine)
trunkCar1.changeSpeed(value: 120)
print(trunkCar1)
print("------------------------")
var trunkCar2 = TrunkCar(model: .lada)
print(trunkCar2)
trunkCar2.changeSpeed(value: 40)
print("------------------------")

// MARK: -  класс SportCar

class SportCar: Car{
    
    // свойства
    var model: CarModels
    var safetyBelt: CarActions
    var engineState: CarActions
    
    // свойства класса SportCar
    enum TrunkActions: String {
        case open = "Багажгник открыт"
        case close = "Багажник закрыт"
    }
    
    var trunkState: TrunkActions
    var haveTrunk: Bool
    
    // конструктор
    init(model: CarModels, haveTrunk: Bool) {
        self.model = model
        self.safetyBelt = .safetyBeltOff
        self.engineState = .stallEngine
        self.trunkState = .close
        self.haveTrunk = haveTrunk
    }
    
    // метод
    func changeTrunkState (type: TrunkActions){
        if haveTrunk {
            switch type{
            case .open:
                print(type.rawValue)
                self.trunkState = .open
            case .close:
                print(type.rawValue)
                self.trunkState = .close
            }
        } else {
            print("У машины нет багажника")
        }
    }
    
}

// меняем description у CustomStringConvertible
// собирает все св-а класса и выводит их значения
extension SportCar: CustomStringConvertible {
    var description: String{
        var description = "\n------- \(type(of: self)) -------\n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        description += "------------------------\n"
        return description
    }
}


var sportCar1 = SportCar(model: .toyota, haveTrunk: true)
print(sportCar1)
sportCar1.changeTrunkState(type: .open)
sportCar1.changeTrunkState(type: .close)
sportCar1.changeEngineState(action: .startEngine)
print("------------------------")
var sportCar2 = SportCar(model: .nissan, haveTrunk: false)
sportCar2.changeTrunkState(type: .open)
print(sportCar2)
sportCar2.changeEngineState(action: .startEngine)

