环境启动
```bash
docker compose -p sf-project up -d --build
ssh root@localhost -p 2222
```

密码在`docker-compose.yml`中设置，初始`123456`

然后开始写代码

停止容器清理镜像
```bash
docker compose -p sf-project down --rmi all
```

