import requests
import telebot
from telebot import types
import time
import urllib.request
import os
import mysql.connector
from datetime import date

bot = telebot.TeleBot("#") #token

nama_toko = None
id_toko = None
nama_barang = None
jumlah = None
tanggal = None
id_penjualan = None

print("MULAI")
bot.send_message(
    731759989, "BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/list_toko - UNTUK MELIHAT DAFTAR TOKO\n/list_barang - UNTUK MELIHAT LIST BARANG\n/buat_pesanan - UNTUK MEMBUAT PESANAN\n/upload_bukti_pembayaran - UNTUK UPLOAD BUKTI PEMBAYARAN")


@bot.message_handler(commands=['start'])
def send_welcome(message):
    pesan = "BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/list_toko - UNTUK MELIHAT DAFTAR TOKO\n/list_barang - UNTUK MELIHAT LIST BARANG\n/buat_pesanan - UNTUK MEMBUAT PESANAN\n/upload_bukti_pembayaran - UNTUK UPLOAD BUKTI PEMBAYARAN"
    inbox("/start")
    outbox(pesan)
    bot.reply_to(
        message, pesan)


@bot.message_handler(commands=['help'])
def send_welcomes(message):
    pesan = "BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/list_toko - UNTUK MELIHAT DAFTAR TOKO\n/list_barang - UNTUK MELIHAT LIST BARANG\n/buat_pesanan - UNTUK MEMBUAT PESANAN\n/upload_bukti_pembayaran - UNTUK UPLOAD BUKTI PEMBAYARAN"
    inbox("/help")
    outbox(pesan)
    bot.reply_to(
        message, pesan)


@bot.message_handler(commands=['end'])
def send_message(message):
    pesan = "TERIMA KASIH MENGGUNAKAN LAYANAN INI"
    inbox("/end")
    outbox(pesan)
    bot.reply_to(
        message, pesan)
    bot.stop_polling()
    print("SELESAI")


@bot.message_handler(commands=['list_toko'])
def toko_message(message):
    inbox("/list_toko")
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    cursor.execute("SELECT * FROM toko")
    hasil_sql = cursor.fetchall()
    balas = ""
    for x in hasil_sql:
        balas = balas + "- " + x[1] + '\n'

    text = '''
LIST TOKO YANG TERSEDIA :

{}
    '''.format(balas)
    outbox(text)
    bot.reply_to(message, text)


@bot.message_handler(commands=['list_barang'])
def produk_message(message):
    inbox("/list_barang")
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
        toko_type = types.KeyboardButton(data[0])
        pilih_toko.row(toko_type)
        balas = balas+str(data[0])+". "+data[1]+"\n"
    db.close()
    text = '''
LIST TOKO (ID. TOKO):
{}
PILIH ID TOKO UNTUK MELIHAT BARANG
    '''.format(balas)

    outbox(text)
    reply = bot.reply_to(message, text, reply_markup=pilih_toko)
    bot.register_next_step_handler(reply, cek_toko)


def cek_toko(message):
    global id_toko
    id_toko = str(message.text)
    inbox(id_toko)
    e = types.ReplyKeyboardRemove()
    balas = ""

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    cursor.execute(
        "SELECT * FROM barang JOIN toko ON barang.id_toko = toko.id_toko WHERE barang.id_toko={}".format(id_toko))
    for x in cursor.fetchall():
        balas = balas + "- " + x[1] + " [Rp." + x[2]+"]\n"
    db.close()
    text = '''
LIST BARANG:
{}
    '''.format(balas)

    outbox(text)
    bot.reply_to(message, text, reply_markup=e)


@bot.message_handler(commands=['buat_pesanan'])
def choose_toko(message):
    balas = ""
    inbox("/buat_pesanan")
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
        toko_type = types.KeyboardButton(data[0])
        pilih_toko.row(toko_type)
        balas = balas+str(data[0])+". "+data[1]+"\n"
    db.close()
    text = '''
LIST TOKO (ID. TOKO):
{}
PILIH ID TOKO UNTUK MEMESAN
    '''.format(balas)

    outbox(text)
    balas = bot.reply_to(message, text, reply_markup=pilih_toko)
    bot.register_next_step_handler(balas, choose_produk)


def choose_produk(message):
    global id_toko
    id_toko = str(message.text)
    inbox(id_toko)
    balas = ""

    pilih_produk = types.ReplyKeyboardMarkup()

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    cursor.execute(
        "SELECT * FROM barang JOIN toko ON barang.id_toko = toko.id_toko WHERE barang.id_toko={}".format(id_toko))
    for data in cursor.fetchall():
        toko_type = types.KeyboardButton(data[0])
        pilih_produk.row(toko_type)
        balas = balas+str(data[0])+". "+str(data[1]) + \
            " "+"[Rp."+str(data[2])+"]\n"
    db.close()
    text = '''
LIST BARANG (ID. BARANG):
{}
PILIH ID BARANG UNTUK MEMILIH BARANG
    '''.format(balas)

    outbox(text)
    balas = bot.reply_to(message, text, reply_markup=pilih_produk)
    bot.register_next_step_handler(balas, pesan_jumlah)


def pesan_jumlah(message):
    global id_barang
    id_barang = str(message.text)
    inbox(id_barang)
    e = types.ReplyKeyboardRemove()
    teks = "MASUKKAN JUMLAH PESANAN"
    outbox(teks)
    balas = bot.reply_to(message, teks, reply_markup=e)
    bot.register_next_step_handler(balas, pesan_total)


def pesan_total(message):
    global id_toko
    global id_barang
    global jumlah
    global total
    global tanggal
    total = 0
    jumlah = str(message.text)
    inbox(jumlah)
    balas = ""
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    cursor.execute(
        "SELECT harga FROM barang WHERE barang.id_barang= {}".format(id_barang))
    for data in cursor.fetchall():
        print(data[0])
        total = total + (int(data[0])*int(jumlah))

    db.close()
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="officialti_bot"
    )
    cursor = db.cursor()
    tanggal = date.today()
    insert = "INSERT INTO penjualan(tanggal, status_pesanan, id_barang, jumlah, total) VALUES (%s, %s, %s, %s, %s)"
    val = (tanggal, "unverified", id_barang, jumlah, total)

    cursor.execute(insert, val)
    db.commit()
    db.close()
    balas = "TOTAL = RP." + str(
        total)+"\nPESANAN BERHASIL DITAMBAHKAN"

    outbox(balas)
    bot.reply_to(message, balas)


@bot.message_handler(commands=['upload_bukti_pembayaran'])
def pesanan_update(message):
    balas = ""
    inbox("/upload_bukti_pembayaran")
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
============================================
LIST PEMESANAN :
[ID] [Tanggal] [Barang] [Jumlah] [Total] [Status]
============================================

{}
    '''.format(balas)
    outbox(text)
    balas = bot.reply_to(message, text, reply_markup=verif)
    bot.register_next_step_handler(balas, pilih_pembelian)


def pilih_pembelian(message):
    global id_penjualan
    id_penjualan = str(message.text)
    inbox(id_penjualan)
    e = types.ReplyKeyboardRemove()
    outbox("DATA PENJUALAN BERHASIL DIPILIH\nBERIKUTNYA MASUKKAN BUKTI PEMBAYARAN BERUPA GAMBAR")
    bot.reply_to(
        message, "DATA PENJUALAN BERHASIL DIPILIH\nBERIKUTNYA MASUKKAN BUKTI PEMBAYARAN BERUPA GAMBAR", reply_markup=e)

    @bot.message_handler(content_types=['photo'])
    def save_photo(message):
        FILE_ID = message.json["photo"][2]["file_id"]
        RES = requests.get(
            "https://api.telegram.org/bot5259374638:AAFHek9SJ1TaJ9YljlpwfuZvkaZPAO-EA7E/getFile?file_id=" + FILE_ID)
        RES = RES.json()
        URL = RES["result"]["file_path"]

        file_name = URL.split("/")

        FULL_URL = "https://api.telegram.org/file/bot5259374638:AAFHek9SJ1TaJ9YljlpwfuZvkaZPAO-EA7E/" + URL

        print('Menyimpan foto broadcast kedalam database.')

        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="officialti_bot"
        )
        cursor = db.cursor()
        sql = "INSERT INTO pembayaran (id_penjualan, gambar) VALUES (%s, %s)"
        val = (id_penjualan, FULL_URL)
        cursor.execute(sql, val)
        db.commit()
        db.close()
        outbox("BUKTI PEMBAYARAN BERHASIL DIKIRIMKAN")
        bot.reply_to(message, "BUKTI PEMBAYARAN BERHASIL DIKIRIMKAN")


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
