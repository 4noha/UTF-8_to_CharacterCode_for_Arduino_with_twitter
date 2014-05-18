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
a="hello aaaa"
sp.write a
#sp.write(packet.flatten.pack('C*'))
#sp.write "data#{$serial_delimiter}"

#シリアルポートを閉じる
sp.close
