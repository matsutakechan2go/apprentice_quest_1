
#定数の定義
MARKS = ['ハート', 'ダイア', 'クローバー', 'スペード']
NUMBERS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'ジャック', 'クイーン', 'キング', 'エース']

#カードを生成するメソッド
def create_card
  card = [] #カードを格納するための箱をつくる
  MARKS.each do |mark|
    NUMBERS.each do |number|
      card << { mark: mark, number: number}
    end
  end
    card #上記で作成されたカードを呼び出す
end

#カードをシャッフルするメソッド
def shuffle(card)
  card.shuffle!
end

#カードを配るメソッド
def hands_card(card)

end


#ゲームを開始するメソッド
def card_game

card_game