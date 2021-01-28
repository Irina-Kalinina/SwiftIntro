import UIKit

import UIKit

// 1. Написать функцию, которая определяет, четное число или нет.
func evenNumber(_ number: Int) -> Bool{
//    if number % 2 == 0 {
//        print("Введенное число - четное")
//    }else{
//        print("Введенное число - нечетное")
//    }
//}
    return number % 2 == 0
}

evenNumber(8)

// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func isNumber(_ value: Int, devidedBy devider: Int) -> Bool{
//    if number % 3 == 0 {
//        print("Введенное число делится на 3 без остатка")
//    }else{
//        print("Введенное число не делится на 3 без остатка")
//    }
//}
    if devider == 0{
        return false
    } else {
        return value % devider == 0
    }
}
isNumber(16, devidedBy: 3)
isNumber(5, devidedBy: 3)
isNumber(0, devidedBy: 3)

// 3. Создать возрастающий массив из 100 чисел.
var newArray: [Int] = []
var element: Int = 0

while newArray.count < 100{
    element += 1
    newArray.append(element)
}
print(newArray)

// var oneMoreArray: Array<Int> = Array(1...100)

// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

var sortedArray = newArray.filter {$0 % 2 != 0 && $0 % 3 == 0}
print(sortedArray)

// newArray.removeAll(where: { evenNumber($0) || !isNumber($0, devidedBy: 3) })

//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
//Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
var res_fibonachi: [Double] = []

func fillArrayWithFibonachi(array: inout[Double], elements: UInt){
    repeat{
        if array.count > 1 {
            array.append(array[array.count-1] + array[array.count-2])
        } else if array.count == 0 {
            array.append(0)
        } else {
            array.append(1)
        }
    } while array.count < elements
}

fillArrayWithFibonachi(array: &res_fibonachi, elements: 100)
print("\n")
print(res_fibonachi)


//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
//b. Пусть переменная p изначально равна двум — первому простому числу.
//c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
//d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
//e. Повторять шаги c и d, пока возможно.

var res_primeNumbers: [UInt] = []

func isPrimeNumber(value: UInt) -> Bool {
    if value > 1{
        for i in 2..<value{
            if value % i == 0{
                return false // делится на число отличное от 1 и самого себя
            }
        }
        return true // простое число
    }
    return false // 0,1
}

func fillArrayWithPrimes (array: inout [UInt], elements: UInt){
    var checkNumber: UInt = 0
    repeat{
        if isPrimeNumber(value: checkNumber) {
            array.append(checkNumber)
        }
        checkNumber += 1
    } while array.count < elements
}

fillArrayWithPrimes(array: &res_primeNumbers, elements: 100)
print("\n")
print(res_primeNumbers.count)
print(res_primeNumbers)
