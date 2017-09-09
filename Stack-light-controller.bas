'--------------------------------------------------------------
'                   Thomas Jensen | uCtrl.io
'--------------------------------------------------------------
'  file: AVR_STACK_LIGHT_CONTROLLER_v1.5
'  date: 27/09/2008
'--------------------------------------------------------------

$regfile = "attiny2313.dat"
$crystal = 8000000
Config Portd = Input
Config Portb = Output
Config Watchdog = 1024

Dim Lifesignal As Byte
Dim Inn0 As Byte , Inn1 As Byte , Inn2 As Byte , Inn3 As Byte
Dim Inn4 As Byte , Inn5 As Byte , Inn6 As Byte , Mute As Byte
Dim Buffer1 As Byte , Buffer2 As Byte , Buffer3 As Byte
Dim Buffer4 As Byte , Buffer5 As Byte , Buffer0 As Byte

Portb = 0
Buffer5 = 50

Waitms 100
Start Watchdog

Main:
'yellow/green
If Inn0 = 12 Then
   If Mute = 0 Then Portb.0 = 1                             'green on
   Portb.3 = 1                                              'green led on
   End If
If Inn0 = 8 Then
   Portb.0 = 0                                              'green off
   Portb.3 = 0                                              'green led off
   If Mute = 0 Then Portb.1 = 1                             'yellow on
   Portb.4 = 1                                              'yellow led on
   End If
If Inn0 = 4 Then
   Portb.1 = 0                                              'yellow off
   Portb.4 = 0                                              'yellow led off
   End If

'red/green
If Inn1 = 12 Then
   If Mute = 0 Then Portb.0 = 1                             'green on
   Portb.3 = 1                                              'green led on
   End If
If Inn1 = 8 Then
   Portb.0 = 0                                              'green off
   Portb.3 = 0                                              'green led off
   If Mute = 0 Then Portb.2 = 1                             'red on
   Portb.5 = 1                                              'red led on
   End If
If Inn1 = 4 Then
   Portb.2 = 0                                              'red off
   Portb.5 = 0                                              'red led off
   End If

'yellow
If Inn2 = 8 Then
   If Mute = 0 Then Portb.1 = 1                             'yellow on
   Portb.4 = 1                                              'yellow led on
   End If
If Inn2 = 4 Then
   Portb.1 = 0                                              'yellow off                                         '
   Portb.4 = 0                                              'yellow led off
   End If

'red
If Inn3 = 8 Then
   If Mute = 0 Then Portb.2 = 1                             'red on
   Portb.5 = 1                                              'red led on
   End If
If Inn3 = 4 Then
   Portb.2 = 0                                              'red off
   Portb.5 = 0                                              'red led off
   End If

'red/yellow
If Inn4 = 12 Then
   If Mute = 0 Then Portb.1 = 1                             'yellow on
   Portb.4 = 1                                              'yellow led on
   End If
If Inn4 = 8 Then
   Portb.1 = 0                                              'yellow off
   Portb.4 = 0                                              'yellow led off
   If Mute = 0 Then Portb.2 = 1                             'red on
   Portb.5 = 1                                              'red led on
   End If
If Inn4 = 4 Then
   Portb.2 = 0                                              'red off
   Portb.5 = 0                                              'red led off
   End If

'all
If Inn5 = 16 Then
   Portb.2 = 1                                              'red on
   Portb.5 = 1                                              'red led on
   End If
If Inn5 = 12 Then
   Portb.2 = 0                                              ''red off
   Portb.5 = 0                                              'red led off
   Portb.1 = 1                                              'yellow on
   Portb.4 = 1                                              'yellow led on
   End If
If Inn5 = 8 Then
   Portb.1 = 0                                              'yellow off
   Portb.4 = 0                                              'yellow led off
   Portb.0 = 1                                              'green on
   Portb.3 = 1                                              'green led on
   End If
If Inn5 = 4 Then
   Portb.0 = 0                                              'green off
   Portb.3 = 0                                              'green led off
   End If

'mute signal
If Inn6 > 2 Then
   Portb.0 = 1                                              'green on
   Portb.3 = 1                                              'green led on
   End If
If Inn6 = 1 Then
   Portb.0 = 0                                              'green off
   Portb.3 = 0                                              'green led off
   End If

'count down buffers and timers
If Buffer0 > 0 Then Buffer0 = Buffer0 - 1
If Buffer1 > 0 Then Buffer1 = Buffer1 - 1
If Buffer2 > 0 Then Buffer2 = Buffer2 - 1
If Buffer3 > 0 Then Buffer3 = Buffer3 - 1
If Buffer4 > 0 Then Buffer4 = Buffer4 - 1
If Buffer5 > 0 Then Buffer5 = Buffer5 - 1
If Inn0 > 0 Then Inn0 = Inn0 - 1
If Inn1 > 0 Then Inn1 = Inn1 - 1
If Inn2 > 0 Then Inn2 = Inn2 - 1
If Inn3 > 0 Then Inn3 = Inn3 - 1
If Inn4 > 0 Then Inn4 = Inn4 - 1
If Inn5 > 0 Then Inn5 = Inn5 - 1
If Inn6 > 0 Then Inn6 = Inn6 - 1

'set buffers
If Pind.0 = 0 Then Buffer0 = 30
If Pind.1 = 0 Then Buffer1 = 30
If Pind.2 = 0 Then Buffer2 = 30
If Pind.3 = 0 Then Buffer3 = 30
If Pind.4 = 0 Then Buffer4 = 30
If Pind.5 = 0 Then Buffer5 = 30

'set timers
If Buffer0 > 0 And Inn6 = 0 And Inn0 = 0 And Buffer5 = 0 And Buffer4 = 0 And Buffer3 = 0 And Buffer2 = 0 And Buffer1 = 0 Then Inn0 = 12
If Buffer1 > 0 And Inn6 = 0 And Inn1 = 0 And Buffer5 = 0 And Buffer4 = 0 And Buffer3 = 0 And Buffer2 = 0 Then Inn1 = 12
If Buffer2 > 0 And Inn2 = 0 And Buffer5 = 0 And Buffer4 = 0 And Buffer3 = 0 Then Inn2 = 8
If Buffer3 > 0 And Inn3 = 0 And Buffer5 = 0 And Buffer4 = 0 Then Inn3 = 8
If Buffer4 > 0 And Inn4 = 0 And Buffer5 = 0 Then Inn4 = 12
If Buffer5 > 0 And Inn5 = 0 Then Inn5 = 16

'mute signal
If Pind.6 = 0 And Mute = 0 Then
   If Buffer0 = 0 And Buffer1 = 0 And Buffer2 = 0 And Buffer3 = 0 And Buffer4 = 0 And Buffer5 = 0 Then Inn6 = 11
   Mute = 1
   End If
If Pind.6 = 1 And Mute = 1 Then
   If Buffer0 = 0 And Buffer1 = 0 And Buffer2 = 0 And Buffer3 = 0 And Buffer4 = 0 And Buffer5 = 0 Then Inn6 = 5
   Mute = 0
   End If

'lifesignal
If Lifesignal > 0 Then Lifesignal = Lifesignal - 1
If Lifesignal = 6 Then
   Portb.6 = 1
   Portb.7 = 1
   End If
If Lifesignal = 1 Then
   Portb.6 = 0
   Portb.7 = 0
   End If
If Lifesignal = 0 Then Lifesignal = 21

'loop cycle
Reset Watchdog
Waitms 100
Goto Main
End