require 'serialport'

 #シリアルポート通信設定
$serial_port = '/dev/cu.usbmodem1421' 
$serial_baudrate = 9600
$serial_databit = 8
$serial_stopbit = 1
$serial_paritycheck = 0
$serial_delimiter = ''

#シリアルポートを開く
sp = SerialPort.new($serial_port, $serial_baudrate, $serial_databit, $serial_stopbit, $serial_paritycheck) 
sp.read_timeout=1000 #受信時のタイムアウト（ミリ秒単位）

#送信（例えばこんな感じ）
str2 = "TwitterれんけいよりMeCabのせいびをがんばればよかった"
#str2 = "っつづ"
#str2 = "がたちつてとなにぬねのはひふへほまみむめも"
str  = "".b
str2.split("").each do |c|
  daku = false
  if(c >= "が" && c <= "ぢ" && c.ord%2 == 0)
    c_ord = c.ord-1
    daku = true
  elsif(c == "っ")
    c_ord = c.ord-37
  elsif(c == "づ")
    c_ord = c.ord-1
    daku = true
  elsif(c == "で" || c == "ど")
    c_ord = c.ord-1
    daku = true
  elsif(c >= "ば" && c <= "ぼ" && c.ord%3 == 1)
    c_ord = c.ord-1
    daku = true
  elsif(c >= "ぱ" && c <= "ぽ" && c.ord%3 == 2)
    c_ord = c.ord-2
    h_daku = true
  else
    c_ord = c.ord
  end

  if(c >= "あ" && c <= "お")
    str += (c_ord/2-6000).chr.b
  elsif(c >= "か" && c <= "ぢ")
    str += (c_ord/2-5999).chr.b
  elsif(c >= "っ" && c <= "づ")
    str += (c_ord/2-6000).chr.b
  elsif(c >= "ち" && c <= "ど")
    str += (c_ord/2-6000).chr.b
  elsif(c >= "な" && c <= "の")
    str += (c_ord-12197).chr.b
  elsif(c >= "は" && c <= "ぽ")
    str += (c_ord/3-3931).chr.b
  elsif(c >= "ま" && c <= "も")
    str += (c_ord-12207).chr.b
  elsif(c >= "や" && c <= "よ")
    str += (c_ord/2-5998).chr.b
  elsif(c >= "ら" && c <= "ろ")
    str += (c_ord-12210).chr.b
  elsif(c == "わ")
    str += (c_ord/2-5995).chr.b
  elsif(c == "ゐ" || c == "ヰ")
    str += (0xb2).chr.b
  elsif(c == "ゑ" || c == "ヱ")
    str += (0xb4).chr.b
  elsif(c == "を")
    str += (c_ord/2-6051).chr.b
  elsif(c == "ん")
    str += (c_ord/2-5996).chr.b
  elsif(c == "ー")
    str += (c_ord/2-6094).chr.b
  elsif(c >= "A" && c <= "z")
    str += c.b
  end
  str += 0xde.chr.b if daku
  str += 0xdf.chr.b if h_daku
end
sp.write str

#シリアルポートを閉じる
sp.close
