import requests
import telebot
from telebot import types
import time
import urllib.request
import os
import mysql.connector

bot = telebot.TeleBot("#") #token

id_toko = None
nama = None
nama = None
jumlah = None

print("MULAI")
bot.send_message(
    731759989, "BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/daftar_toko - UNTUK MENDAFTARKAN TOKO\n/tambah_barang - UNTUK MENAMBAHKAN BARANG\n/list_pesanan - UNTUK LIST PESANAN\n/verifikasi_pesanan - UNTUK MEMVERIFIKASI PESANAN")


@bot.message_handler(commands=['start'])
def send_welcome(message):
    inbox("/start")
    outbox("SELAMAT DATANG\nBERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/daftar_toko - UNTUK MENDAFTARKAN TOKO\n/tambah_barang - UNTUK MENAMBAHKAN BARANG\n/list_pesanan - UNTUK LIST PESANAN\n/verifikasi_pesanan - UNTUK MEMVERIFIKASI PESANAN")
    bot.reply_to(
        message, "SELAMAT DATANG\nBERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/daftar_toko - UNTUK MENDAFTARKAN TOKO\n/tambah_barang - UNTUK MENAMBAHKAN BARANG\n/list_pesanan - UNTUK LIST PESANAN\n/verifikasi_pesanan - UNTUK MEMVERIFIKASI PESANAN")


@bot.message_handler(commands=['help'])
def send_welcome(message):
    inbox("/help")
    outbox("BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/daftar_toko - UNTUK MENDAFTARKAN TOKO\n/tambah_barang - UNTUK MENAMBAHKAN BARANG\n/list_pesanan - UNTUK LIST PESANAN\n/verifikasi_pesanan - UNTUK MEMVERIFIKASI PESANAN")
    bot.reply_to(
        message, "BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/daftar_toko - UNTUK MENDAFTARKAN TOKO\n/tambah_barang - UNTUK MENAMBAHKAN BARANG\n/list_pesanan - UNTUK LIST PESANAN\n/verifikasi_pesanan - UNTUK MEMVERIFIKASI PESANAN")


@bot.message_handler(commands=['end'])
def send_message(message):
    inbox("/end")
    outbox("TERIMA KASIH MENGGUNAKAN LAYANAN INI")
    bot.reply_to(
        message, "TERIMA KASIH MENGGUNAKAN LAYANAN INI")
    bot.stop_polling()
    print("SELESAI")


@bot.message_handler(commands=['daftar_toko'])
def bc_text(message):
    inbox("/daftar_toko")
    balas = "MASUKKAN NAMA TOKO ANDA: "
    outbox(balas)
    bot.reply_to(message, balas)

    @bot.message_handler(func=lambda message: True)
    def save_message(message):
        nama = message.text
        inbox(nama)
        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="officialti_bot"
        )
        cursor = db.cursor()
        sql = "INSERT INTO toko (nama) VALUES (%s)"
        val = (nama, )
        cursor.execute(sql, val)
        db.commit()
        db.close()
        balas = "DATA BERHASIL DISIMPAN"
        outbox(balas)
        bot.reply_to(message, balas)


@bot.message_handler(commands=['tambah_barang'])
def bc_text(message):
    balas = ""
    inbox("/tambah_barang")
    pilih_toko = types.ReplyKeyboardMarkup()
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    cursor.execute("SELECT * FROM toko")
    for data in cursor.fetchall():
        toko = types.KeyboardButton(data[0])
        pilih_toko.row(toko)
        balas = balas+str(data[0])+". "+data[1]+"\n"
    db.close()
    text = '''
TAMBAH TOKO (ID_Toko):
{}
PILIH ID TOKO YANG INGIN DITAMBAHKAN BARANG
    '''.format(balas)

    outbox(text)
    balas = bot.reply_to(message, text, reply_markup=pilih_toko)
    bot.register_next_step_handler(balas, tambah_barang)


def tambah_barang(message):
    global id_toko
    id_toko = str(message.text)
    inbox(id_toko)
    e = types.ReplyKeyboardRemove()
    teks = "MASUKKAN NAMA BARANG"
    outbox(teks)
    balas = bot.reply_to(message, teks, reply_markup=e)
    bot.register_next_step_handler(balas, jumlah_barang)


def jumlah_barang(message):
    global nama
    nama = str(message.text)
    inbox(nama)
    teks = "MASUKKAN JUMLAH BARANG"
    outbox(teks)
    balas = bot.reply_to(message, teks)
    bot.register_next_step_handler(balas, harga_barang)


def harga_barang(message):
    global jumlah
    jumlah = str(message.text)
    inbox(jumlah)
    teks = "MASUKKAN HARGA BARANG"
    outbox(teks)
    balas = bot.reply_to(message, teks)
    bot.register_next_step_handler(balas, insert_barang)


def insert_barang(message):
    global nama
    global id_toko
    global jumlah
    harga = str(message.text)
    inbox(harga)
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    insert = "INSERT INTO barang(nama, harga, jumlah, id_toko) VALUES (%s, %s, %s, %s)"
    val = (nama, harga, jumlah, id_toko)

    cursor.execute(insert, val)
    db.commit()
    balas = ""

    sql = "SELECT * FROM barang JOIN toko ON barang.id_toko = toko.id_toko where barang.id_toko = %s"
    val = (id_toko, )
    cursor.execute(sql, val)
    for x in cursor.fetchall():
        balas = balas + "- " + x[1] + " [Rp." + x[2]+"]\n"
    db.close()
    text = '''
BARANG BERHASIL DITAMBAHKAN

LIST BARANG:
{}
    '''.format(balas)
    outbox(text)
    bot.reply_to(message, text)


@bot.message_handler(commands=['list_pesanan'])
def pesanan_message(message):
    inbox("/list_pesanan")
    balas = ""
    pilih_toko = types.ReplyKeyboardMarkup()
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    cursor.execute("SELECT * FROM toko")
    for data in cursor.fetchall():
        toko = types.KeyboardButton(data[0])
        pilih_toko.row(toko)
        balas = balas+str(data[0])+". "+data[1]+"\n"
    db.close()
    text = '''
LIST PESANAN TOKO (ID_Toko):
{}
PILIH ID TOKO YANG INGIN DILIHAT LIST PESANANNYA
    '''.format(balas)

    outbox(text)
    balas = bot.reply_to(message, text, reply_markup=pilih_toko)
    bot.register_next_step_handler(balas, lihat_list_pesanan)


def lihat_list_pesanan(message):
    global id_toko
    id_toko = str(message.text)
    inbox(id_toko)
    balas = ""
    e = types.ReplyKeyboardRemove()
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    sql = "SELECT * FROM penjualan JOIN barang ON barang.id_barang = penjualan.id_barang JOIN toko ON barang.id_toko = toko.id_toko where toko.id_toko = %s"
    val = (id_toko,)
    cursor.execute(sql, val)
    for x in cursor.fetchall():
        balas = balas + "- " + "[" + str(x[1]) + "] [" + (x[7]) + \
            "] [" + str(x[4]) + "] [" + str(x[5]) + "] [" + x[2] + "]\n"
    db.close()
    text = '''
============================================
LIST PEMESANAN:
[Tanggal] [Barang] [Jumlah] [Total] [Status]
============================================
{}
    '''.format(balas)

    outbox(text)
    balas = bot.reply_to(message, text, reply_markup=e)


@bot.message_handler(commands=['verifikasi_pesanan'])
def pesanan_update(message):
    inbox("/verifikasi_pesanan")
    balas = ""
    verif = types.ReplyKeyboardMarkup()
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    cursor.execute(
        "SELECT * FROM penjualan JOIN barang ON barang.id_barang = penjualan.id_barang WHERE penjualan.status_pesanan = 'unverified'")
    for x in cursor.fetchall():
        toko_type = types.KeyboardButton(x[0])
        verif.row(toko_type)
        balas = balas + "- " + " [" + str(x[0]) + "] [" + str(x[1]) + "] [" + (x[7]) + \
            "] [" + str(x[4]) + "] [" + str(x[5]) + "] [" + (x[2]) + "]\n"
    db.close()
    text = '''
List Pesanan

============================================
[ID] [Tanggal] [Barang] [Jumlah] [Total] [Status]
============================================

{}
    '''.format(balas)
    outbox(text)
    balas = bot.reply_to(message, text, reply_markup=verif)
    bot.register_next_step_handler(balas, acc_pesanan)


def acc_pesanan(message):
    global id_penjualan
    id_penjualan = str(message.text)
    inbox(id_penjualan)
    e = types.ReplyKeyboardRemove()

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    cursor.execute(
        "SELECT id_barang FROM penjualan WHERE id_penjualan = {}".format(id_penjualan))
    for data in cursor.fetchall():
        id_barang_terjual = data[0]

    cursor.execute(
        "SELECT jumlah FROM penjualan WHERE id_penjualan = {}".format(id_penjualan))
    for data in cursor.fetchall():
        jml_barang_terjual = data[0]

    cursor.execute(
        "SELECT jumlah FROM barang WHERE id_barang = {}".format(id_barang_terjual))
    for data in cursor.fetchall():
        jml_barang = data[0]

    jml_baru = jml_barang - jml_barang_terjual
    update_barang = "UPDATE barang SET jumlah = %s WHERE id_barang = {}".format(
        id_barang_terjual)
    val1 = (jml_baru, )

    update = "UPDATE penjualan SET status_pesanan = %s WHERE id_penjualan = {}".format(
        id_penjualan)
    val = ("verified", )

    cursor.execute(update, val)
    db.commit()

    cursor.execute(update_barang, val1)
    db.commit()

    bot.reply_to(message, "PESANAN BERHASIL DI VERIFIKASI", reply_markup=e)
    print("Data berhasil diverifikasi")
    outbox("PESANAN BERHASIL DI VERIFIKASI")
    bot.reply_to(
        message, "BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/daftar_toko - UNTUK MENDAFTARKAN TOKO\n/tambah_barang - UNTUK MENAMBAHKAN BARANG\n/list_pesanan - UNTUK LIST PESANAN\n/verifikasi_pesanan - UNTUK MEMVERIFIKASI PESANAN")


def inbox(pesan):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    sql = "INSERT INTO inbox (pesan) VALUES (%s)"
    val = (str(pesan), )
    cursor.execute(sql, val)
    db.commit()
    db.close()


def outbox(pesan):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    sql = "INSERT INTO outbox (pesan) VALUES (%s)"
    val = (str(pesan), )
    cursor.execute(sql, val)
    db.commit()
    db.close()


bot.delete_webhook()
bot.message_handler()
bot.polling(none_stop=True)
