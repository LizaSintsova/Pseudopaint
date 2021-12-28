# -*- coding: cp1251 -*-
# importing libraries
import codecs
import random
import pymorphy2
import sys
from PyQt5.QtWidgets import QApplication, QWidget, QPushButton, QMainWindow, QFileDialog, QLCDNumber, QLabel
from PyQt5.QtWidgets import QFileDialog, QLCDNumber, QLabel
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5.QtCore import *
from PyQt5 import QtCore
from PyQt5.QtGui import QPainter, QColor, QPixmap
from PyQt5 import QtCore, QtGui, QtWidgets

        
class Window(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle('Программа для рисования')
        self.setFixedSize(900, 700)
        self.image = QImage(self.size(), QImage.Format_RGB32)   
        self.image.fill(Qt.white)       
        self.initUI()
        self.draw = False
        self.kv = False
        self.сleart = Qt.white
        self.Colore = Qt.blue
        self.Color = Qt.black
        self.endpoint = QPoint()
        self.Size = 2
            
    def initUI(self):
                 
        self.pixmap = QPixmap('designer\decoration.jpg')
        self.imag = QLabel(self)
        self.imag.move(0, 0)
        self.imag.resize(900, 82)
        self.imag.setPixmap(self.pixmap)  
        
        self.label = QLabel(self)
        self.label.setText("Основной цвет кисти:")
        self.label.move(5, 0)        

        self.btn = QPushButton('Синий', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(5, 20, 70, 28)
        self.btn.setStyleSheet('''background-color: 'self.Colore';
                                border-style: outset;
                                border-width: 2px;
                                border-radius: 10px;
                                border-color: beige;
                                font: bold 12px;
                                padding: 6px;}''')        
        self.btn.clicked.connect(self.blue)
        self.update()


        self.btn = QPushButton('Зеленый', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(75, 20, 70, 28)
        self.btn.setStyleSheet('''background-color: #00FF00;
                                border-style: outset;
                                border-width: 2px;
                                border-radius: 10px;
                                border-color: beige;
                                font: bold 12px;
                                padding: 6px;}''')        
        self.btn.clicked.connect(self.green)

        self.btn = QPushButton('Черный', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(145, 20, 70, 28)
        self.btn.setStyleSheet('''background-color: qlineargradient(x1: 0, y1: 0, x2: 0.5, y2: 0.5,
                                stop: 0 #46394B, stop: 1 grey);
                                border-style: outset;
                                border-width: 2px;
                                border-radius: 10px;
                                border-color: beige;
                                font: bold 12px;
                                padding: 6px;}''')       
        self.btn.clicked.connect(self.black)

        self.btn = QPushButton('Красный', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(75, 48, 70, 28)
        self.btn.setStyleSheet('''background-color: red;
                                border-style: outset;
                                border-width: 2px;
                                border-radius: 10px;
                                border-color: beige;
                                font: bold 12px;
                                padding: 6px;}''')
        self.btn.clicked.connect(self.red)
        
        self.label = QLabel(self)
        self.label.setText('Инструменты:')
        self.label.move(225, 0)
        
        self.btn = QPushButton('Кисть', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(225, 20, 70, 28)
        self.btn.setShortcut('F5')
        self.btn.setStyleSheet('''hover{background-color:rgba(100,255,100, 100);
                               color:rgba(0, 0, 0, 200);}''')        
        self.btn.clicked.connect(self.Pix2e)
        
        self.btn = QPushButton('Квадрат', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(295, 20, 70, 28)
        self.btn.setStyleSheet('''hover{background-color:rgba(100,255,100, 100);
                               color:rgba(0, 0, 0, 200);}''')        
        self.btn.clicked.connect(self.kv)
        
        self.btn = QPushButton('Выбор цвета', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(225, 48, 105, 28)
        self.btn.setStyleSheet('''hover{background-color:rgba(100,255,100, 100);
                               color:rgba(0, 0, 0, 200);}''')        
        self.btn.clicked.connect(self.Colors)
        
        self.btn = QPushButton('Сохранить', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(330, 48, 105, 28)
        self.btn.clicked.connect(self.saves)          
        
        self.btn = QPushButton('Ластик', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(365, 20, 70, 28)
        self.btn.setShortcut('E')
        self.btn.setStyleSheet('''hover{background-color:rgba(100,255,100, 100);
                               color:rgba(0, 0, 0, 200);}''')        
        self.btn.clicked.connect(self.clear)
        
        self.label = QLabel(self)
        self.label.setText('Цвет заливки:')
        self.label.move(445, 0)
        
        self.btn = QPushButton('Синий', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(445, 20, 70, 28)
        self.btn.clicked.connect(self.blues)
        self.btn.setStyleSheet('''background-color: blue;
                                border-style: outset;
                                border-width: 2px;
                                border-radius: 10px;
                                border-color: beige;
                                font: bold 12px;
                                padding: 4px;}''')         
        
        self.btn = QPushButton('Зеленый', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(515, 20, 70, 28)
        self.btn.clicked.connect(self.greens)
        self.btn.setStyleSheet('''background-color: #00FF00;
                                border-style: outset;
                                border-width: 2px;
                                border-radius: 10px;
                                border-color: beige;
                                font: bold 12px;
                                padding: 4px;}''')           
        
        self.btn = QPushButton('Белый', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(585, 20, 70, 28)
        self.btn.clicked.connect(self.whites)
        self.btn.setStyleSheet('''background-color: white;
                                border-style: outset;
                                border-width: 2px;
                                border-radius: 10px;
                                border-color: beige;
                                font: bold 12px;
                                padding: 6px;}''')           
        
        self.btn = QPushButton('Красный', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(545, 48, 70, 28)
        self.btn.clicked.connect(self.reds)
        self.btn.setStyleSheet('''background-color: red;
                                border-style: outset;
                                border-width: 2px;
                                border-radius: 10px;
                                border-color: beige;
                                font: bold 12px;
                                padding: 6px;}''')        
        
        self.btn = QPushButton('Черный', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(475, 48, 70, 28)
        self.btn.clicked.connect(self.blacks)
        self.btn.setStyleSheet('''background-color: qlineargradient(x1: 0, y1: 0, x2: 0.5, y2: 0.5,
                                stop: 0 #46394B, stop: 1 grey);
                                border-style: outset;
                                border-width: 2px;
                                border-radius: 10px;
                                border-color: beige;
                                font: bold 12px;
                                padding: 6px;}''')
        self.label = QLabel(self)
        self.label.setText("Размер кисти:")
        self.label.move(665, 0)        
        
        self.btn = QPushButton('2', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(665, 20, 28, 28)
        self.btn.clicked.connect(self.Pix2)
        
        self.btn = QPushButton('4', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(693, 20, 28, 28)
        self.btn.clicked.connect(self.Pix4)
        
        self.btn = QPushButton('6', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(721, 20, 28, 28)
        self.btn.clicked.connect(self.Pix6)
        
        self.btn = QPushButton('8', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(665, 47, 28, 28)
        self.btn.clicked.connect(self.Pix8)
        
        self.btn = QPushButton('10', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(693, 47, 28, 28)
        self.btn.clicked.connect(self.Pix10)
        
        self.btn = QPushButton('12', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(721, 47, 28, 28)
        self.btn.clicked.connect(self.Pix12)        
        
        self.label = QLabel(self)
        self.label.setText('Что нарисовать')
        self.label.move(779, 0)
        
        self.btn = QPushButton('Нажми', self)
        self.btn.resize(self.btn.sizeHint())
        self.btn.setGeometry(786, 20, 60, 28)
        self.btn.clicked.connect(self.random)
        
        self.text = QLabel(self)
        self.text.move(786, 48)
        self.text.setFont(QFont('', 8))
        
        self.text2 = QLabel(self)
        self.text2.move(786, 58)
        self.text2.setFont(QFont('', 8))
    
        self.count = 0
            
    def mousePressEvent(self, event):
        if event.button() == Qt.LeftButton:
            self.draw = True
            self.endpoint = event.pos()

    def mouseMoveEvent(self, event):
        if (event.buttons() and Qt.LeftButton) and self.draw:
            paint = QPainter(self.image)
            paint.setPen(QPen(self.Color, self.Size, Qt.SolidLine, Qt.RoundCap, Qt.RoundJoin))        
        if self.kv:
            square = QtCore.QRect(QtCore.QPoint(), self.Size*QtCore.QSize())    
            square.moveCenter(event.pos())
            paint.setCompositionMode(QtGui.QPainter.CompositionMode_Clear)    
            paint.eraseRect(square)                    
        else:
            paint.drawLine(self.endpoint, event.pos())
        self.endpoint = event.pos()
        self.update()        
            
            
    def paintEvent(self, event):
        canvas = QPainter(self)
        canvas.drawImage(self.rect(), self.image, self.image.rect())
        
    def Colors(self):
        self.color = QColorDialog.getColor()
        if self.color.isValid():
            self.Color = self.color 
        self.Colore = self.color
        self.update()
    
    def kv(self):
        self.kv = True   

    def inc_click(self):
        self.count += 1
        self.LCD_count.display(self.count)    

    def clear(self):
        self.kv = False
        self.Color = self.сleart
        self.update()

    def Pix4(self):
        self.Size = 4

    def Pix6(self):
        self.Size = 6       

    def Pix2(self):
        self.Size = 2
        
    def Pix10(self):
        self.Size = 10
        
    def Pix12(self):
        self.Size = 12
        
    def Pix8(self):
        self.Size = 8     
        
    def Pix2e(self):
        self.kv = False
        self.Color = self.Colore 

    def black(self):
        self.Color = Qt.black
        self.Colore = Qt.black
        self.update()
        
    def green(self):
        self.Color = Qt.green
        self.Colore = Qt.green
        self.update()

    def red(self):
        self.Color = Qt.red
        self.Colore = Qt.red
        self.update()
        
    def blue(self):
        self.Color = Qt.blue
        self.Colore = Qt.blue
        self.update()
    
    def reds(self):
        self.сleart = Qt.red
        self.image.fill(Qt.red)
        self.update()          
        
    def greens(self):
        self.сleart = Qt.green
        self.image.fill(Qt.green)
        self.update()        

    def blues(self):
        self.сleart = Qt.blue
        self.image.fill(Qt.blue)
        self.update()
        
    def whites(self):
        self.сleart = Qt.white
        self.image.fill(Qt.white)
        self.update()
        
    def l_turn(self):
        img = img.rotate(90)
        img.image(self.new_img)
        self.pixmap = QPixmap(self.new_img)
        self.pixmap1 = self.pixmap.scaled(400, 400, QtCore.Qt.KeepAspectRatio)
        self.image.setPixmap(self.pixmap1)    
        
    def blacks(self):
        self.сleart = Qt.black
        self.image.fill(Qt.black)
        self.update()
        
    def saves(self):
        file_path, _ = QFileDialog.getSaveFileName(self, "Save Image", "",
                                                       "File PNG(*.png);;File JPEG(*.jpg *.jpeg);;All Files(*.*) ")
    
        if file_path == "":
            return
        self.image.save(file_path)    
        
    def random(self):
        adjective = []
        noun = []
        with codecs.open('text\words.txt', encoding='utf-8') as fin:
            adjective = fin.read().split()
        with codecs.open('text\word.txt', encoding='utf-8') as fin:
            noun = fin.read().split()
        adjective_1 = (random.choice(adjective))
        noun2 = (random.choice(noun))
        morph = pymorphy2.MorphAnalyzer()
        res = morph.parse(noun2)[0]
        if noun2[-1] != 'и':
            if res.tag.gender == 'masc':
                if noun2[-1] == 'а':
                    adjective_1 = adjective_1.replace(adjective_1[-2:], 'ая')
            if res.tag.gender == 'femn':
                    adjective_1 = adjective_1.replace(adjective_1[-2:], 'ая')
            if res.tag.gender == 'neut':
                if adjective_1[-2:] == 'ий':
                    adjective_1 = adjective_1.replace(adjective_1[-2:], 'ие')
                else:
                    adjective_1 = adjective_1.replace(adjective_1[-2:], 'ое')
        else:
            if adjective_1[-2:] == 'ий':
                adjective_1 = adjective_1.replace(adjective_1[-2:], 'ие')
            else: 
                adjective_1 = adjective_1.replace(adjective_1[-2:], 'ые')
        self.text.setText('<b>' + adjective_1 + '</b><i>')
        self.text.adjustSize()
        self.text2.setText('<b>' + noun2 + '</b><i>')
        self.text2.adjustSize()
        self.update()       
        
App = QApplication(sys.argv)
window = Window()
window.show()
sys.exit(App.exec())