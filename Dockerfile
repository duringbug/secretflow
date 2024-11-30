# 使用 secretflow/secretflow-anolis8:latest 作为基础镜像
FROM secretflow/secretflow-anolis8:latest

# 定义密码变量（可以在构建时传入）
ARG ROOT_PASSWORD

# 更新包管理器并安装 OpenSSH 服务
RUN yum update -y && \
    yum install -y openssh-server && \
    yum clean all

# 设置 root 密码（使用构建时传入的变量）
RUN echo "root:$ROOT_PASSWORD" | chpasswd

# 创建 SSH 配置目录并初始化 SSH 服务
RUN mkdir -p /var/run/sshd

# 生成 SSH 主机密钥
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N "" && \
    ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N "" && \
    ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""

# 修改 sshd_config 文件，允许 root 用户登录
RUN sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 暴露容器的 22 端口并将其映射到宿主机的 2222 端口
EXPOSE 22

# 启动 SSH 服务，保持容器前台运行
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
