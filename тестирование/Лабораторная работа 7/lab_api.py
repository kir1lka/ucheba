"""Учебный CRUD API для лабораторных 7 и 8. Python 3, без зависимостей."""
import json, re
from pathlib import Path
from http.server import ThreadingHTTPServer, BaseHTTPRequestHandler
ROOT=Path(__file__).resolve().parent
users={1:{'id':1,'name':'Initial User','email':'initial@example.test'}}
counter=1
class Handler(BaseHTTPRequestHandler):
    def reply(self,status,data=None):
        raw=b'' if data is None else json.dumps(data,ensure_ascii=False).encode()
        self.send_response(status)
        self.send_header('Content-Type','application/json; charset=utf-8')
        self.send_header('Content-Length',str(len(raw)))
        self.end_headers(); self.wfile.write(raw)
    def route(self):
        global counter
        path=self.path.split('?')[0]
        if self.command=='GET' and path in ['/openapi.json','/docs']:
            if path=='/docs':
                raw=(ROOT/'swagger.html').read_bytes(); self.send_response(200);self.send_header('Content-Type','text/html; charset=utf-8');self.end_headers();self.wfile.write(raw);return
            return self.reply(200,json.loads((ROOT/'openapi.json').read_text(encoding='utf-8')))
        if path=='/users' and self.command=='GET': return self.reply(200,list(users.values()))
        match=re.fullmatch(r'/users/(\d+)',path)
        uid=int(match[1]) if match else None
        if self.command=='GET':
            return self.reply(200,users[uid]) if uid in users else self.reply(404,{'error':'User not found'})
        if self.command=='DELETE':
            if uid not in users:return self.reply(404,{'error':'User not found'})
            del users[uid];return self.reply(204)
        if self.command not in ['POST','PUT'] or (self.command=='POST' and path!='/users') or (self.command=='PUT' and not match):return self.reply(404,{'error':'Route not found'})
        if self.command=='PUT' and uid not in users:return self.reply(404,{'error':'User not found'})
        try:data=json.loads(self.rfile.read(int(self.headers.get('Content-Length','0'))))
        except (ValueError,UnicodeDecodeError):return self.reply(400,{'error':'Invalid JSON'})
        if not isinstance(data,dict):return self.reply(400,{'error':'Object required'})
        if not isinstance(data.get('name'),str) or not data['name'].strip():return self.reply(400,{'error':'name is required'})
        if not isinstance(data.get('email'),str) or not re.fullmatch(r'[^\s@]+@[^\s@]+\.[^\s@]+',data['email']):return self.reply(400,{'error':'valid email is required'})
        if self.command=='POST': counter+=1;uid=counter
        users[uid]={'id':uid,'name':data['name'].strip(),'email':data['email']}
        return self.reply(201 if self.command=='POST' else 200,users[uid])
    do_GET=route
    do_POST=route
    do_PUT=route
    do_DELETE=route
if __name__=='__main__':
    print('API http://127.0.0.1:8765  Swagger http://127.0.0.1:8765/docs',flush=True)
    ThreadingHTTPServer(('127.0.0.1',8765),Handler).serve_forever()
