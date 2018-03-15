# v2ray with cdn
这是一个v2ray+nginx+tls+netspeeder+ssh Docker


使用vmess+shadowsocks方案


vmess加密为自动模式，shadowsocks默认chacha20-ietf-poly1305

因为使用了Let's Encrypt，所以需要映射80端口来签证书。

## 参数说明
```
-u UUID 格式为 xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
-vp vmess端口号
-sp shadowsocks端口号
-m shadowsocks加密方式
-k shadowsocks密码
-d v2ray自定义cdn域名
```

## 启动方式

```
docker run -d --name v2ray-cdn-docker -p 6868:6868 -p 6969:6969 -p 22:22 hikaruchang/v2ray-cdn-docker -u 34d28248-ef66-4317-a8a0-02b747ebefd9 -vp 6868 -sp 6969 -m chacha20-ietf-poly1305 -k hahahaha -d example.com
```

## Docker 启动

```
镜像 ：hikaruchang/v2ray-cdn-docker
启动命令(CMD) ：-u 34d28248-ef66-4317-a8a0-02b747ebefd9 -vp 6868 -sp 6969 -m chacha20-ietf-poly1305 -k hahahaha -d example.com
```

## 支持SSH
用户名：root
密  码：password

## 在线生成UUID
```
https://www.uuidgenerator.net/
```
