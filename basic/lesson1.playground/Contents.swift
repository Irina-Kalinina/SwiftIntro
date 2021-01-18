import UIKit

// 1. Решить квадратное уравнение

let a: Float = 2
let b: Float = 1
let c: Float = -10
let discriminant = (b*b) - (4*a*c)

if discriminant == 0 {
    let x1: Float = (-b) / (2 * a)
    print("Дискриминант равен нулю, уравнение имеет один корень. x = " + String(x1))
} else if discriminant > 0 {
    let x1: Float = (-b + sqrt(discriminant)) / (2 * a)
    let x2: Float = (-b - sqrt(discriminant)) / (2 * a)
    print("Уравнение имеет два корня. x1 = " + String(x1) + ", x2 = " + String(x2))
} else {
    print("Дискриминант меньше 0, корней нет")
}


// 2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника

let cathetus1: Float = 5.4
let cathetus2: Float = 2.1

let s: Float = (cathetus1 * cathetus2) / 2
let hypothenuse: Float = sqrt((cathetus1*cathetus1) + (cathetus2*cathetus2))
let p: Float = cathetus1 + cathetus2 + hypothenuse
print("Гипотенуза треугольника с катетами " + String(cathetus1) + " и " + String(cathetus2) + " = " + String(hypothenuse) + ", площадь = " + String(s) + ", периметр = " + String(p))

// 3.* Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет

let deposit: Float = 10000
let percent: Float = 6 / 100

let total: Float = deposit + (deposit * percent)
print("Через 5 лет сумма вашего вклада составит " + String(total) + " рублей")
