#!/usr/bin/python

import socket
import time
from telnetlib import IP


import socket
import sys
import thread



ip = "169.48.154.212"
ip2 = "52.118.151.221"
port2 = 80
port = 80
retry = 2
delay = 2
timeout = 1
threadIdentifier = 0 
settings = [9999, "", 9999, "" , ""]


def isOpen(ip, port):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(timeout)
        try:
            print ("trying the connection for .. host:" + ip + "and port: " + str(port))
            s.connect((ip, int(port)))
            s.shutdown(socket.SHUT_RDWR)
            return True
        except:
                return False
        finally:
                s.close()



def checkHost(ip, port):
        ipup = False
        for i in range(retry):
            if isOpen(ip, port):
                    ipup = True
                    break
            else:
                    time.sleep(delay)
        return ipup

def server(settings):
    try:
        print ("Using the the following port locally  " , settings[0])
        dock_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        dock_socket.bind(('', int(settings[0])))
        print ("Server about to start ")
        dock_socket.listen(5)
        print ("Server is listening")
        while True:
            client_socket = dock_socket.accept()[0]
            print ("New request came in")
            server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            server_socket.settimeout(5)
            print ("Server timeout set ")
            for i in range(retry):
                try:
                    server_socket.connect((settings[1], settings[2]))
                    print ("Server connect successful ")
                    break 
                except Exception as e:
                    print ('Connection error')
                try:
                    server_socket.connect((settings[3], settings[4]))
                    break 
                except Exception as e:
                    print ('Connection error2')
            thread.start_new_thread(forward, (client_socket, server_socket))
            thread.start_new_thread(forward, (server_socket, client_socket))
    except Exception as e:
        print ("Following exeption encountered " + e)
    finally:
        identifier = thread.start_new_thread(server, settings)

def forward(source, destination):
    string = ' '
    while string:
        string = source.recv(1024)
        print ("``````````````````````````````````")
        print (string)
        print ("``````````````````````````````````")
        if string:
            destination.sendall(string)
        else:
            source.shutdown(socket.SHUT_RD)
            destination.shutdown(socket.SHUT_WR)

currentIP = ip
currentPort = port
print ("GAPH: The watchdog service starting is starts here")
for i in range(10):
    if checkHost(currentIP, currentPort):
        print("The following host and port is up and running: Host: " + ip + " and  Port :" + str(port))
        settings.insert(0,"9999")
        settings.insert(1,currentIP)
        settings.insert(2,currentPort)
        settings.insert(3,ip2)
        settings.insert(4,port2)
        server(settings)
        ipup = True
        time.sleep(3) 
    else:
        print ("Fail over process has initiated...")
        print ("trying the connection for .. host:" + ip2 + " and port: " + str(port2))
        for i in range(1000):
                if isOpen(ip, port):
                    currentIP = ip
                    currentPort = port
                    settings.insert(0,"9999")
                    settings.insert(1,currentIP)
                    settings.insert(2,currentPort)
                    settings.insert(3,ip2)
                    settings.insert(4,port2)
                    server(settings)
                    ipup = True
                    break
                elif isOpen(ip2, port2):
                    currentIP = ip2
                    currentPort = port2
                    settings.insert(0,"9999")
                    settings.insert(1,currentIP)
                    settings.insert(2,currentPort)
                    settings.insert(3,ip)
                    settings.insert(4,port)
                    server(settings)
                    ipup = True
                    break
                else:
                    time.sleep(delay)
            
