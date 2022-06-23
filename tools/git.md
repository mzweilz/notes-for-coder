## 基本操作
### 分支
```
# 本地重命名分支
git branch -m oldName newName

# 删除本地分支
branch -D devel-guest-vmcore

# 远程分支重命名
git push --delete origin dev
git branch -m dev develop
git push origin develop

# 拉最新分支
git pull --rebase
git pull     从远程拉取最新版本 到本地  自动合并 merge            
git pull origin master
git fetch   从远程获取最新版本 到本地   不会自动合并 merge    
git fetch origin master       
git log -p master ../origin/master     
git merge orgin/master
# 实际使用中，使用git fetch更安全。在merge之前可以看清楚更新情况再决定是否合并。

# push本地分支到远程仓库
git push origin <local_branch>:<remote_branch>
git push origin vmcore:devel-guest-vmcore

# 从某个分支（的最新commit）单独拿某个文件
git checkout <branch> <file>
```

### 配置
```
# 配置免密
git config credential.helper store

# 配置git用户名和邮箱
git config --global user.email "xxxx.com"
git config --global user.name "user"

# 不用pager
method 1. git diff | cat... removes all syntax highlighting
method 2. git config --global core.pager cat sets the pager in the global .gitconfig to cat
method 3. export GIT_PAGER=cat
```


### tag
```
git tags -l
git checkout tags/xxx -b xxx //在新的分支上切换到某tags的版本
```

### 流程
```
# 小修改（慎重）——最新分支
git add file
git commit --amend
git push -f origin vmcore:devel-guest-vmcore

# 小修改——特定分支
git stash
git rebase <commit> -i/--interactive    指定commit：pick -> edit

----
fix bug...
git add 
git commit --amend
----
git rebase --continue
git stash pop

# 恢复到某次commit
git reset e323fsas	回滚到某次提交。
git reset --soft e323fsas	此次提交之后的修改会被退回到暂存区。
git reset --hard e323fsas	此次提交之后的修改不做任何保留，git status 查看工作区是没有记录的。

# 撤回对某一文件的修改
git reset 3e86ed8 Cargo.lock
git checkout Cargo.lock
git add
git commit --amend

# 解决error: could not apply 3e86ed8...
git status
git add
git commit -c 3e86ed8 // 重用改commit号的commit message
```

### commit
```
git commit -s
git commit --amend
```

### 把远程分支origin/devel-guest-vmcore拉到本地分支vmcore
```
git checkout -b vmcore origin/devel-guest-vmcore
git show - 查看最新commit的diff
git diff - 查看未commit的diff

# 把本地仓库设为remote
git remote add branch_B /path_to_branch_B
git fetch branch_B
```

### 查看某行代码是谁写的
```
git blame <filename>
```

### 打patch
```
git format-patch <commit> -n //某个commit（含）往前的n个patch
git format-patch <commit1>..<commit2> //两次commit之间的所有patch
git am <path-to-patch> //auto merge某个patch
```

### rebase master
```
git checkout master
git pull
git checkout mengze/vmcore
git rebase master
//fix conflict
//git add conflict file
//git rebase --continue
```

### 比较分支差异并应用
```
git diff branch1 branch2
git diff branch1 branch2 --stat (文件列表）
git diff master dev >> master-to-dev.patch
git checkout master
git apply master-to-dev.patch
```

### 查找
```
# 锁定包含某个commit号的分支（remote+local）
git branch -a --contains <commitID>

# 在所有git log中查找commit log
git log -a --grep="key words"

# 恢复某个文件
git log -n filename
```

## submodule
```
git submodule update --init
git submodule init
git submodule update
```
