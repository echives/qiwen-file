# 使用官方 Ubuntu 作为基础镜像
FROM ubuntu:20.04

# 设置环境变量，避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 设置维护者信息（可选）
LABEL maintainer="20yh07@gmail.com"

# 更新系统并安装必要的软件包
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y bash
RUN apt-get install -y openjdk-11-jdk
RUN apt-get install -y maven
RUN apt-get install -y mysql-server
RUN apt-get install -y systemd
RUN apt-get install -y net-tools
RUN apt-get install -y vim
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# 创建目录用于存放下载的资源（如果需要）
RUN mkdir -p /opt/resources
RUN mkdir -p /usr/local/bin/qiwen-file/

# 将本地的 install.sh 脚本复制到镜像中
COPY ./ /usr/local/bin/qiwen-file/

# 给脚本赋予执行权限
RUN chmod +x /usr/local/bin/qiwen-file/install2.sh

# 运行安装脚本以安装和配置必要的资源
RUN bash /usr/local/bin/qiwen-file/install2.sh

# 启动 MySQL 服务并设置为开机启动
# RUN systemctl enable mysql

WORKDIR /usr/local/bin/qiwen-file

# 编译java项目
RUN mvn install

# 设置默认命令
WORKDIR /usr/local/bin/qiwen-file/release/bin
CMD ["bash"]
