// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class LinkedList {
    var head : Node?
    
    func addAsHead(node : Node){
        if self.head == nil {
            self.head = node
        }else{
            node.nextNode = self.head
            self.head = node
        }
        
    }
    
    func addAsTailRecursive(node : Node){
        if self.head == nil {
            self.head = node
        }else{
            self.head?.addNode(node)
        }
    }
    
    func addAsTailLoop(node : Node){
        if self.head == nil{
            self.head = node
        }else{
            var currentNode = self.head!
            while (currentNode.nextNode != nil){
                currentNode = currentNode.nextNode!
            }
            currentNode.nextNode = node
        }
    }
}

class Node {
    var data : Int!
    var nextNode : Node?
    
    init(data : Int){
        self.data = data
    }
    
    func addNode(node: Node){
        if self.nextNode != nil {
            addNode(node)
        }else{
            self.nextNode = node
        }
    }
}

var linkedList = LinkedList()

var node1 = Node(data: 1)
var node2 = Node(data: 2)
var node3 = Node(data: 3)

linkedList.addAsHead(node1)
println(linkedList.head?.data)

linkedList.addAsHead(node2)
println(linkedList.head?.data)

linkedList.addAsTailLoop(node3)










