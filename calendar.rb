# frozen_string_literal: true

require 'date'

require 'optparse'

option = ARGV.getopts('m:')

if option['m'].nil?
  option[:month] = Date.today.month
elsif  option['m'].to_i <= 12
  option[:month] = option['m'].to_i
else
  print "cal: #{option['m']} is neither a month number (1..12) nor a name"
  exit # 強制終了させるためにexitを追加
end

# 選択した日付取得
month = option[:month]
year = Date.today.year
first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)
head = Date.new(year, month, 1)

# 日付表示
puts head.strftime('%-m月 %Y').center(20)

# 曜日を出力
week = %w[月 火 水 木 金 土 日]
puts week.join(' ')

# １日までの空白作成
space = '   ' * (first_day.cwday - 1)
print space

# 日曜日が来たら改行し、日付を出力
number = first_day..last_day
number.each do |date|
  print "#{date.day.to_s.rjust(2)} "
  puts "\n" if date.cwday == 7
end
