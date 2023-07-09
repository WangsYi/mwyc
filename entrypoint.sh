#!/bin/bash

# 下载文件并添加执行权限
curl -O https://down.xiaomy.net/linux/wyc_linux_64
chmod +x wyc_linux_64

# 方法来获取字符串数组
get_tokens() {
  local config_file_path="config.txt"  # 配置文件路径
  local tokens=()

  # 检查是否存在配置文件
  if [[ -f "$config_file_path" ]]; then
    # 从配置文件中读取每一行作为一个token
    while IFS= read -r line
    do
      tokens+=("$line")
    done < "$config_file_path"
  elif [[ -n "$TOKENS" ]]; then
    # 尝试读取环境变量
    IFS=',' read -ra tokens <<< "$TOKENS"
  else
    echo "无法获取tokens，配置文件不存在，且环境变量 TOKENS 未设置。"
    exit 1
  fi

  echo "${tokens[@]}"
}

# 获取字符串数组
tokens=( $(get_tokens) )

# 并发启动 wyc_linux_64，将参数以 -token=xxx 形式传递
for token in "${tokens[@]}"
do
  nohup ./wyc_linux_64 -token="$token" >> /root/output.log 2>&1 &
done
tail -f /root/output.log