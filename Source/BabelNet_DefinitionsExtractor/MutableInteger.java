/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package babelnetwik;

/**
 *
 * @author akabiri
 */
public class MutableInteger {
    
    private int value=0;
    
    public MutableInteger(int val){
        value=val;
    }
    
    public synchronized int get(){
        return value;
    }
    
    public synchronized int increment(int increase){
        value+=increase;
        return value;
    }
    public synchronized int increment(){
        return ++value;
    }
}
