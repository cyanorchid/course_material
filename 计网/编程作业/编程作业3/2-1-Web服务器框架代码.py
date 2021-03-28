from socket import *
import sys

serverSocket = socket(AF_INET, SOCK_STREAM)

# Prepare a sever socket
#Fill in start
#Fill in end

while True:
	# Establish the connection
	print (' The server is ready to receive')

	# Set up a new connection from the client
	connectionSocket, addr =  #Fill in start  #Fill in end

	try:
		# Receives the request message from the client
		message =  #Fill in start  #Fill in end

		# Extract the path of the requested object from the message
		# The path is the second part of HTTP header, identified by [1]
		filename = message.split()[1]

		# Because the extracted path of the HTTP request includes 
		# a character '/', we read the path from the second character
		f = open(filename[1:])

		# Store the entire contenet of the requested file in a temporary buffer
		outputdata =  #Fill in start  #Fill in end

		# Send the HTTP response header line to the connection socket
		#Fill in start
		#Fill in end

		# Send the content of the requested file to the connection socket
		for i in range(0, len(outputdata)):
			connectionSocket.send(outputdata[i].encode())

		# Close the client connection socket
		connectionSocket.close()

	except IOError:
		# Send HTTP response message for file not found
		#Fill in start
		#Fill in end

		# Close the client connection socket
		#Fill in start
		#Fill in end 

serverSocket.close()

# Terminate the program after sending the corresponding data
sys.exit()
