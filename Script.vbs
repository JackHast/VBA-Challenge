Sub func()

'Defining variables
Dim Ticker As String
Dim stock As Long
Dim Yearly_Change As Double
Dim Percent_Change As Double
Dim Opening_Price As Double
Dim Price_Change As Double

'Looping through worksheets

For Each ws In Worksheets

ws.Columns("I").ColumnWidth = 10
ws.Columns("J").ColumnWidth = 13
ws.Columns("K").ColumnWidth = 13
ws.Columns("L").ColumnWidth = 20
ws.Columns("O").ColumnWidth = 20
ws.Columns("Q").ColumnWidth = 15


ws.Range("I1").Value = "Ticker"
ws.Range("J1").Value = "Yearly Change"
ws.Range("K1").Value = "Percent Change"
ws.Range("L1").Value = "Total Stock Volume"
ws.Range("O2").Value = "Greatest % Increase"
ws.Range("O3").Value = "Greatest % Decrease"
ws.Range("O4").Value = "Greatest Total Volume"
ws.Range("P1").Value = "Ticker"
ws.Range("Q1").Value = "Value"
LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row

'Initialising variables
Opening_Price = ws.Range("C2").Value
stock = 2
Greatest_Increase = 0
Greatest_Decrease = 0
Vol_Stock = 2
'Looping through rows
For i = 2 To LastRow

'Adding up volume for each stock
ws.Cells(stock, 12).Value = ws.Cells(stock, 12).Value + ws.Cells(i, 7).Value

'If Ticker changes
If ws.Cells(i, 1).Value <> ws.Cells(i + 1, 1).Value Then

'Determine Closing price for stock and calculating price change etc.
Closing_Price = ws.Cells(i, 6).Value
Ticker = ws.Cells(i, 1).Value
Price_Change = Closing_Price - Opening_Price
Percent_Change = Price_Change / Opening_Price
Opening_Price = ws.Cells(i + 1, 3)
ws.Cells(stock, 9).Value = Ticker
ws.Cells(stock, 10).Value = Price_Change
ws.Cells(stock, 11).Value = FormatPercent(Percent_Change)
If Price_Change <= 0 Then
ws.Cells(stock, 10).Interior.ColorIndex = 3
Else
ws.Cells(stock, 10).Interior.ColorIndex = 4
End If

'Determining greatest price increase/decrease and greatest volume
If Percent_Change > Greatest_Increase Then
Greatest_Increase = Percent_Change
Best_Ticker = Ticker
Best_Percent = FormatPercent(Percent_Change)
End If

If Percent_Change < Greatest_Decrease Then
Greatest_Decrease = Percent_Change
Worst_Ticker = Ticker
Worst_Percent = FormatPercent(Percent_Change)
End If
    

If ws.Cells(stock, 12).Value > ws.Cells(Vol_Stock, 12).Value Then
Vol_Ticker = Ticker
Vol_Stock = stock
End If

stock = stock + 1
End If

Next i

ws.Range("P2").Value = Best_Ticker
ws.Range("Q2").Value = Best_Percent
ws.Range("P3").Value = Worst_Ticker
ws.Range("Q3").Value = Worst_Percent
ws.Range("P4").Value = Vol_Ticker
ws.Range("Q4").Value = ws.Cells(Vol_Stock, 12).Value

Next ws

End Sub

