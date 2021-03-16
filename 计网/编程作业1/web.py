from socket import *
import sys

serverSocket = socket(AF_INET, SOCK_STREAM)

# Prepare a sever socket
#Fill in start


serverSocket.setsockopt(SOL_SOCKET,SO_REUSEADDR,1)

serverSocket.bind(('127.0.0.1',10010))

serverSocket.listen(5)

#Fill in end

while True:
	# Establish the connection

	print ('Ready!\r\n')

	# Set up a new connection from the client
	# #Fill in start

	connectionSocket, addr = serverSocket.accept()

	#Fill in end

	try:
		# Receives the request message from the client

		#Fill in start
		message = connectionSocket.recv(1024).decode()
		print("request message:", message)
		# #Fill in end

		# Extract the path of the requested object from the message
		# The path is the second part of HTTP header, identified by [1]
		filename = message.split()[1]
		print("request filename:", filename)


		# Because the extracted path of the HTTP request includes 
		# a character '/', we read the path from the second character
		f = open(filename[1:])

		# Store the entire contenet of the requested file in a temporary buffer
		#Fill in start
		outputdata = f.read()
		# #Fill in end

		# Send the HTTP response header line to the connection socket
		#Fill in start
		connectionSocket.send(("HTTP/1.1 200 OK \r\n").encode())
		connectionSocket.send(("Content-Type: text/html\n\n").encode())
		#Fill in end

		# Send the content of the requested file to the connection socket
		for i in range(0, len(outputdata)):
			connectionSocket.send(outputdata[i].encode())
		connectionSocket.send(("\r\n").encode())

		# Close the client connection socket
		connectionSocket.close()

	except IOError:
		# Send HTTP response message for file not found
		#Fill in start
		connectionSocket.send(("HTTP/1.1 404 NOT FOUND\r\n").encode())
		connectionSocket.send(("<html><head></head><body><h1>ERROR. TRY AGAIN</h1></body></html>\r\n").encode())
		#Fill in end

		# Close the client connection socket
		#Fill in start
		connectionSocket.close()
		#Fill in end
		break

	print("\r\n\r\n")

serverSocket.close()

# Terminate the program after sending the corresponding data
sys.exit()
