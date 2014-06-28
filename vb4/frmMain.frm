VERSION 4.00
Begin VB.Form frmMain 
   Caption         =   "Aswath"
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
   Begin VB.TextBox txtN 
      Height          =   285
      Left            =   1080
      TabIndex        =   17
      Text            =   "5"
      Top             =   3360
      Width           =   1095
   End
   Begin VB.TextBox txtDCOV 
      Height          =   285
      Left            =   1080
      TabIndex        =   15
      Text            =   "2.1"
      Top             =   2760
      Width           =   1215
   End
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
      Left            =   960
      TabIndex        =   11
      Text            =   "8.98"
      Top             =   2040
      Width           =   1095
   End
   Begin VB.TextBox txtERP 
      Height          =   285
      Left            =   960
      TabIndex        =   9
      Text            =   "0.0496"
      Top             =   1680
      Width           =   1095
   End
   Begin VB.TextBox txtRf 
      Height          =   375
      Left            =   960
      TabIndex        =   7
      Text            =   "0.0295"
      Top             =   1200
      Width           =   1575
   End
   Begin VB.TextBox txtBETA 
      Height          =   285
      Left            =   840
      TabIndex        =   5
      Text            =   "0.2114"
      Top             =   840
      Width           =   1095
   End
   Begin VB.TextBox txtDC 
      Height          =   285
      Left            =   840
      TabIndex        =   3
      Text            =   "2.1"
      Top             =   480
      Width           =   975
   End
   Begin VB.TextBox txtROE 
      Height          =   375
      Left            =   840
      TabIndex        =   1
      Text            =   "0.1968"
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label lblP0 
      Caption         =   "P0"
      Height          =   375
      Left            =   600
      TabIndex        =   19
      Top             =   6720
      Width           =   3255
   End
   Begin VB.Label lblPT0 
      Caption         =   "PT0"
      Height          =   375
      Left            =   720
      TabIndex        =   18
      Top             =   6120
      Width           =   3255
   End
   Begin VB.Label Label8 
      Caption         =   "n"
      Height          =   255
      Left            =   240
      TabIndex        =   16
      Top             =   3360
      Width           =   615
   End
   Begin VB.Label Label7 
      Caption         =   "DCOV"
      Height          =   495
      Left            =   120
      TabIndex        =   14
      Top             =   2640
      Width           =   735
   End
   Begin VB.Label lblP1 
      Caption         =   "P1"
      Height          =   375
      Left            =   720
      TabIndex        =   13
      Top             =   5400
      Width           =   3015
   End
   Begin VB.Label Label6 
      Caption         =   "EPS"
      Height          =   375
      Left            =   0
      TabIndex        =   10
      Top             =   2040
      Width           =   855
   End
   Begin VB.Label Label5 
      Caption         =   "ERP"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   1800
      Width           =   735
   End
   Begin VB.Label Label4 
      Caption         =   "Rf"
      Height          =   375
      Left            =   0
      TabIndex        =   6
      Top             =   1200
      Width           =   735
   End
   Begin VB.Label Label3 
      Caption         =   "BETA"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   960
      Width           =   615
   End
   Begin VB.Label Label2 
      Caption         =   "DC"
      Height          =   375
      Left            =   0
      TabIndex        =   2
      Top             =   480
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "ROE"
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   120
      Width           =   735
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCalculate_Click()

    'Inputs
    Dim roe, dc, beta, rf, erp, eps, dcov, n As Double
    roe = CDbl(txtROE.Text)
    dc = CDbl(txtDC.Text)
    beta = CDbl(txtBETA.Text)
    rf = CDbl(txtRf.Text)
    erp = CDbl(txtERP.Text)
    eps = CDbl(txtEPS.Text)
    dcov = CDbl(txtDCOV.Text) ' aka omega
    n = CDbl(txtN.Text)
    
    'Calculations
    Dim a0, theta1, g1, h1, r, ct, gt As Double
    a0 = eps '/ dcov
    theta1 = 1 - 1 / dcov
    g1 = roe * theta1
    h1 = rf + beta * roe
    r = (1 + g1) / (1 + h1)
    ct = rf + erp
    gt = rf
    
    ' Outputs
    Dim p1, pt0, p0 As Double
    p1 = a0 * (1 - theta1) * r * (1 - r ^ n) / (1 - r)
    lblP1.Caption = "P1 " & CStr(p1)
    pt0 = a0 * r ^ n * (1 + gt) / ct
    lblPT0.Caption = "PT0 " & CStr(pt0)
    p0 = p1 + pt0
    lblP0.Caption = "P0 " & CStr(p0)
    
End Sub


