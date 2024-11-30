环境启动
```bash
docker compose -p sf-project up -d --build
ssh root@localhost -p 2222
```
然后开始写代码

环境停止
```bash
docker compose -p sf-project down --rmi all
```

