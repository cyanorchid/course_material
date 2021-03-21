from socket import *
import sys

clientsocket = socket()

host = '127.0.0.1'
port = 90
clientsocket.connect((host,port))

http_request = "GET /hello.html /HTTP/1.1\r\nhost:{}\r\n\r\n".format(host)
request = http_request.encode('utf-8')
clientsocket.send(request)


for i in range(0,150):
    response = clientsocket.recv(4096)
    print(response.decode('utf-8'))

clientsocket.close()


