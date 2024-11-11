#/*************************************************
#*  install.sh modified for Ubuntu by echo, 2021年 05月 24日 星期一 11:33:25 CST
#*************************************************/
#!/bin/sh
function echo_dbg_p(){
  echo "echo_dbg, $@"
}

function usage(){
  echo -e "usages: $0 [H|h|help] [-h] [-s]
  [H|h|help]: check the usages\n
  []"
}

# main
# maven install check
cmd_package=apt
if ! mvn -v >/dev/null; then
  sudo $cmd_package update
  sudo $cmd_package install -y maven
fi

# java install check
if ! java -version &>/dev/null; then
  sudo $cmd_package update
  sudo $cmd_package install -y default-jdk
fi

# mysql install check
if ! mysql -V >/dev/null; then 
  sudo $cmd_package update
  sudo $cmd_package install -y mysql-server
  sudo systemctl start mysql
  sudo systemctl enable mysql
fi

# build path check
# build_root_path=./
settingDir=src/main/resources/conf/settings.xml

mvn clean install -s $settingDir

# 修改配置文件
sed -i "s#D:/temp_db#/tmp/#g" release/conf/config/application-dev.properties
echo_dbg_p "warning, PLS create mysql with name file, and set the password follow the file qiwen-file/file-web/src/main/resources/config/application-prod.properties"

# 参数处理
case $1 in
  H|h|help)
    usage
    ;;
  *)
    while getopts :s:h opt
    do  
      case $opt in
        s)
          echo "-s=$OPTARG"
          ;;
        :)
          echo "-$OPTARG needs an argument"
          ;;
        h)
          echo "-h is set"
          ;;
        *)
          echo "-$opt not recognized"
          ;;
      esac
    done
    ;;
esac
