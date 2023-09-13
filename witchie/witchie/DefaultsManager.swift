//
//  DefaultsManager.swift
//  witchie
//
//  Created by ditthales on 13/09/23.
//

import Foundation

class DefaultsManager: ObservableObject{
    
    static var shared = DefaultsManager()
    
    func setNewRecord(patch: Int, level: Int, value: Int){
        UserSettings.records[patch]![level] = value
        UserDefaults.standard.set(UserSettings.records[patch], forKey: "records\(patch)")
    }
    
    func setUserFirstTime(value: Bool){
        UserSettings.isNotFirstTime = value
        UserDefaults.standard.set(value, forKey: "isNotFirstTime")
    }
    
    func setLevelCompleted(level: Int){
        LevelCompleted.isCompleted[1]![level] = true
        UserDefaults.standard.set(LevelCompleted.isCompleted[1], forKey: "CurrentLevel")
    }
    
    func setSoundPreference(value: Bool){
        UserDefaults.standard.set(value, forKey: "isSoundOn")
    }
    
    func getSoundPreference() -> Bool{
        return UserDefaults.standard.bool(forKey: "isSoundOn")
    }
    
    func gameStarted(){
        //Isso aqui foi como consegui fazer pra os usuários não perderem seu progresso:
        //Primeiro ele recebe os dados da chave que já existia "CurrentLevel"
        LevelCompleted.isCompleted[1] = UserDefaults.standard.array(forKey: "CurrentLevel") as? [Bool] ?? LevelCompleted.isCompleted[1]
        //Depois checa conflitos (especifico pro patch 1)
        if LevelCompleted.isCompleted[1]!.count < LevelModel.patchOne().count{
            let add = LevelModel.patchOne().count - LevelCompleted.isCompleted[1]!.count
            for _ in (0...add){
                LevelCompleted.isCompleted[1]!.append(false)
            }
            UserDefaults.standard.set(LevelCompleted.isCompleted[1], forKey: "CurrentLevel")
        }
        
        //pega se é a primeira vez do usuário
        UserSettings.isNotFirstTime = UserDefaults.standard.bool(forKey: "isNotFirstTime")
        
        //aqui começamos a salvar os recordes, a lógica é a mesma lá de cima, com a diferença que agora o patch 1 vai usar a chave "records1" o que facilita nossa vida depois
        
        for i in (1...UserSettings.records.count){
            UserSettings.records[i] = UserDefaults.standard.array(forKey: "records\(i)") as? [Int] ?? UserSettings.records[i]
            if UserSettings.records[i]!.count < LevelModel.getLevels(chapter: i).count {
                let add = LevelModel.getLevels(chapter: i).count - UserSettings.records[i]!.count
                for _ in (0...add){
                    UserSettings.records[i]!.append(0)
                }
            }
            UserDefaults.standard.set(UserSettings.records[i], forKey: "records\(i)")
        }
    }
}
