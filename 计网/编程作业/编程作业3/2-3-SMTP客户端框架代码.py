from socket import *
import base64
import time

debug = True
attach_file = True
# Mail content
subject = "I love computer networks!"
contenttype = "text/plain"
msg = "I love computer networks!"
endmsg = "\r\n.\r\n"
#send time
send_time = time.asctime(time.localtime(time.time()))
#boundary
boundary = 'next-block'

# Choose a mail server (e.g. Google mail server) and call it mailserver
#choose qqmail
mailserver = "smtp.qq.com"

# Sender and reciever
fromaddress = "2435076775@qq.com"
toaddress = "zhang-z.h@foxmail.com"
toaddress = "2019270103014@std.uestc.edu.cn"
# toaddress = "656739092@qq.com"

# Auth information (Encode with base64)
username = base64.b64encode(fromaddress.encode()) .decode()
password = base64.b64encode("mqpyvfzyfbbvdiia".encode()) .decode()

# Create socket called clientSocket and establish a TCP connection with mailserver
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((mailserver, 25))
if debug:
    print("connect success\n")


recv = clientSocket.recv(1024) .decode()
print(recv)

# Send HELO command and print server response.
HELO = 'HELO cyan\r\n'
clientSocket.send(HELO.encode())
if debug:
    print("send HELO success")
recv = clientSocket.recv(1024) .decode()
if debug:
    print("HELO response:")
print(recv)

# Send AUTH LOGIN command and print server response.
clientSocket.sendall('AUTH LOGIN\r\n'.encode())
recv = clientSocket.recv(1024).decode()
if debug:
    print("AUTH LOGIN response:")
print(recv)

clientSocket.sendall((username + '\r\n').encode())
recv = clientSocket.recv(1024).decode()
if debug:
    print("username response:")
print(recv)

clientSocket.sendall((password + '\r\n').encode())
recv = clientSocket.recv(1024).decode()
if debug:
    print("password response:")
print(recv)

# Send MAIL FROM command and print server response.
clientSocket.sendall(('MAIL FROM:<'+fromaddress+'>\r\n').encode())
recv = clientSocket.recv(1024).decode()
if debug:
    print("Send MAIL FROM response:")
print(recv)

# Send RCPT TO command and print server response.
clientSocket.sendall(('RCPT TO:<'+toaddress+'>\r\n').encode())
recv = clientSocket.recv(1024).decode()
if debug:
    print("Send RCPT TO response:")
print(recv)

# Send DATA command and print server response.
clientSocket.sendall('DATA\r\n'.encode())
recv = clientSocket.recv(1024).decode()
if debug:
    print("Send DATA response:")
print(recv)

# Send message data.
message = 'from: ' + fromaddress + ' \r\n'
message += 'to: ' + toaddress + '\r\n'
message += 'subject:' + subject + '\r\n'
message += 'Date:' + send_time + '\r\n'
message += 'MIME-Version: 1.0\r\n'
if attach_file:
    message += 'Content-Type:multipart/mixed;boundary=next-block\r\n'
    #message += "next-block\r\n"
message += 'Content-Type:' + contenttype + '\r\n'
# if attach_file:
#     message += "next-block\r\n"
message += '\r\n' + msg + '\r\n\r\n'
#clientSocket.sendall(message.encode())


# send attachfile
if attach_file:
    file = '/Users/zzh/desktop/hello.txt'
    filename = 'hello.txt'
    message += '\nnext-block\r\n'
    message += 'Content-Type:text/plain;name=hello.txt\r\n'
    message += 'Content-Disposition:attachment;filename=\"hello.txt\"\r\n\r\n'
    f = open(file)
    filedata = f.read()
    message += filedata
clientSocket.sendall(message.encode())

print(message)
# Message ends with a single period and print server response.
clientSocket.sendall((''+endmsg+'\r\n').encode())
recv = clientSocket.recv(1024).decode()
if debug:
    print("Message ends response:")
print(recv)

# Send QUIT command and print server response.
clientSocket.sendall('QUIT\r\n'.encode())
if debug:
    print("Send QUIT response:")
print(recv)

# Close connection
clientSocket.close()
