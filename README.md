# vagrant-php-7

The PHP 7 Development Environments based Vagrant & VirtualBox.

## 包含

| 软件 | 版本 | 账号 | 密码 |
| --- | --- | --- | --- |
| PHP | 7.0.12 | 无 | 无 |
| MySQL | 5.6 | root | root |
| Redis | Ubuntu 14.04 默认版本 | 无 | 无 |
| Supervisor | Ubuntu 14.04 默认版本 | 无 | 无 |
| Swoole | 1.8.7 | 无 | 无 |
| Yaconf | 1.0.2 | 无 | 无 |
| XDebug | 2_5_1 | 无 | 无 |
| PHPMyAdmin | 4.6.6 | 无 | 无 |

## 安装 VirtualBox

参见 <https://www.virtualbox.org/>

## 安装 Vagrant
 
参见 <https://www.vagrantup.com/docs/installation/>

## 安装 Vagrant 插件

因 vagrant 使用了 Ruby 语言，安装插件前需进行一些 Ruby 源的设置，如果可以“科学上网”的话可以跳过。

> 推荐一个还不错的收费科学上网工具: [西游](https://hixiyou.net/?2346775)

替换 Vagrant 安装文件夹中所有文件的 `https://rubygems.org` 为 `http://gems.ruby-china.org`

### 1. vagrant-hostmanager
<https://github.com/devopsgroup-io/vagrant-hostmanager>

配置域名本地解析，可以将自定义域名自动解析到 vagrant 主机。

> 注意: 至少有一个 `private_network` 网络连接，用于解析。

使用下面的命令安装(管理员权限)：

```shell
vagrant plugin install vagrant-hostmanager
```

### 2. vagrant-share
Vagrant 系统内置，用于挂载目录.

### 3. vagrant-vbguest
<https://github.com/dotless-de/vagrant-vbguest>

自动安装与宿主机 virtualbox 相匹配的 vbguest.

使用下面的命令安装(管理员权限)：

```shell
vagrant plugin install vagrant-vbguest
```

### 4. vagrant-winnfsd
主机为 windows 时需要安装

<https://github.com/winnfsd/vagrant-winnfsd>

nfs 挂载插件。

使用下面的命令安装(管理员权限)：

```shell
vagrant plugin install vagrant-winnfsd
```

## 下载

```shell
git clone git@github.com:iPaya/vagrant-php-7.git
```

## 配置 Vagrant

复制 `config/vagrant.example.yml` 到 `config/vagrant.yml`
替换 `<your-personal-github-token>` 为在 GitHub 上申请的 `Token`, 申请地址 <https://github.com/settings/tokens>

根据自己需求配置
> 内存不要小于 2048M, 否则编译 PHP 会内存不足。后续会解决此问题

## 配置 Apache2 虚拟主机

复制 `config/sites.example.yml` 到 `config/sites.yml`

添加站点
```yaml
# 为了能使用 PHPMyAdmin 请保留 `phpmyadmin.local` 段
domains:
  - serverName: "dev.local"
    documentRoot: "/var/www/html"
  - serverName: "phpmyadmin.local"
    documentRoot: "/var/www/phpmyadmin"
  - serverName: "站点域名"
    documentRoot: "站点目录"
```

## 启动

```bash
vagrant up
```

> 在 `vagrant/sites.yml` 中添加或修改了虚拟主机后，需要运行 `vagrant reload && vagrant hostmanager` 来使配置生效 