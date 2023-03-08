//
//  ViewController.swift
//  TestCoreData
//
//  Created by haruto.makino on 2023/03/08.
//

import UIKit
import CoreData

//テキストフィールドデリゲートを追加
class ViewController: UIViewController,UITextFieldDelegate {

  //パーツの紐付け
  @IBOutlet weak var テキストフィールド: UITextField!
  @IBOutlet weak var テーブルビュー: UITableView!

  //EntityのMonster型の配列、モンスター変数を宣言
  //MonsterEntityから引っ張ってきたデータを入れるためMonseter型にしておく
  var モンスターオブジェクトの配列:[MonsterEntity] = []

  //NSManagedObjectContextをAppDelegate経由でオブジェト化
  //(UIApplication.shared.delegate as! AppDelegate)はAppDelegateへのパスのようなもの
  //AppDelegateのpersistentContainerのviewContext(NSManagedObjectContextのこと)を叩いてオブジェクト化してるだけ
  var マネージドオブジェクトコンテキスト = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


  override func viewDidLoad() {
    super.viewDidLoad()

    //テキストフィールドの処理先をViewController自身にしする
    テキストフィールド.delegate = self

    //NSFetchRequestを使って、「任意のEntityの全データを取得する」という取得条件を変数に打ち込む
    //<NSFetchRequestResult>の部分はジェネリックという文法らしい
    //NSFetchRequestResult型としてNSFetchRequestを処理しますよって感じ
    let 取得したいデータの条件 = NSFetchRequest<NSFetchRequestResult>(entityName: "MonsterEntity")
    do{
      //マネージドオブジェクトコンテキストのfetchに先ほどの取得条件を食わせて、返ってきたデータをMonster型に強制ダウンキャスト
      //取得したデータをモンスターオブジェクト変数に入れる
        モンスターオブジェクトの配列 = try マネージドオブジェクトコンテキスト.fetch(取得したいデータの条件) as! [MonsterEntity]
//        モンスターオブジェクトの配列 = try マネージドオブジェクトコンテキスト.fetch(MonsterEntity.fetchRequest())
    }catch{
      print("エラーだよ")
    }
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //キーボードを隠す
    textField.resignFirstResponder()


    //フィールドで作ったマネージドオブジェクトコンテキスト内にMonster型のマネージドオブジェクトを作る
    let 新規モンスターオブジェクト = MonsterEntity(context: self.マネージドオブジェクトコンテキスト)

    //新規モンスターオブジェクトのmonsterNameプロパティにテキストフィールドのテキストを上書き
    新規モンスターオブジェクト.monsterName = テキストフィールド.text

    //モンスターオブジェクトの配列に新規モンスターオブジェクトを追加する
    //これで元々のデータに新規のデータが追加された状態になった
    self.モンスターオブジェクトの配列.append(新規モンスターオブジェクト)

    //appdelegateのsaveContextメソッドを使って保存
    //saveContextは現在のマネージドオブジェクトの変更内容をDBに反映する
    (UIApplication.shared.delegate as! AppDelegate).saveContext()

    //取得したデータでテーブルの内容をリロード
    テーブルビュー.reloadData()
    //テキストフィールドの中身は空にしておく
    textField.text = ""
    return true
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return モンスターオブジェクトの配列.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let モンスター個別データ = モンスターオブジェクトの配列[indexPath.row]
    cell.textLabel?.text = モンスター個別データ.monsterName
    return cell
  }


}



