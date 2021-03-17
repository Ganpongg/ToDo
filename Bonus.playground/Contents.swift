import Foundation

func filterArray(firstArray: [Int], secondArray: [Int]) -> [Int] {
    var filteredArray: [Int] = []
    var secondDict = [Int: Int]()
    for number2 in secondArray {
        secondDict[number2] = number2
    }
    for number1 in firstArray {
        if secondDict[number1] != nil {
            filteredArray.append(number1)
        }
    }
    return filteredArray
}

filterArray(firstArray: [1, 2, 3], secondArray: [2, 3, 4])
filterArray(firstArray: [1, 2, 3, 4, 5], secondArray: [5, 4, 3, 2, 1])
filterArray(firstArray: [1, 3, 5], secondArray: [2, 4, 6])
filterArray(firstArray: [1, 2, 3], secondArray: [])
filterArray(firstArray: [], secondArray: [1, 2, 3])
