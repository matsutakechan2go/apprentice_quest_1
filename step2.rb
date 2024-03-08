# トランプの組み合わせを作る
card = []
numbers = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
marks = ['ハート', 'ダイヤ', 'クラブ', 'スペード']

marks.each do |mark|
  numbers.each do |number|
    card << "#{mark}の#{number}"
  end
end

#カードのシャッフル
deck = card.shuffle

puts "戦争を開始します"

player1_card = []
player2_card = []

while !deck.empty?
  player1_card << deck.pop if !deck.empty?
  player2_card << deck.pop if !deck.empty?
end

puts "カードが配られました"

#カードに強さを設定する
strength = {
  'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14
}

#1から10のカードは自動的に数値に変換する
for number in 2..10
  strength[number.to_s] = number
end


acquisition1 = []
acquisition2 = []

def play_war(player1_card, player2_card, strength, acquisition1, acquisition2)
  output_card1 = player1_card.pop
  output_card2 = player2_card.pop

  puts "プレイヤー1のカードは#{output_card1}です"
  puts "プレイヤー2のカードは#{output_card2}です"

  num1 = output_card1.split('の').last
  num2 = output_card2.split('の').last

  str_card1 = strength[num1]
  str_card2 = strength[num2]

  if str_card1 > str_card2
    puts "プレイヤー1が勝ちました。プレイヤー1はカードを2枚もらいました。"
    acquisition1 << output_card1 << output_card2
  elsif str_card1 < str_card2
    puts "プレイヤー2が勝ちました。プレイヤー2はカードを2枚もらいました。"
    acquisition2 << output_card1 << output_card2
  else
    puts "引き分けです。"
  end
end

while player1_card.any? && player2_card.any?
  puts "戦争！"
  play_war(player1_card, player2_card, strength, acquisition1, acquisition2)

  # 手札がなくなった場合の処理
  if player1_card.empty? && acquisition1.any?
    player1_card = acquisition1.shuffle
    acquisition1.clear
  end
  if player2_card.empty? && acquisition2.any?
    player2_card = acquisition2.shuffle
    acquisition2.clear
  end

  # どちらかがすべてのカードを失ったらループを抜ける
  break if player1_card.empty? && acquisition1.empty? || player2_card.empty? && acquisition2.empty?
end

# 最終的なカードの枚数の表示
puts "プレイヤー1のカードの枚数は#{player1_card.size + acquisition1.size}枚です。プレイヤー2のカードの枚数は#{player2_card.size + acquisition2.size}枚です。"

# 勝敗の決定
if player1_card.size + acquisition1.size > player2_card.size + acquisition2.size
  puts "プレイヤー1が1位、プレイヤー2が2位です。"
elsif player1_card.size + acquisition1.size < player2_card.size + acquisition2.size
  puts "プレイヤー1が2位、プレイヤー2が1位です。"
else
  puts "引き分けです。"
end

puts "戦争を終了します。"