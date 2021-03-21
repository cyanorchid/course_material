from socket import *
import sys
import time
from datetime import datetime

clientsocket = socket(AF_INET, SOCK_DGRAM)
clientsocket.settimeout(1)

host = sys.argv[1]
port = int(sys.argv[2])
addr = (host, port)
clientsocket.connect((host, port))
fail_num = 0
success_num = 1
rtt = []
rtt_all = 0

for i in range(1, 11):
    message: str = "Ping "
    message += str(i)
    message += " "
    message += time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

    try:
        start = datetime.now()
        clientsocket.sendto(message.encode(), addr)
        reply, addr = clientsocket.recvfrom(1024)
        end = datetime.now()
        rtt.append((end - start).microseconds / 1000)
        print("Reply from %s:%s,RTT=%sms" % (host, reply, rtt[success_num]))
        success_num += 1


    except Exception:

        fail_num += 1
        print("Request timed out")

    #print("\n")

loss_rate = fail_num / 10

if fail_num != 10:
    print("lossrate = %.2f, rtt_max = %d, rtt_min = %d, rtt_avg = %.2f" % (
        loss_rate, max(rtt), min(rtt), sum(rtt) / (10 - fail_num)))

else:
    print("\nPacket Loss Rate = 100%")

clientsocket.close()
