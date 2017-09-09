'--------------------------------------------------------------
'                   Thomas Jensen | uCtrl.io
'--------------------------------------------------------------
'  file: AVR_STACK_LIGHT_CONTROLLER_v2.0
'  date: 21/04/2009
'--------------------------------------------------------------

$regfile = "attiny2313.dat"
$crystal = 8000000
Config Portd = Input
Config Portb = Output
Config Watchdog = 1024

Dim Lifesignal As Byte
Dim Inn0 As Byte , Inn1 As Byte , Inn2 As Byte , Inn3 As Byte
Dim Inn4 As Byte , Inn5 As Byte , Inn6 As Byte , A As Byte
Dim Buffer1 As Byte , Buffer2 As Byte , Buffer3 As Byte
Dim Buffer4 As Byte , Buffer5 As Byte , Buffer0 As Byte
Dim S_timer As Byte , R_strobe As Byte , Y_strobe As Byte
Dim E_buff1 As Bit , E_buff2 As Bit , E_buff3 As Bit

'boot
Portb = 0
Portb.1 = 1
For A = 1 To 20
    Portb.0 = Not Portb.0
    Waitms 500
Next A
Portb.1 = 0
Portb.0 = 1

Waitms 2500
Start Watchdog
Portb = 0

Main:
'0 green flashing
If Inn0 = 8 Then Portb.0 = 1                                'green on
If Inn0 = 4 Then Portb.0 = 0                                'green off

'1 green stable, yellow flashing
If Inn1 = 8 Then
   Portb.1 = 1                                              'yellow on
   Y_strobe = 10
   End If
If Inn1 = 4 Then Portb.1 = 0                                'yellow off

'2 yellow flashing
If Inn2 = 8 Then
   Portb.1 = 1                                              'yellow on
   Y_strobe = 10
   End If
If Inn2 = 4 Then Portb.1 = 0                                'yellow off

'3 red stable, yellow flashing
If Inn3 = 8 Then
   Portb.1 = 1                                              'yellow on
   Y_strobe = 10
   End If
If Inn3 = 4 Then Portb.1 = 0                                'yellow off

'4 yellow stable, red flashing
If Inn4 = 8 Then
   Portb.2 = 1                                              'red on
   R_strobe = 10
   End If
If Inn4 = 4 Then Portb.2 = 0                                'red off

'5 red flashing
If Inn5 = 8 Then
   Portb.2 = 1                                              'red on
   R_strobe = 10
   End If
If Inn5 = 4 Then Portb.2 = 0                                'red off

'stable light off
If Inn1 = 0 And E_buff1 = 1 Then
   Portb.0 = 0
   E_buff1 = 0
   End If
If Inn3 = 0 And E_buff2 = 1 Then
   Portb.2 = 0
   E_buff2 = 0
   End If
If Inn4 = 0 And E_buff3 = 1 Then
   Portb.1 = 0
   E_buff3 = 0
   End If

'count down buffers and timers
If Buffer0 > 0 Then Buffer0 = Buffer0 - 1
If Buffer1 > 0 Then Buffer1 = Buffer1 - 1
If Buffer2 > 0 Then Buffer2 = Buffer2 - 1
If Buffer3 > 0 Then Buffer3 = Buffer3 - 1
If Buffer4 > 0 Then Buffer4 = Buffer4 - 1
If Buffer5 > 0 Then Buffer5 = Buffer5 - 1
If Inn0 > 0 Then Inn0 = Inn0 - 1
If Inn1 > 0 Then
   Inn1 = Inn1 - 1
   E_buff1 = 1
   Portb.0 = 1
   End If
If Inn2 > 0 Then Inn2 = Inn2 - 1
If Inn3 > 0 Then
   Inn3 = Inn3 - 1
   E_buff2 = 1
   Portb.2 = 1
   End If
If Inn4 > 0 Then
   Inn4 = Inn4 - 1
   E_buff3 = 1
   Portb.1 = 1
   End If
If Inn5 > 0 Then Inn5 = Inn5 - 1
If Inn6 > 0 Then Inn6 = Inn6 - 1

'set buffers
If Pind.0 = 0 Then
   If Buffer0 = 0 And Pind.6 = 1 Then S_timer = 1
   Buffer0 = 30
   End If
If Pind.1 = 0 Then
   If Buffer1 = 0 And Pind.6 = 1 Then S_timer = 10
   Buffer1 = 30
   End If
If Pind.2 = 0 Then
   If Buffer2 = 0 And Pind.6 = 1 Then S_timer = 10
   Buffer2 = 30
   End If
If Pind.3 = 0 Then
   If Buffer3 = 0 Then S_timer = 10
   Buffer3 = 30
   End If
If Pind.4 = 0 Then
   If Buffer4 = 0 Then S_timer = 10
   Buffer4 = 30
   End If
If Pind.5 = 0 Then
   If Buffer5 = 0 Then S_timer = 10
   Buffer5 = 30
   End If

'set timers
If Buffer0 > 0 And Inn6 = 0 And Inn0 = 0 And Buffer5 = 0 And Buffer4 = 0 And Buffer3 = 0 And Buffer2 = 0 And Buffer1 = 0 Then Inn0 = 8
If Buffer1 > 0 And Inn6 = 0 And Inn1 = 0 And Buffer5 = 0 And Buffer4 = 0 And Buffer3 = 0 And Buffer2 = 0 Then Inn1 = 8
If Buffer2 > 0 And Inn2 = 0 And Buffer5 = 0 And Buffer4 = 0 And Buffer3 = 0 Then Inn2 = 8
If Buffer3 > 0 And Inn3 = 0 And Buffer5 = 0 And Buffer4 = 0 Then Inn3 = 8
If Buffer4 > 0 And Inn4 = 0 And Buffer5 = 0 Then Inn4 = 8
If Buffer5 > 0 And Inn5 = 0 Then Inn5 = 8

'siren
If S_timer = 0 Then Portb.5 = 0
If S_timer = 10 And Pind.6 = 0 Then S_timer = 1
If S_timer > 0 Then
   S_timer = S_timer - 1
   Portb.5 = 1
   End If

'yellow strobe
If Y_strobe = 0 Then Portb.3 = 0
If Y_strobe > 0 Then
   Y_strobe = Y_strobe - 1
   Portb.3 = 1
   End If

'red strobe
If R_strobe = 0 Then Portb.4 = 0
If R_strobe > 0 Then
   R_strobe = R_strobe - 1
   Portb.4 = 1
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