+++
title = "折腾Emacs的Guile开发环境的笔记"
author = ["MinkieYume"]
lastmod = 2025-07-05T10:03:05+08:00
tags = ["程序", "折腾", "guile", "emacs"]
draft = false
toc = true
+++

## 前言 {#前言}

考虑到emacs和guile文档实在太少，就试着把折腾的过程记录下来吧，方便日后复盘。


## 安装Guile和Emacs的插件 {#安装guile和emacs的插件}

首先是安装guile，因为我用的是gentoo系统，所以我可以直接使用：

```shell
doas emerge --ask dev-scheme/guile
```

来安装guile，经过漫长的编译等待后终于完成了安装。

接下来是emacs插件的安装，首先是括号高亮插件，我用的七彩括号：

```emacs-lisp
(use-package rainbow-delimiters
  :straight t
  :hook ((prog-mode conf-mode yaml-mode) . rainbow-delimiters-mode)
  :config
  (setq rainbow-delimiters-max-face-count 5))
```

然后就是geiser的安装，这是chatGPT告诉我的插件，用于emacs中的guile交互式界面：

```emacs-lisp
(use-package geiser
  :straight t
  :config
  (setq geiser-active-implementations '(guile)))

(use-package geiser-guile
:straight t)
```

安装完成，接下来运行scheme测试下：

运行命令：

```text
M-x run-geiser
```

如果安装顺利的话，会正常进入geiser的REPL界面。

具体的geiser插件使用的话，我把我可能会常用的快捷键在这里记录下：

| 快捷键  | 作用        |
|------|-----------|
| C-c C-s | 指定语言    |
| C-c C-z | 切换到REPL  |
| C-c C-b | 运行文件    |
| C-c C-k | 编译运行    |
| C-x C-e | 执行光标前面的S表达式 |
| C-c C-r | 执行区域    |


## 折腾Guix的安装 {#折腾guix的安装}

Guix是很方便的包管理器，虽然不是必须的，但我还是在尝试安装这个包管理器，暂时不打算更换到Guix，而是先将guix作为包管理器尝试使用，再考虑日后迁移。

根据gentoo的教程，在gentoo上安装guix首先需要添加csfore-overlay这一build：

```shell
doas eselect repository add csfore-overlay git https://github.com/csfore/gentoo-overlay.git
doas emerge --sync
```

然后还需要将这两个条目添加到 package.accept_keywords 中

```text
sys-apps/guix ~amd64
dev-scheme/* ~amd64
```

虽然一个一个添加也可，但是懒得手动输入，所以直接将dev-scheme全部加入accept_keywords中了。

然后就是使用：

```shell
doas emerge --ask guix
```

来安装guix了。
