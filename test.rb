
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
output_card1 = player1_card.pop
output_card2 = player2_card.pop
puts "プレイヤー1のカードは#{output_card1}です"
puts "プレイヤー2のカードは#{output_card2}です"

