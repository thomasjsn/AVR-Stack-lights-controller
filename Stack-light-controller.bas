'--------------------------------------------------------------
'                   Thomas Jensen | uCtrl.io
'--------------------------------------------------------------
'  file: AVR_STACK_LIGHT_CONTROLLER_v1.0
'  date: 12/04/2006
'--------------------------------------------------------------

$regfile = "attiny2313.dat"
$crystal = 4000000
Config Portd = Input
Config Portb = Output
Config Watchdog = 1024

Dim Lifesignal As Integer
Dim A As Byte
Dim Critical As Integer
Dim Inn0 As Integer
Dim Inn1 As Integer
Dim Inn2 As Integer
Dim Inn3 As Integer
Dim Inn4 As Integer
Dim Inn5 As Integer

Lifesignal = 21
Inn0 = 0
Inn1 = 0
Inn2 = 0
Inn3 = 0
Inn4 = 0
Inn5 = 0
Critical = 0

'boot
Portb = 0

For A = 1 To 6
    Portb.0 = Not Portb.0
    Portb.1 = Not Portb.1
    Portb.2 = Not Portb.2
    Portb.3 = Not Portb.3
    Portb.4 = Not Portb.4
    Portb.5 = Not Portb.5
    Waitms 750
Next A

Waitms 1000
Start Watchdog
Portb = 0

Main:
'green blink
If Inn0 = 20 Then
   If Pind.6 = 1 Then Portb.0 = 1                           'stack light green on
   Portb.3 = 1                                              'led green on
   End If
If Inn0 = 10 Then
   Portb.0 = 0                                              'stack light green off
   Portb.3 = 0                                              'led green off
   End If

'yellow blink
If Inn1 = 10 Then
   If Pind.6 = 1 Then Portb.1 = 1                           'stack light yellow on
   Portb.4 = 1                                              'led yellow on
   End If
If Inn1 = 5 Then
   Portb.1 = 0                                              'stack light yellow off                                         '
   Portb.4 = 0                                              'led yellow off
   End If

'red blink
If Inn2 = 10 Then
   If Pind.6 = 1 Then Portb.2 = 1                           'stack light red on
   Portb.5 = 1                                              'led red on
   End If
If Inn2 = 5 Then
   Portb.2 = 0                                              'stack light red off
   Portb.5 = 0                                              'led red off
   End If

'yellow/green blink
If Inn4 = 15 Then
   If Pind.6 = 1 Then Portb.1 = 1                           'stack light yellow on
   Portb.4 = 1                                              'led yellow on
   End If
If Inn4 = 10 Then
   Portb.1 = 0                                              'stack light yellow off
   Portb.4 = 0                                              'led yellow off
   If Pind.6 = 1 Then Portb.0 = 1                           'stack light green on
   Portb.3 = 1                                              'led green on
   End If
If Inn4 = 5 Then
   Portb.0 = 0                                              'stack light green off
   Portb.3 = 0                                              'led green off
   End If

'red/yellow blink
If Inn3 = 15 Then
   Portb.1 = 1                                              'stack light yellow on
   Portb.4 = 1                                              'led yellow on
   End If
If Inn3 = 10 Then
   Portb.1 = 0                                              'stack light yellow off
   Portb.4 = 0                                              'led yellow off
   Portb.2 = 1                                              'stack light red on
   Portb.5 = 1                                              'led red on
   End If
If Inn3 = 5 Then
   Portb.2 = 0                                              'stack light red off
   Portb.5 = 0                                              'led red off
   End If

'all blink
If Inn5 = 20 Then
   Portb.2 = 1                                              'stack light red on
   Portb.5 = 1                                              'led red on
   End If
If Inn5 = 15 Then
   Portb.2 = 0                                              'stack light red off
   Portb.5 = 0                                              'led red off
   Portb.1 = 1                                              'stack light yellow on
   Portb.4 = 1                                              'led yellow on
   End If
If Inn5 = 10 Then
   Portb.1 = 0                                              'stack light yellow off
   Portb.4 = 0                                              'led yellow off
   Portb.0 = 1                                              'stack light green on
   Portb.3 = 1                                              'led green on
   End If
If Inn5 = 5 Then
   Portb.0 = 0                                              'stack light green off
   Portb.3 = 0                                              'led green off
   End If

If Pind.3 = 0 Or Pind.5 = 0 Then
   Critical = 1
   Else
   Critical = 0
   End If

'setting variables
If Inn0 > 0 Then Inn0 = Inn0 - 1
If Inn1 > 0 Then Inn1 = Inn1 - 1
If Inn2 > 0 Then Inn2 = Inn2 - 1
If Inn3 > 0 Then Inn3 = Inn3 - 1
If Inn4 > 0 Then Inn4 = Inn4 - 1
If Inn5 > 0 Then Inn5 = Inn5 - 1
If Pind.0 = 0 And Inn0 = 0 And Critical = 0 And Pind.4 = 1 Then Inn0 = 20
If Pind.1 = 0 And Inn1 = 0 And Critical = 0 And Pind.4 = 1 Then Inn1 = 10
If Pind.2 = 0 And Inn2 = 0 And Critical = 0 Then Inn2 = 10
If Pind.3 = 0 And Inn3 = 0 And Pind.5 = 1 Then Inn3 = 15
If Pind.4 = 0 And Inn4 = 0 And Critical = 0 Then Inn4 = 15
If Pind.5 = 0 And Inn5 = 0 Then Inn5 = 20

'lifesignal
If Lifesignal > 0 Then Lifesignal = Lifesignal - 1
If Lifesignal = 6 Then Portb.6 = 1
If Lifesignal = 1 Then Portb.6 = 0
If Lifesignal = 0 Then Lifesignal = 21

'loop cycle
Reset Watchdog
Portb.7 = 1
Waitms 25
Portb.7 = 0
Waitms 75
Goto Main
End