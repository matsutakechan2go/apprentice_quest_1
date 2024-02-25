# カードを表すクラス
class Card
  attr_reader :rank, :suit

  # カードのランクとスートを初期化
  def initialize(rank, suit)
    @rank = rank
    @suit = suit

  end

  # カードの価値を返すメソッド
  def value

  end

  # カードを文字列に変換するメソッド
  def to_s
    "#{@suit}の#{@rank}"
  end
end

# トランプのデッキを表すクラス
class Deck


  # カードのランクとスートを初期化
  def initialize

  end

    # カードをシャッフル
    .shuffle!
  end

  # カードを配るメソッド
  def

  end
end

# 戦争ゲームを表すクラス
class WarGame
  def initialize

  end

  # ラウンドをプレイするメソッド
  def play_round
    puts '戦争！'

    # カードを引く


    # 引いたカードを表示
    puts "#{}のカードは#{}です。"
    puts "#{}のカードは#{}です。"

    # 勝者を決定
    puts "#{}が勝ちました。"

  end

  # ゲームをプレイするメソッド
  def play_game
    puts '戦争を開始します。'
    puts 'カードが配られました。'


    puts '戦争を終了します。'
  end
end

# ゲームのインスタンスを生成して実行
