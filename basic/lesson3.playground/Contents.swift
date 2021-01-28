import UIKit

//1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

// MARK: - SportCar

enum SportCarModel{
    case porsche
    case mercedes
    case BMW
    case audi
    case alfaRomeo
    }

enum SportCarActions{
    case startEngine
    case stallEngine
    case openWindows
    case closeWindows
    case stowCargo
    case unloadCargo
}

fileprivate struct SportCar{
    
    // свойства
    let model: SportCarModel
    let yearMade: UInt
    let trunkVolume: Double
    var isEngineRunning: Bool
    var areWindowsOpen: Bool
    var trunkVolumePacked: Double
    let maxSpeed: Double
    
    // методы
    mutating func closeWindows(windows: SportCarActions){
        if isEngineRunning && (speed >= 200) {
            areWindowsOpen = false
            print("Во время движения на скорости от 200 км/ч окна должны быть закрыты")
        }
    }
    
    var speed: Double {
        didSet{
            let speedChange = speed - oldValue
            if (speed <= maxSpeed) && (speed != 0) {
                print("Скорость движения изменилась на \(speedChange). Текущая скорость - \(speed)")
            } else {
                print("Текущая скорость - \(speed)")
            }
        }
    }
    
    
    mutating func changeSpeed(newSpeed: Double){
        speed = newSpeed
        isEngineRunning = true
        if speed > maxSpeed{
            print("Разогнаться до такой скорости невозможно, максимальная скорость машины - \(maxSpeed)")
            speed = 0
        } else if (maxSpeed - speed <= 100) {
            print("Скорость машины слишком высокая. Возможно, стоит притормозить")
        } else {
            print("Вы очень аккуратный водитель, так держать!")
        }
    }
    
    // значения свойств экземпляров
    func sportCarInfo(){
        print("\nИнформация о машине: ")
        print("Модель: \(model)")
        print("Год выпуска: \(yearMade)")
        print("Объем багажника: \(trunkVolume)")
        print("Двигатель \(isEngineRunning ? "запущен" : "заглушен")")
        print("Окна \(areWindowsOpen ? "открыты" : "закрыты")")
        print("Заполенный объем багажника: \(trunkVolumePacked), доступно еще \(trunkVolume - trunkVolumePacked)")
        print("Максимальная скорость: \(maxSpeed)\n")
    }
    
    // инициализатор
    init(model: SportCarModel, yearMade: UInt, trunkVolume: Double, trunkVolumePacked: Double){
        self.model = model
        self.yearMade = yearMade
        self.trunkVolume = trunkVolume
        self.isEngineRunning = false
        self.areWindowsOpen = false
        self.trunkVolumePacked = trunkVolumePacked
        self.speed = 0.0
        self.maxSpeed = 250.0
    }
    
}

fileprivate var sportCar1 = SportCar(model: .BMW, yearMade: 1999, trunkVolume: 10.00, trunkVolumePacked: 5.00)
fileprivate var sportCar2 = SportCar(model: .audi, yearMade: 2020, trunkVolume: 5.00, trunkVolumePacked: 0)
fileprivate var sportCar3 = SportCar(model: .mercedes, yearMade: 2007, trunkVolume: 20.00, trunkVolumePacked: 17.00)

sportCar1.sportCarInfo()
sportCar2.sportCarInfo()
sportCar3.sportCarInfo()

print("----------")
sportCar1.changeSpeed(newSpeed: 150)
sportCar1.closeWindows(windows: .closeWindows)
print("----------")
sportCar2.changeSpeed(newSpeed: 60)
sportCar2.changeSpeed(newSpeed: 250)
sportCar2.closeWindows(windows: .closeWindows)
print("----------")
sportCar3.changeSpeed(newSpeed: 350)
sportCar3.closeWindows(windows: .closeWindows)
print("----------")

// MARK: - TrunkCar

enum TrunkCarModel{
    case volvo
    case nissan
    case man
    case iveco
}

enum TrunkCarActions{
    case startEngine
    case stallEngine
    case openWindows
    case closeWindows
    case stowCargo
    case unloadCargo
}

struct TrunkCar{
    
    // свойства
    let model: TrunkCarModel
    let yearMade: UInt
    let trunkVolume: Double
    var isEngineRunning: Bool
    var areWindowsOpen: Bool
    var trunkVolumePacked: Double
    let maxSpeed: Double
    
    
    // методы
    mutating func cargoStatus(newCargo: Double){
        if trunkVolume >= trunkVolumePacked + newCargo {
            trunkVolumePacked += newCargo
            print("Было успешно добавлено \(newCargo) кг нового груза. Еще можно погрузить \(trunkVolume - trunkVolumePacked)кг")
        } else if trunkVolumePacked == trunkVolume {
            print("Не удается загрузить новый груз - свободного места больше нет")
        } else{
            print("Не удается загрузить новый груз - свободно \(trunkVolume - trunkVolumePacked)кг. Максимальная вместимость грузовика - \(trunkVolume)кг, сейчас кузов уже заполнен на \(trunkVolumePacked)кг")
        }
    }
    
    // значения свойств экземпляров
    func TrunkCarInfo(){
        print("\nИнформация о грузовике: ")
        print("Модель: \(model)")
        print("Год выпуска: \(yearMade)")
        print("Объем кузова: \(trunkVolume)")
        print("Двигатель \(isEngineRunning ? "запущен" : "заглушен")")
        print("Окна \(areWindowsOpen ? "открыты" : "закрыты")")
        print("Кузов заполнен на: \(trunkVolumePacked)кг, доступно еще \(trunkVolume - trunkVolumePacked)кг")
        print("Максимальная скорость: \(maxSpeed)\n")
    }
    
    // инициализатор
    init(model: TrunkCarModel, yearMade: UInt, trunkVolume: Double, trunkVolumePacked: Double) {
        self.model = model
        self.yearMade = yearMade
        self.trunkVolume = trunkVolume
        self.isEngineRunning = false
        self.areWindowsOpen = false
        self.trunkVolumePacked = trunkVolumePacked
        self.maxSpeed = 200.0
    }
}

var trunkCar1 = TrunkCar(model: .volvo, yearMade: 2016, trunkVolume: 120.0, trunkVolumePacked: 100.5)
var trunkCar2 = TrunkCar(model: .iveco, yearMade: 2000, trunkVolume: 220.0, trunkVolumePacked: 0.0)


trunkCar1.TrunkCarInfo()
trunkCar2.TrunkCarInfo()

print("----------")
trunkCar1.cargoStatus(newCargo: 30)
trunkCar1.cargoStatus(newCargo: 19.5)
print("----------")
trunkCar2.cargoStatus(newCargo: 200.5)
