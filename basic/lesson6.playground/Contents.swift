import UIKit

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

//MARK: - коллекция "очередь" с дженериком

struct Queue<T> {
    private var elements: [T] = []
    
    mutating func insert( _ element: T){
        elements.append(element)
    }
    
    mutating func delete() -> T? {
        guard elements.count > 0 else {return nil}
        return elements.removeFirst()
    }
    
    func printQueue() -> [T]{
        return elements
    }
    
    // сортировка по признаку
    mutating func sortByValue( _ predicate: (T) -> Bool) -> [T] {
        var tmp: [T] = []
        for element in elements {
            if predicate(element){
                tmp.append(element)
            }
        }
        return tmp
    }
    
    // сортировка сравнением
    mutating func sortByOrder( _ predicate: (T, T) -> Bool) -> [T] {
        for i in 0..<elements.count {
            for k in 0..<(elements.count - 1){
                if !predicate(elements[k], elements[i]) {
                    let tmp: T = elements[i];
                    elements[i] = elements[k];
                    elements[k] = tmp;
                }
            }
        }
        return elements
    }
    
}


// перебираем все элементы по переданным индексам, пропуская те, которые лежат за пределами массива (nil)
extension Queue {
    
    subscript(indexes: Int...) -> [T]{
        var result: [T] = []
        for index in indexes where index >= 0 && index < self.elements.count{
            result.append(self.elements[index])
        }
        return result
    }
}

//MARK: - класс под Queue

class Square{
    
    var side: Int
    
    func calculateS() -> Int{
        return side * 4
    }
    
    init(side: Int){
        self.side = side
    }
}

var queueToTest = Queue<Square>()
queueToTest.insert(Square(side: 4))
queueToTest.insert(Square(side: 8))
queueToTest.insert(Square(side: 3))
queueToTest.insert(Square(side: 19))
queueToTest.printQueue()

queueToTest.delete()
queueToTest.printQueue()


//сортировка
let sortedByTwo = queueToTest.sortByValue( { $0.side % 2 == 0) } )
let ascendingOrder = queueToTest.sortByOrder( {$0.side < $1.side } )
print(ascendingOrder.map({"\($0.side)"}))

print(queueToTest[1])
print(queueToTest[7])
