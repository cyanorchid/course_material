from socket import *
import sys

clientsocket = socket()
host = '127.0.0.1'
port = 10010
clientsocket.connect((host,port))

# http_request = "GET /hello.html /HTTP/1.1\r\nhost:{}\r\n\r\n".format(host)

http_request = "GET /"
http_request += "zzh.html"
http_request += "\r\nhost:{}\r\n\r\n"

request = http_request.encode('utf-8')
clientsocket.send(request)

response = clientsocket.recv(1024)
print(response.decode('utf-8'),end="")
temp = response

while True:
    response = clientsocket.recv(1024)
    if response != temp :
        print(response.decode('utf-8'),end="")
    temp = response


clientsocket.close()


