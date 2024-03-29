
numbers = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
marks = ['ハート', 'ダイヤ', 'クラブ', 'スペード']

puts "戦争を開始します"

#トランプの組み合わせを作る
card = []

marks.each do |mark|
  numbers.each do |number|
    card << "#{mark}の#{number}" #文字列の生成
  end
end

#カードをシャッフル（山札ができる）
deck = card.shuffle

#カードをプレイヤー2人に均等に配る
player1_card = []
player2_card = []

while !deck.empty?
  player1_card << deck.pop if !deck.empty?
  player2_card << deck.pop if !deck.empty?
end

puts "カードが配られました"
puts "戦争！"


#手札から一番上（一番最後）のカードを出す
output_card1 = player1_card.pop
output_card2 = player2_card.pop
puts "プレイヤー1のカードは#{output_card1}です"
puts "プレイヤー2のカードは#{output_card2}です"


#カードに強さを設定する
strength = {
  'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14
}

#1から10のカードは自動的に数値に変換する
for number in 2..10
  strength[number.to_s] = number
end

#表にしたカード（文字列）から数字だけ取得
num1 = output_card1.split('の').last
num2 = output_card2.split('の').last

#強さの情報をstrengthから取得
str_card1 = strength[num1]
str_card2 = strength[num2]

#獲得したカードを入れる場所
acquisition1 = []
acquisition2 = []

if str_card1 > str_card2
  puts "プレイヤー1が勝ちました。プレイヤー1はカードを2枚もらいました"
  acquisition1 << output_card1 << output_card2
elsif str_card1 < str_card2
  puts "プレイヤー2が勝ちました。プレイヤーはカードを2枚もらいました。"
  acquisition2 << output_card1 << output_card2
else
  puts "引き分けです。"
end