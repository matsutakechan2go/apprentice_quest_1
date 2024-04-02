# Card クラス: トランプカードを表す
class Card
  attr_reader :number, :mark  # カードの数字とマークの属性を読み取り可能にする

  # カードの強さを定義する定数
  VALUES = {'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14}

  # 初期化メソッド: カードを生成する時に数字とマークを設定
  def initialize(number, mark)
    @number = number
    @mark = mark
  end

  # カードの強さを取得するメソッド
  def strength
    VALUES.fetch(@number, @number.to_i)
  end

  # カードを文字列として表示するメソッド
  def to_s
    "#{@mark}の#{@number}"
  end
end

# Deck クラス: トランプのデッキを表す
class Deck
  attr_accessor :cards  # デッキ内のカードの配列

  def initialize
    @cards = []
    build_deck  # デッキを構築
    shuffle!    # カードをシャッフル
  end

  # デッキを構築するメソッド
  def build_deck
    numbers = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
    marks = ['ハート', 'ダイヤ', 'クラブ', 'スペード']
    marks.each do |mark|
      numbers.each { |number| @cards << Card.new(number, mark) }
    end
  end

  # カードをシャッフルするメソッド
  def shuffle!
    @cards.shuffle!
  end

  # 1枚のカードをデッキから取り出すメソッド
  def deal_one
    @cards.pop
  end
end

# Player クラス: ゲームのプレイヤーを表す
class Player
  attr_accessor :name, :hand, :acquired_cards  # プレイヤー名、手札、獲得したカード

  def initialize(name)
    @name = name
    @hand = []
    @acquired_cards = []
  end

  # カードを手札に追加するメソッド
  def receive_card(card)
    @hand << card
  end

  # 手札からカードを1枚プレイ（出す）するメソッド
  def play_card
    @hand.pop
  end

  # 獲得したカードを追加するメソッド
  def acquire_cards(cards)
    @acquired_cards.concat(cards)
  end

  # 手札と獲得したカードの合計枚数を返すメソッド
  def total_cards
    @hand.size + @acquired_cards.size
  end

  # 手札が空の場合に、獲得したカードをシャッフルして手札に追加するメソッド
  def refill_hand_if_needed
    if @hand.empty? && !@acquired_cards.empty?
      @hand = @acquired_cards.shuffle
      @acquired_cards.clear
      puts "#{@name}は手札を再補充しました。"
    end
  end
end

# Game クラス: ゲーム全体を管理する
class Game
  def initialize
    @deck = Deck.new  # 新しいデッキを作成
    @players = [Player.new("プレイヤー1"), Player.new("プレイヤー2")]  # 2人のプレイヤーを作成
    deal_cards  # カードをプレイヤーに配る
  end

  # プレイヤーにカードを配るメソッド
  def deal_cards
    @players.each { |player| player.hand = @deck.cards.shift(26) }
  end


  def play_war(player1, player2)
    battle_cards = []

    loop do
      # プレイヤーが手札を補充する処理を追加
      player1.refill_hand_if_needed
      player2.refill_hand_if_needed

      card1 = player1.play_card
      card2 = player2.play_card

      # プレイヤーがカードを出せなかった（手札も獲得したカードもない）場合の処理
      if card1.nil? || card2.nil?
        determine_winner_based_on_cards(player1, player2)
        break
      end

      puts "#{player1.name}のカードは#{card1}です。"
      puts "#{player2.name}のカードは#{card2}です。"

      battle_cards.push(card1, card2)

      if card1.strength > card2.strength
        puts "#{player1.name}が勝ちました。"
        player1.acquire_cards(battle_cards)
        break
      elsif card1.strength < card2.strength
        puts "#{player2.name}が勝ちました。"
        player2.acquire_cards(battle_cards)
        break
      else
        puts "引き分けです。追加のカードを出します。"
      end
    end
  end

  def start
    puts "戦争を開始します。"

    until game_over?
      puts "戦争！"
      play_war(@players[0], @players[1])
      puts "-----------"
    end

    finalize_game
  end

  def game_over?
  # どちらかのプレイヤーの手札と獲得したカードの合計が0枚になった場合にゲーム終了
  @players.any? { |player| player.total_cards == 0 }
  end

  def finalize_game
  puts "戦争を終了します。"

  # 手札の枚数が0枚のプレイヤーを探し、そのプレイヤーがいればそのプレイヤーが負ける
  loser = @players.find { |player| player.total_cards == 0 }
  winner = @players.find { |player| player != loser }

  # 勝者と敗者の情報を出力
    if loser
      puts "プレイヤー#{winner.name}の手札の枚数は#{winner.total_cards}枚です。プレイヤー#{loser.name}の手札の枚数は0枚です。"
      puts "プレイヤー#{winner.name}が1位、プレイヤー#{loser.name}が2位です。"
    else
      # もし全員のカードが尽きていた場合（通常は発生しないが、念の為）
      puts "両プレイヤーの手札が尽きました。引き分けです。"
    end
  end
end

game = Game.new
game.start