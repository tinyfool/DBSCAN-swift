//
//  DBSCAN.swift
//
//
//  Created by Peiqiang Hao on 2018/12/3.
//  
//

import Foundation

class DBSCAN<T:Hashable> {
    
    var db:[T]
    var label:[T:String]
    
    init(aDB:[T])  {
        
        db = aDB
        label = [T:String]()
        for P in db {
            self.label[P] = "undefined"
        }
    }
    
    func DBSCAN(distFunc:(T,T)->Double, eps:Double, minPts:Int) {
        
        var C = 0
        for P in self.db {
            
            if self.label[P] != "undefined" {
                continue
            }
            
            var N = self.rangeQuery(distFunc: distFunc, Q: P, eps: eps)
            
            if N.count < minPts  {
                
                self.label[P] = "Noise"
                continue
            }
            
            C = C + 1
            self.label[P] = "\(C)"
            
            for Q in N {
                
                if self.label[Q] == "Noise" {
                    self.label[Q] = "\(C)"
                }
                
                if self.label[Q] != "undefined" {
                    continue
                    
                }
                
                label[Q] = "\(C)"
                let N1 = self.rangeQuery(distFunc: distFunc, Q: Q, eps: eps)
                if N1.count >= minPts  {
                    
                    N.append(contentsOf: N1)
                    continue
                }
            }
        }
    }
    
    func rangeQuery(distFunc:(T,T)->Double, Q:T, eps:Double)->[T] {
        
        var Neighbors = [T]()
        for P in self.db {
            if distFunc(Q, P) <= eps {
                Neighbors.append(P)                 
            }
        }
        return Neighbors
    }
}
