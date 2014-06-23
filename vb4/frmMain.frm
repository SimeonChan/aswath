VERSION 4.00
Begin VB.Form frmMain 
   Caption         =   "Form1"
   ClientHeight    =   7965
   ClientLeft      =   2010
   ClientTop       =   4350
   ClientWidth     =   5685
   Height          =   8535
   Left            =   1890
   LinkTopic       =   "Form1"
   ScaleHeight     =   7965
   ScaleWidth      =   5685
   Top             =   3900
   Width           =   5925
   Begin VB.CommandButton cmdCalculate 
      Caption         =   "Calculate"
      Height          =   255
      Left            =   1320
      TabIndex        =   12
      Top             =   4680
      Width           =   2535
   End
   Begin VB.TextBox txtEPS 
      Height          =   375
      Left            =   2040
      TabIndex        =   11
      Text            =   "8.98"
      Top             =   3960
      Width           =   1095
   End
   Begin VB.TextBox txtERP 
      Height          =   285
      Left            =   2040
      TabIndex        =   9
      Text            =   "0.0791"
      Top             =   3240
      Width           =   1095
   End
   Begin VB.TextBox txtRf 
      Height          =   375
      Left            =   1920
      TabIndex        =   7
      Text            =   "0.0295"
      Top             =   2400
      Width           =   1575
   End
   Begin VB.TextBox txtBETA 
      Height          =   285
      Left            =   1800
      TabIndex        =   5
      Text            =   "0.2114"
      Top             =   1800
      Width           =   1095
   End
   Begin VB.TextBox txtDC 
      Height          =   285
      Left            =   1920
      TabIndex        =   3
      Text            =   "2.1"
      Top             =   1080
      Width           =   975
   End
   Begin VB.TextBox txtROE 
      Height          =   375
      Left            =   1560
      TabIndex        =   1
      Text            =   "0.1968"
      Top             =   480
      Width           =   1215
   End
   Begin VB.Label lblP1 
      Caption         =   "P1"
      Height          =   375
      Left            =   720
      TabIndex        =   13
      Top             =   5400
      Width           =   855
   End
   Begin VB.Label Label6 
      Caption         =   "EPS"
      Height          =   375
      Left            =   720
      TabIndex        =   10
      Top             =   3960
      Width           =   855
   End
   Begin VB.Label Label5 
      Caption         =   "ERP"
      Height          =   255
      Left            =   600
      TabIndex        =   8
      Top             =   3240
      Width           =   975
   End
   Begin VB.Label Label4 
      Caption         =   "Rf"
      Height          =   375
      Left            =   600
      TabIndex        =   6
      Top             =   2400
      Width           =   735
   End
   Begin VB.Label Label3 
      Caption         =   "BETA"
      Height          =   255
      Left            =   600
      TabIndex        =   4
      Top             =   1800
      Width           =   615
   End
   Begin VB.Label Label2 
      Caption         =   "DC"
      Height          =   375
      Left            =   600
      TabIndex        =   2
      Top             =   1080
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "ROE"
      Height          =   255
      Left            =   480
      TabIndex        =   0
      Top             =   480
      Width           =   735
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCalculate_Click()

    'Inputs
    Dim roe, dc, beta, rf, erp, eps As Double
    roe = CDbl(txtROE.Text)
    dc = CDbl(txtDC.Text)
    beta = CDbl(txtBETA.Text)
    rf = CDbl(txtRf.Text)
    erp = CDbl(txtERP.Text)
    eps = CDbl(txtEPS.Text)
    
    'Calculations
    Dim p1 As Double
    p1 = 666
    lblP1.Caption = "P1 " & CStr(p1)
End Sub


